//
//  DebugPingServices.m
//  Example_Category
//
//  Created by MCL on 16/9/21.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "DebugPingServices.h"

@implementation DPingItem

- (NSString *)description {
    switch (self.status) {
        case STDPingStatusDidStart:
            return [NSString stringWithFormat:@"PING %@ (%@): %ld data bytes",self.originalAddress, self.IPAddress, (long)self.dateBytesLength];
        case STDPingStatusDidReceivePacket:
            return [NSString stringWithFormat:@"%ld bytes from %@: icmp_seq=%ld ttl=%ld time=%.3f ms", (long)self.dateBytesLength, self.IPAddress, (long)self.ICMPSequence, (long)self.timeToLive, self.timeMilliseconds];
        case STDPingStatusDidTimeout:
            return [NSString stringWithFormat:@"Request timeout for icmp_seq %ld", (long)self.ICMPSequence];
        case STDPingStatusDidFailToSendPacket:
            return [NSString stringWithFormat:@"Fail to send packet to %@: icmp_seq=%ld", self.IPAddress, (long)self.ICMPSequence];
        case STDPingStatusDidReceiveUnexpectedPacket:
            return [NSString stringWithFormat:@"Receive unexpected packet from %@: icmp_seq=%ld", self.IPAddress, (long)self.ICMPSequence];
        case STDPingStatusError:
            return [NSString stringWithFormat:@"Can not ping to %@", self.originalAddress];
        default:
            break;
    }
    if (self.status == STDPingStatusDidReceivePacket) {
    }
    return super.description;
}

+ (NSString *)statisticsWithPingItems:(NSArray *)pingItems {
    //    --- ping statistics ---
    //    5 packets transmitted, 5 packets received, 0.0% packet loss
    //    round-trip min/avg/max/stddev = 4.445/9.496/12.210/2.832 ms
    NSString *address = [pingItems.firstObject originalAddress];
    __block NSInteger receivedCount = 0, allCount = 0;
    [pingItems enumerateObjectsUsingBlock:^(DPingItem *obj, NSUInteger idx, BOOL *stop) {
        if (obj.status != STDPingStatusFinished && obj.status != STDPingStatusError) {
            allCount ++;
            if (obj.status == STDPingStatusDidReceivePacket) {
                receivedCount ++;
            }
        }
    }];
    
    NSMutableString *description = [NSMutableString stringWithCapacity:50];
    [description appendFormat:@"--- %@ ping statistics ---\n", address];
    
    CGFloat lossPercent = (CGFloat)(allCount - receivedCount) / MAX(1.0, allCount) * 100;
    [description appendFormat:@"%ld packets transmitted, %ld packets received, %.1f%% packet loss\n", (long)allCount, (long)receivedCount, lossPercent];
    return [description stringByReplacingOccurrencesOfString:@".0%" withString:@"%"];
}
@end

@interface DebugPingServices () <SimplePingDelegate> {
    BOOL _hasStarted;
    BOOL _isTimeout;
    NSInteger   _repingTimes;
    NSInteger   _sequenceNumber;
    NSMutableArray *_pingItems;
}

@property(nonatomic, copy)   NSString   *address;
@property(nonatomic, strong) SimplePing *simplePing;

@property(nonatomic, strong)void(^callbackHandler)(DPingItem *item, NSArray *pingItems);

@end

@implementation DebugPingServices

+ (DebugPingServices *)startPingAddress:(NSString *)address
                      callbackHandler:(void(^)(DPingItem *item, NSArray *pingItems))handler {
    DebugPingServices *services = [[DebugPingServices alloc] initWithAddress:address];
    services.callbackHandler = handler;
    [services startPing];
    return services;
}

- (instancetype)initWithAddress:(NSString *)address {
    self = [super init];
    if (self) {
        self.timeoutMilliseconds = 500;
        self.maximumPingTimes = 100;
        self.address = address;
        self.simplePing = [[SimplePing alloc] initWithHostName:address];
        self.simplePing.addressStyle = SimplePingAddressStyleAny;
        self.simplePing.delegate = self;
        _pingItems = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

- (void)startPing {
    _repingTimes = 0;
    _hasStarted = NO;
    [_pingItems removeAllObjects];
    [self.simplePing start];
}

- (void)reping {
    [self.simplePing stop];
    [self.simplePing start];
}

- (void)_timeoutActionFired {
    DPingItem *pingItem = [[DPingItem alloc] init];
    pingItem.ICMPSequence = _sequenceNumber;
    pingItem.originalAddress = self.address;
    pingItem.status = STDPingStatusDidTimeout;
    [self.simplePing stop];
    [self _handlePingItem:pingItem];
}

- (void)_handlePingItem:(DPingItem *)pingItem {
    if (pingItem.status == STDPingStatusDidReceivePacket || pingItem.status == STDPingStatusDidTimeout) {
        [_pingItems addObject:pingItem];
    }
    if (_repingTimes < self.maximumPingTimes - 1) {
        if (self.callbackHandler) {
            self.callbackHandler(pingItem, [_pingItems copy]);
        }
        _repingTimes ++;
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(reping) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    } else {
        if (self.callbackHandler) {
            self.callbackHandler(pingItem, [_pingItems copy]);
        }
        [self cancel];
    }
}

- (void)cancel {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeoutActionFired) object:nil];
    [self.simplePing stop];
    DPingItem *pingItem = [[DPingItem alloc] init];
    pingItem.status = STDPingStatusFinished;
    [_pingItems addObject:pingItem];
    if (self.callbackHandler) {
        self.callbackHandler(pingItem, [_pingItems copy]);
    }
}

- (void)st_simplePing:(SimplePing *)pinger didStartWithAddress:(NSData *)address {
    NSData *packet = [pinger packetWithPingData:nil];
    if (!_hasStarted) {
        DPingItem *pingItem = [[DPingItem alloc] init];
        pingItem.IPAddress = pinger.IPAddress;
        pingItem.originalAddress = self.address;
        pingItem.dateBytesLength = packet.length - sizeof(ICMPHeader);
        pingItem.status = STDPingStatusDidStart;
        if (self.callbackHandler) {
            self.callbackHandler(pingItem, nil);
        }
        _hasStarted = YES;
    }
    [pinger sendPingWithData:packet];
    [self performSelector:@selector(_timeoutActionFired) withObject:nil afterDelay:self.timeoutMilliseconds / 1000.0];
}

// If this is called, the SimplePing object has failed.  By the time this callback is
// called, the object has stopped (that is, you don't need to call -stop yourself).

// IMPORTANT: On the send side the packet does not include an IP header.
// On the receive side, it does.  In that case, use +[SimplePing icmpInPacket:]
// to find the ICMP header within the packet.

- (void)st_simplePing:(SimplePing *)pinger didSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber {
    _sequenceNumber = sequenceNumber;
}

- (void)st_simplePing:(SimplePing *)pinger didFailToSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber error:(NSError *)error {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeoutActionFired) object:nil];
    _sequenceNumber = sequenceNumber;
    DPingItem *pingItem = [[DPingItem alloc] init];
    pingItem.ICMPSequence = _sequenceNumber;
    pingItem.originalAddress = self.address;
    pingItem.status = STDPingStatusDidFailToSendPacket;
    [self _handlePingItem:pingItem];
}

- (void)st_simplePing:(SimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeoutActionFired) object:nil];
    DPingItem *pingItem = [[DPingItem alloc] init];
    pingItem.ICMPSequence = _sequenceNumber;
    pingItem.originalAddress = self.address;
    pingItem.status = STDPingStatusDidReceiveUnexpectedPacket;
    //    [self _handlePingItem:pingItem];
}

- (void)st_simplePing:(SimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet timeToLive:(NSInteger)timeToLive sequenceNumber:(uint16_t)sequenceNumber timeElapsed:(NSTimeInterval)timeElapsed {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeoutActionFired) object:nil];
    DPingItem *pingItem = [[DPingItem alloc] init];
    pingItem.IPAddress = pinger.IPAddress;
    pingItem.dateBytesLength = packet.length;
    pingItem.timeToLive = timeToLive;
    pingItem.timeMilliseconds = timeElapsed * 1000;
    pingItem.ICMPSequence = sequenceNumber;
    pingItem.originalAddress = self.address;
    pingItem.status = STDPingStatusDidReceivePacket;
    [self _handlePingItem:pingItem];
}

- (void)st_simplePing:(SimplePing *)pinger didFailWithError:(NSError *)error {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeoutActionFired) object:nil];
    [self.simplePing stop];
    
    DPingItem *errorPingItem = [[DPingItem alloc] init];
    errorPingItem.originalAddress = self.address;
    errorPingItem.status = STDPingStatusError;
    if (self.callbackHandler) {
        self.callbackHandler(errorPingItem, [_pingItems copy]);
    }
    
    DPingItem *pingItem = [[DPingItem alloc] init];
    pingItem.originalAddress = self.address;
    pingItem.IPAddress = pinger.IPAddress ?: pinger.hostName;
    [_pingItems addObject:pingItem];
    pingItem.status = STDPingStatusFinished;
    if (self.callbackHandler) {
        self.callbackHandler(pingItem, [_pingItems copy]);
    }
}

@end

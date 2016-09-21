//
//  DebugPingServices.h
//  Example_Category
//
//  Created by MCL on 16/9/21.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimplePing.h"

typedef NS_ENUM(NSInteger, STDPingStatus) {
    STDPingStatusDidStart,
    STDPingStatusDidFailToSendPacket,
    STDPingStatusDidReceivePacket,
    STDPingStatusDidReceiveUnexpectedPacket,
    STDPingStatusDidTimeout,
    STDPingStatusError,
    STDPingStatusFinished,
};

@interface DPingItem : NSObject

@property(nonatomic) NSString *originalAddress;
@property(nonatomic, copy) NSString *IPAddress;

@property(nonatomic) NSUInteger dateBytesLength;
@property(nonatomic) double     timeMilliseconds;
@property(nonatomic) NSInteger  timeToLive;
@property(nonatomic) NSInteger  ICMPSequence;

@property(nonatomic) STDPingStatus status;

+ (NSString *)statisticsWithPingItems:(NSArray *)pingItems;

@end

@interface DebugPingServices : NSObject

/// 超时时间, default 500ms
@property(nonatomic) double timeoutMilliseconds;

@property(nonatomic) NSInteger  maximumPingTimes;

+ (DebugPingServices *)startPingAddress:(NSString *)address
                      callbackHandler:(void(^)(DPingItem *pingItem, NSArray *pingItems))handler;
- (void)cancel;

@end

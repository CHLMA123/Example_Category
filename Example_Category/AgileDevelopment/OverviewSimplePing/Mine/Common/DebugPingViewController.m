//
//  DebugPingViewController.m
//  Example_Category
//
//  Created by MACHUNLEI on 16/9/22.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "DebugPingViewController.h"
#import "SimplePing.h"

@interface DebugPingViewController ()<SimplePingDelegate>
{
    SimplePing *ping;
}
@end

@implementation DebugPingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self pingWiFiTest];
}

- (void)pingWiFiTest{

    ping = [[SimplePing alloc] initWithHostName:@"https://api.mycloudipc.com"];
    ping.delegate = self;
    ping.addressStyle = SimplePingAddressStyleAny;
    [ping start];
}

/**
 *  start成功，也就是准备工作做完后的回调
 */
- (void)simplePing:(SimplePing *)pinger didStartWithAddress:(NSData *)address{

    // 发送测试报文数据
    [pinger sendPingWithData:nil];
}

- (void)simplePing:(SimplePing *)pinger didFailWithError:(NSError *)error{

    NSLog(@"didFailWithError");

    [pinger stop];
}

// 发送测试报文成功的回调方法
- (void)simplePing:(SimplePing *)pinger didSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber{

    NSLog(@"#%u sent", sequenceNumber);
}

//发送测试报文失败的回调方法
- (void)simplePing:(SimplePing *)pinger didFailToSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber error:(NSError *)error{

    NSLog(@"#%u send failed: %@", sequenceNumber, error);
}

// 接收到ping的地址所返回的数据报文回调方法
- (void)simplePing:(SimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber{

    NSLog(@"#%u received, size=%zu", sequenceNumber, (unsigned long)packet.length);
}

- (void)simplePing:(SimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet{

    NSLog(@"#%s",__func__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

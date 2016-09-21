//
//  NSString+Extend.m
//  LocalNotifyDemo
//
//  Created by MCL on 16/9/19.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "NSString+Extend.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation NSString (Extend)

#pragma mark - SMTP服务器名称
- (BOOL)isValidateSettingPassWord
{
    NSString  *regexStr =@"^[-_a-zA-Z0-9]{1,20}$";
    return [self RegexCheck:regexStr];
}

- (BOOL)isValidSMTPServer{
    NSString *smtpServer = @"^[A-Za-z0-9@-_.]+$";
    return [self RegexCheck:smtpServer];
}

/**
 *  判断字符串是否符合正则表达式
 *
 * regexStr为需要满足的正则表达式
 *
 */
- (BOOL)RegexCheck:(NSString *)regexStr
{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[self substringWithRange:resultRange];
            //输出结果
            MSLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}

#pragma mark - wifiName
+ (NSString *)fetchWiFiName{
    NSArray *ifs = (__bridge_transfer NSArray *)CNCopySupportedInterfaces();
    if (!ifs) {
        return nil;
    }
    NSString *WiFiName = nil;
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) {
            // 这里其实对应的有三个key:kCNNetworkInfoKeySSID、kCNNetworkInfoKeyBSSID、kCNNetworkInfoKeySSIDData，
            // 不过它们都是CFStringRef类型的
            WiFiName = [info objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            //            WiFiName = [info objectForKey:@"SSID"];
            break;
        }
    }
    return WiFiName;
}

@end

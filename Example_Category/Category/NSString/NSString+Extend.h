//
//  NSString+Extend.h
//  LocalNotifyDemo
//
//  Created by MCL on 16/9/19.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)

- (BOOL)isValidateSettingPassWord;

- (BOOL)isValidSMTPServer;

+ (NSString *)fetchWiFiName;

@end

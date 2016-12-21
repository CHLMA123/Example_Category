//
//  CrashModel.m
//  Foscam
//
//  Created by JackChan on 2016/11/9.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import "CrashModel.h"

@interface CrashModel ()

@property (nonatomic, strong, readonly) NSDateFormatter *dateformatter;

/**
 崩溃时间
 */
@property (nonatomic, copy) NSDate *date;

/**
 崩溃时间格式化字符串
 */
@property (nonatomic, copy, readonly) NSString *dateSting;

/**
 崩溃线程名称
 */
@property (nonatomic, copy, readonly) NSString *threadName;

/**
 崩溃类型名称
 */
@property (nonatomic, copy, readonly) NSString *crashTypeName;

/**
 崩溃描述
 */
@property (nonatomic, copy, readonly) NSString *crashDescription;

@end

@implementation CrashModel

- (instancetype)init {
    if (self = [super init]) {
        _date = [NSDate date];
    }
    return self;
}

- (NSString *)description {
    return self.crashDescription;
}

- (NSString *)debugDescription {
    return self.crashDescription;
}

#pragma mark - Getter && Setter
- (NSDateFormatter *)dateformatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    });
    
    return formatter;
}

- (NSString *)dateSting {
    return [self.dateformatter stringFromDate:self.date];
}

- (NSString *)threadName {
    if ([[NSThread currentThread] isMainThread]) {
        return @"MainThread";
    } else {
        return [[NSThread currentThread] name];
    }
}

- (NSString *)crashTypeName {
    NSString *name = nil;
    switch (self.type) {
        case CrashException:
            name = @"CrashException";
            break;
        case CrashSignal:
            name = @"CrashSignal";
            break;
        default:
            name = @"Unkown";
            break;
    }
    return name;
}

- (NSString *)crashDescription {
    
    NSDictionary *appInfoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *APP_Version = [appInfoDic objectForKey:@"CFBundleShortVersionString"];
    //版本号：Bundle version: app build版本
    NSString *APP_Build = [appInfoDic objectForKey:@"CFBundleVersion"];
    //应用标识：Bundle identifier
    //NSString *bundleId = [appInfoDic objectForKey:@"CFBundleIdentifier"];
    //应用名称：Bundle display name
    NSString *APP_BundleName = [appInfoDic objectForKey:@"CFBundleDisplayName"];
    
    NSString *appVersion = [NSString stringWithFormat:@"%@_%@", APP_Version, APP_Build];
    NSString *desc = [NSString stringWithFormat:@"\nApp Name:%@\nApp Version:%@\niOS Version:%@\nTime:%@\nCrashType:%@\nReason:%@\nThreadName:%@\nStackSymbols:\n%@\n\n\n", APP_BundleName, appVersion, @(IOS_VERSION), self.dateSting, self.crashTypeName, self.reason, self.threadName, self.stackSymbols];
    return desc;
}

@end

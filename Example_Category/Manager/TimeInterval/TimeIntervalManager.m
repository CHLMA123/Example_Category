//
//  TimeIntervalManager.m
//  Foscam
//
//  Created by MCL on 2016/10/25.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import "TimeIntervalManager.h"

@interface TimeIntervalManager ()

@property (nonatomic, assign) double mBeginInterval;

@end

@implementation TimeIntervalManager

+ (instancetype)shareManager{

    static TimeIntervalManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[TimeIntervalManager alloc] init];
    });
    return manager;
}

- (void)beginInterval{

    _mBeginInterval = [[NSDate date] timeIntervalSince1970];
}

- (void)endIntervalWithTip:(NSString *)tipstring{

    NSTimeInterval endInterval = [[NSDate date] timeIntervalSince1970];
    NSLog(@"### add camera %@ 耗时:%f(s)",tipstring, (endInterval - _mBeginInterval));
    _mBeginInterval = endInterval;
}

/*
 NSTimeInterval beginInterval = [[NSDate date] timeIntervalSince1970];
 NSTimeInterval endInterval = [[NSDate date] timeIntervalSince1970];
 NSLog(@"### 耗时:%f(s)", (endInterval - beginInterval));
 */

@end

//
//  TimeIntervalManager.h
//  Foscam
//
//  Created by MCL on 2016/10/25.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeIntervalManager : NSObject

+ (instancetype)shareManager;

/**
    方法开始执行的时间点
 */
- (void)beginInterval;

/**
    方法结束执行的时间点
 */
- (void)endIntervalWithTip:(NSString *)tipstring;

@end

//
//  NSDate+Calendar.h
//  Foscam
//
//  Created by JackChan on 16/8/5.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

- (NSDate *)previousDay;
- (NSDate *)nextDay;

- (NSDate *)previousMonth;
- (NSDate *)nextMonth;

/**
 * 当前日期是否早于今日
 * @return 返回比较结果
 */
- (BOOL)earlierThanToday;

/**
 * 获取当前月份的天数
 */
- (NSInteger)daysInMonth;

/**
 * 获取当前月份第一天是星期几
 */
- (NSInteger)firstWeekday;

/**
 * 获取某一天的UTC时间
 * @param iDate 具体时间，格式为yyyyMMdd
 */
+ (NSInteger)timeIntervalFromDate:(NSInteger)iDate;

@end

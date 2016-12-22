//
//  NSDate+Calendar.m
//  Foscam
//
//  Created by JackChan on 16/8/5.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)

- (NSDate *)previousDay {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [NSDateComponents new];
    components.day = -1;
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    
    return date;
}

- (NSDate *)nextDay {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [NSDateComponents new];
    components.day = 1;
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    
    return date;
}

- (NSDate *)previousMonth {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [NSDateComponents new];
    components.month = -1;
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    
    return date;
}

- (NSDate *)nextMonth {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [NSDateComponents new];
    components.month = 1;
    NSDate *date = [calendar dateByAddingComponents:components toDate:self options:0];
    
    return date;
}

- (BOOL)earlierThanToday {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components1 = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    NSDateComponents *components2 = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    
    NSDate *date = [calendar dateFromComponents:components1];
    NSDate *todayDate = [calendar dateFromComponents:components2];
    
    return (NSOrderedAscending == [date compare:todayDate]);
}

- (NSInteger)daysInMonth {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}

- (NSInteger)firstWeekday {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:self];
    components.day = 1;
    
    NSDate *firstDay = [calendar dateFromComponents:components];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:firstDay];
    
    NSInteger weekDay = firstComponents.weekday;
    return weekDay;
}

+ (NSInteger)timeIntervalFromDate:(NSInteger)iDate {
    
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        [dateFormatter setDateFormat:@"yyyyMMdd"];
    });
    
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld", iDate]];
    return [date timeIntervalSince1970];
}

@end

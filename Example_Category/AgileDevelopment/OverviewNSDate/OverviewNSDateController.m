//
//  OverviewNSDateController.m
//  Example_Category
//
//  Created by MACHUNLEI on 16/9/23.
//  Copyright © 2016年 MCL. All rights reserved.
//  Objective-C学习之 NSDate简单使用

#import "OverviewNSDateController.h"

@interface OverviewNSDateController ()

@end

@implementation OverviewNSDateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupData];
    
}

- (void)setupData{
    
//    [self setupData0];// NSDate初始化
//    [self setupData1];// NSDate与NSString的转换
//    [self setupDate2];// NSTimeInterval 是一个以秒为单位的时间片。
//    [self setupDate3];// NSTimeZone
//    [self setupDate4];// NSDateComponents获取
    [self setupDate5];// NSDateFormatter格式化参数
    [self setupDate6];
}

#pragma mark - NSDate初始化
- (void)setupData0{

    // 1 获取当前日期 iOS默认的NSDate是格林尼治时间，比中国时区的时间少8个小时
    NSDate *date = [NSDate date];
    NSLog(@"当前时间 date = %@",date);
    //当前时间 date = 2016-10-24 01:32:49 +0000
    
//    date = [NSDate dateWithTimeInterval:3600 sinceDate:[NSDate date]];
//    NSLog(@"当前时间 往后3600s的时间date = %@",date);
//    //当前时间 往后3600s的时间date = 2016-10-24 02:35:20 +0000
    
    NSTimeZone *timezone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timezone secondsFromGMTForDate:[NSDate date]];
    NSLog(@"当前时间secondsFromGMTForDate interval = %ld",(long)interval);
    //当前时间secondsFromGMTForDate interval = 28800
    
    NSDate *localdate = [date dateByAddingTimeInterval:interval];
    NSLog(@"当前时间 localdate = %@",localdate);
    //当前时间 localdate = 2016-10-24 09:41:08 +0000
}

#pragma mark - NSDate与NSString的转换
- (void)setupData1{
    
    // iOS开发时间控件怎么强制24小时制
    // eg1:
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // 这里是用大写的 H 24小时制
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@" H 24小时制 dateString = %@", dateString);
    //  H 24小时制 dateString = 2016-10-24 09:52:12
    
    // eg2:
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"]; // 这里是用大写的 h 12小时制
    NSString *dateString2 = [dateFormatter stringFromDate:date];
    NSLog(@" h 12小时制 dateString2 = %@", dateString2);
    //  h 12小时制 dateString2 = 2016-10-24 09:52:12
    
    // eg3:
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    NSString *dateString3 = [dateFormatter stringFromDate:date];
    NSLog(@" NSDateFormatterMediumStyle dateString3 = %@", dateString3);
    // NSDateFormatterMediumStyle dateString3 = Oct 24, 2016, 10:56:30 AM
    // NSDateFormatterShortStyle dateString4 = 10/24/16, 10:58 AM
    // NSDateFormatterLongStyle dateString5 = October 24, 2016 at 10:59:22 AM GMT+8
    
    // eg4:
    dateFormatter.dateStyle = NSDateFormatterFullStyle;
    dateFormatter.timeStyle = NSDateFormatterFullStyle;
    NSString *dateString6 = [dateFormatter stringFromDate:date];
    NSLog(@" NSDateFormatterFullStyle dateString6 = %@", dateString6);
    // NSDateFormatterFullStyle dateString6 = Monday, October 24, 2016 at 11:00:10 AM China Standard Time
}

#pragma mark - NSTimeInterval 是一个以秒为单位的时间片。
- (void)setupDate2{

    NSDate *tomorrow = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]];
    NSLog(@"当前时间 tomorrow = %@",tomorrow);
    // 当前时间 tomorrow = 2016-10-25 01:52:12 +0000
    
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-24*60*60];
    NSLog(@"当前时间 yesterday = %@",yesterday);
    // 当前时间 yesterday = 2016-10-23 01:56:31 +0000
    
    NSDate *now = [NSDate date];
    NSDate *anHourAgo = [now dateByAddingTimeInterval:-60*60];
    NSDate *anHourAfter = [now dateByAddingTimeInterval:60*60];
    NSLog(@"当前时间 anHourAgo = %@, anHourAfter = %@",anHourAgo, anHourAfter);
    // 当前时间 anHourAgo = 2016-10-24 00:57:49 +0000, anHourAfter = 2016-10-24 02:57:49 +0000
}

#pragma mark - NSTimeZone
- (void)setupDate3{
    
    NSTimeZone *syszone = [NSTimeZone systemTimeZone];
    NSTimeZone *localzone = [NSTimeZone localTimeZone];
    NSTimeZone *defaltzone = [NSTimeZone defaultTimeZone];
    NSLog(@"当前时间\n syszone = %@,\n localzone = %@,\n defaltzone = %@",syszone, localzone, defaltzone);
    /*
     当前时间
     syszone = Asia/Shanghai (GMT+8) offset 28800,
     localzone = Local Time Zone (Asia/Shanghai (GMT+8) offset 28800),
     defaltzone = Asia/Shanghai (GMT+8) offset 28800
     */
    
    /*
     The seconds between local time and GMT time.
     Daylight saving time.
     0 - 12 hours        1- 24 hours.
     */
    NSDate *now = [NSDate date];
    NSInteger intervalfromGMT = [localzone secondsFromGMTForDate:now];
    NSTimeInterval intervaldaylight = [localzone daylightSavingTimeOffsetForDate:now];
    NSInteger distanceinterval = intervalfromGMT - intervaldaylight;
    NSTimeZone *correctzone = [NSTimeZone timeZoneForSecondsFromGMT:distanceinterval];
    NSLog(@"夏令时间 distanceinterval = %ld",(long)distanceinterval);
    NSLog(@"----- correctzone = %@",correctzone);
    // 夏令时间 distanceinterval = 28800
    // ----- correctzone = GMT+0800 (GMT+8) offset 28800
    
    NSDate *future = [NSDate distantFuture];
    NSDate *past = [NSDate distantPast];
    NSLog(@"当前时间\n future = %@,\n past = %@",future, past);
    /*
     当前时间
     future = 4001-01-01 00:00:00 +0000,
     past = 0000-12-30 00:00:00 +0000
     */
    NSTimeInterval interval1970 = [now timeIntervalSince1970];
    NSLog(@"当前时间 interval1970 = %f",interval1970);
    // 当前时间 interval1970 = 1477277438.044444
}

#pragma mark - NSDateComponents获取
- (void)setupDate4{
    
    // 1.NSDateFormat获取
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    [formatter setDateFormat:@"yyyy"];
    NSInteger currentYear=[[formatter stringFromDate:[NSDate date]] integerValue];
    [formatter setDateFormat:@"MM"];
    NSInteger currentMonth=[[formatter stringFromDate:[NSDate date]]integerValue];
    [formatter setDateFormat:@"dd"];
    NSInteger currentDay=[[formatter stringFromDate:[NSDate date]] integerValue];
    
    NSLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld",[NSDate date],currentYear,currentMonth,currentDay);
    // currentDate = 2016-10-24 03:15:29 +0000 ,year = 2016 ,month=10, day=24
    
    // 2.NSDateComponents获取
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentcalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [currentcalendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSInteger year=[components year];
    NSInteger month=[components month];
    NSInteger day=[components day];
    NSLog(@"currentDate = %@ ,year = %ld ,month=%ld, day=%ld",currentDate,year,month,day);
    // currentDate = 2016-10-24 03:06:48 +0000 ,year = 2016 ,month=10, day=24
    
}

#pragma mark - NSDateFormatter格式化参数
/*
 G: 公元时代，例如AD公元
 yy: 年的后2位
 yyyy: 完整年
 MM: 月，显示为1-12
 MMM: 月，显示为英文月份简写,如 Jan
 MMMM: 月，显示为英文月份全称，如 Janualy
 dd: 日，2位数表示，如02
 d: 日，1-2位显示，如 2
 EEE: 简写星期几，如Sun
 EEEE: 全写星期几，如Sunday
 aa: 上下午，AM/PM
 H: 时，24小时制，0-23
 K：时，12小时制，0-11
 m: 分，1-2位
 mm: 分，2位
 s: 秒，1-2位
 ss: 秒，2位
 S: 毫秒
 */
- (void)setupDate5{
    
}

#pragma mark -
- (void)setupDate6{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//NSDate转NSString
+ (NSString *)stringFromDate:(NSDate *)date
{
    //获取系统当前时间
    NSDate *currentDate = [NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    //NSDate转NSString
    NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
    //输出currentDateString
    NSLog(@"%@",currentDateString);
    return currentDateString;
}

//NSString转NSDate
+ (NSDate *)dateFromString:(NSString *)string
{
    //需要转换的字符串
    NSString *dateString = @"2015-06-26 08:08:08";
    //设置转换格式
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:dateString];
    return date;
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

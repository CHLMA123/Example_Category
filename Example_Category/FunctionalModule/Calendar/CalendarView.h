//
//  CalendarView.h
//  Foscam
//
//  Created by JackChan on 16/8/1.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalendarView;

/**
 * 日历风格
 */
typedef NS_ENUM(NSInteger, CalendarViewStyle) {
    CalendarViewDark,                               // 深色
    CalendarViewLight,                              // 浅色
    CalendarViewDefault     = CalendarViewDark,     // 默认深色
};

@protocol CalendarViewDelegate <NSObject>

@optional
/**
 * 查询日期是否存在录像
 * @param iDate 查询日期
 * @note iDate 格式为yyyyMMdd
 */
- (BOOL)calendarView:(CalendarView *)calendarView hasDataInDate:(NSInteger)iDate;

/**
 * 选中存在数据的日期结果回掉
 * @param date 选中日期
 */
- (void)calendarView:(CalendarView *)calendarView didSelectDate:(NSInteger)iDate;

@end

@interface CalendarView : UIView

/**
 * 初始化方法
 * @param style 当前日历类型
 */
- (instancetype)initWithStyle:(CalendarViewStyle)style;

/**
 * 设置日历所在月份的NSDate对象
 * @param date 当前日期
 */
- (void)setDate:(NSDate *)date;

/**
 * 刷新日历控件
 */
- (void)reload;

/**
 * 禁用关闭按钮
 */
@property (nonatomic, assign) BOOL disableCloseButton;

/**
 * delegate
 */
@property (nonatomic, weak) id<CalendarViewDelegate> delegate;

@property (nonatomic, assign) BOOL pbVideoCalender;

@end

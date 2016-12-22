//
//  DatePickerView.h
//  Foscam
//
//  Created by JackChan on 16/8/1.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 日期选择的类型
 */
typedef NS_ENUM(NSInteger, DatePickerTypes) {
    DatePickerByDay,    // 天
    DatePickerByMonth,  // 月
};

/**
 * 日期选择器风格
 */
typedef NS_ENUM(NSInteger, DatePickerStyle) {
    DatePickerDark,                     // 深色
    DatePickerLight,                    // 浅色
    DatePickerDefault = DatePickerDark, // 默认深色
};

/**
 * 日期选择的按钮
 */
typedef NS_ENUM(NSInteger, DatePickerOperations) {
    DatePickerLast,     // 前
    DatePickerNext,     // 后
};

@class DatePickerView;

@protocol DatePickerViewDelegate <NSObject>

@required
/**
 * 日期改变
 */
- (void)datePickerView:(DatePickerView *)datePicker didChangeDate:(NSDate *)date;

@optional
/**
 * 左右按钮是否可点击
 */
- (BOOL)datePickerView:(DatePickerView *)datePicker disableOperation:(DatePickerOperations)operation withSelectDate:(NSDate *)date;

/**
 * 点击日期按钮
 */
- (void)datePickerView:(DatePickerView *)datePicker didTapButtonWithDate:(NSDate *)date;

@end

@interface DatePickerView : UIView

/**
 * 初始化方法
 * @param style 选择器风格
 * @param type 选择器类型
 */
- (instancetype)initWithStyle:(DatePickerStyle)style type:(DatePickerTypes)type;

/**
 * 初始化方法
 * @param type 选择器类型
 * @note 默认为当前日期
 */
- (instancetype)initWithType:(DatePickerTypes)type;

/**
 * 设置当前日期
 */
- (void)setDate:(NSDate *)date;

/**
 * 代理
 */
@property (nonatomic, weak) id<DatePickerViewDelegate> delegate;

@end

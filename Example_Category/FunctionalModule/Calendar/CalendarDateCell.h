//
//  CalendarDateCell.h
//  Foscam
//
//  Created by JackChan on 16/8/3.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CalendarDateCellStyle) {
    CalendarDateCellDark,                           // 深色
    CalendarDateCellLight,                          // 浅色
    CalendarDateCellDefault = CalendarDateCellDark, // 默认深色
};

typedef NS_OPTIONS(NSInteger, CalendarDateFlags) {
    CalendarDateNone            = 0x01 << 0,    // 无
    CalendarDateCurrentMonth    = 0x01 << 1,    // 当前月
    CalendarDateHasData         = 0x01 << 2,    // 存在数据
    CalendarDateIsToday         = 0x01 << 3,    // 是今天
    CalendarDateSelected        = 0x01 << 4,    // 被选中
};

@interface CalendarDateCell : UICollectionViewCell

/**
 * Cell 的类型
 */
@property (nonatomic, assign) CalendarDateCellStyle style;

/**
 * 当前日期
 */
@property (nonatomic, assign) NSInteger date;

/**
 * 当前日期的标识
 */
@property (nonatomic, assign) CalendarDateFlags flags;

/**
 * 当前CollectionView
 */
@property (nonatomic, weak) UICollectionView *collectionView;

@end

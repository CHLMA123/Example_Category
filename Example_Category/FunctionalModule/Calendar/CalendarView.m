//
//  CalendarView.m
//  Foscam
//
//  Created by JackChan on 16/8/1.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import "CalendarView.h"
#import "DatePickerView.h"
#import "CalendarWeekCell.h"
#import "CalendarDateCell.h"
#import "NSDate+Calendar.h"
#import "Masonry.h"

static CGFloat const kSpacing = 8; // 间隔空隙
static NSInteger const kDaysOfOneWeek = 7; // 一周的天数
static NSString * const kDateCellID = @"DateCellID";
static NSString * const kWeekCellID = @"WeekCellID";

@interface DateModel : NSObject

/**
 * 当前日期
 * @note 格式 yyyy-MM-dd
 */
@property (nonatomic, assign) NSInteger date;

/**
 * 当前日期是否存在数据
 */
@property (nonatomic, assign) BOOL hasData;

/**
 * 是否是当前月份
 */
@property (nonatomic, assign, getter=isCurrentMonth) BOOL currentMonth;

@end

@implementation DateModel

@end

@interface CalendarView () <DatePickerViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) CalendarViewStyle style;

@property (nonatomic, strong) DatePickerView *datePicker;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) UICollectionViewFlowLayout *weekFlowLayout;

@property (nonatomic, strong) UICollectionView *weekCollectionView;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *weekArray; // Of NSString

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) NSDate *currentDate; // 当前日期

@property (nonatomic, assign) NSInteger iToday; // 今日日期整数格式为yyyyMMdd

@property (nonatomic, assign) NSInteger iSelectedDate; // 被选中的日期(仅一天可选中，默认今日)

@property (nonatomic, strong, readonly) NSDateFormatter *dateFormatter; // 日期格式

@end

@implementation CalendarView {
    struct {
        unsigned hasDataInDate: 1;
        unsigned didSelectDate: 1;
    } _delegateHas;
}

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(CalendarViewStyle)style {
    if (self = [super init]) {
        _style = style;
        [self initializer]; // 初始化
    }
    return self;
}

- (void)initializer {
    
    self.backgroundColor = RGBCOLOR(48, 48, 64); // 默认背景颜色
    [self addSubview:self.closeButton];
    [self addSubview:self.datePicker];
    [self addSubview:self.weekCollectionView];
    [self addSubview:self.collectionView];
    
    _currentDate = [NSDate date]; // 默认当前日期
    _iToday = [[self.dateFormatter stringFromDate:_currentDate] integerValue]; // 今天
    _iSelectedDate = _iToday; // 默认今天选中
    
    [self fetchData];
}

- (void)layoutSubviews {
    
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 15, -20, -15);
    
    [self.datePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(padding.top);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, 25));
    }];
    
    [self.closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.right.offset(-5);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.weekCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.datePicker.mas_bottom).offset(padding.top);
        make.left.equalTo(self).offset(padding.left);
        make.right.equalTo(self).offset(padding.right);
        make.height.mas_equalTo(32);
    }];
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weekCollectionView.mas_bottom);
        make.left.right.equalTo(self.weekCollectionView);
        make.bottom.equalTo(self).offset(-10);
    }];
}

#pragma mark - Public Methods
- (void)reload {
    [self fetchData];
    _iSelectedDate = [[self.dateFormatter stringFromDate:_currentDate] integerValue]; // 设置date为选中日期
    [self.datePicker setDate:_currentDate]; // 设置日期选择器时间
}

- (void)setDate:(NSDate *)date {
    _currentDate = date; // 设置当前日期
}

#pragma mark - DatePickerViewDelegate
- (void)datePickerView:(DatePickerView *)datePicker didChangeDate:(NSDate *)date {
    _currentDate = date;
    [self fetchData];
}

- (void)datePickerView:(DatePickerView *)datePicker didTapButtonWithDate:(NSDate *)date {
    // 处理月份按钮点击
    if (!_disableCloseButton) {
        [self dismiss];
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == self.weekCollectionView) {
        return kDaysOfOneWeek;
    } else if (collectionView == self.collectionView) {
        return [self.dataSource count];
    } else {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView == self.weekCollectionView) {
        CalendarWeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWeekCellID forIndexPath:indexPath];
        cell.label.text = self.weekArray[indexPath.row];
        cell.label.textColor = (CalendarViewDark == _style) ? (RGBCOLOR(176, 176, 199)) : (RGBCOLOR(81, 88, 91));
        return cell;
        
    } else if (collectionView == self.collectionView) {
        CalendarDateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kDateCellID forIndexPath:indexPath];
        
        DateModel *model = self.dataSource[indexPath.row];
        CalendarDateFlags flags = CalendarDateNone;
        
        // 设置相关属性
        if (model.isCurrentMonth) {flags |= CalendarDateCurrentMonth;}
        if (model.hasData) {flags |= CalendarDateHasData;}
        if (_iToday == model.date) {flags |= CalendarDateIsToday;}
        if (_iSelectedDate == model.date) {flags |= CalendarDateSelected;}
        
        cell.style = (CalendarViewLight == _style) ? (CalendarDateCellLight) : (CalendarDateCellDark);
        cell.date = model.date;
        cell.flags = flags;
        cell.collectionView = collectionView;
        
        return cell;
        
    } else {
        return nil;
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.collectionView) {
        DateModel *model = self.dataSource[indexPath.row];
        
        // 设置选中结果，刷新日历
        _iSelectedDate = model.date;
        [collectionView reloadData];
        NSDate *date = [self.dateFormatter dateFromString:[NSString stringWithFormat:@"%ld", (long)model.date]];
        
        if (self.pbVideoCalender) {
//            [self dismiss]; // 关闭日历
            if (_delegateHas.didSelectDate) {
                [_delegate calendarView:self didSelectDate:_iSelectedDate];
            }
        }else{
        
            if (model.hasData) { // 选中日期是否存在数据
                [self dismiss]; // 关闭日历
                if (_delegateHas.didSelectDate) {
                    [_delegate calendarView:self didSelectDate:_iSelectedDate];
                }
            } else if (!model.isCurrentMonth) { // 是否是当前月
                
                _currentDate = date; // 设置当前日期为选中日期
                [self reload]; // 刷新
            }
        }
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat itemWidth = (CGRectGetWidth(self.frame) - (kDaysOfOneWeek + 1) * kSpacing - 20) / kDaysOfOneWeek;
    CGSize itemSize = CGSizeMake(itemWidth, itemWidth * 0.8);
    return itemSize;
}

#pragma mark - Private Methods
- (void)fetchData {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *lastMonth = [_currentDate previousMonth];
    NSDate *nextMonth = [_currentDate nextMonth];
    
    NSDateComponents *compoentsInThisMonth = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:_currentDate];
    NSDateComponents *compoentsInLastMonth = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:lastMonth];
    NSDateComponents *compoentsInNextMonth = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:nextMonth];
    
    // 获取上月天数
    NSInteger daysInLastMonth = [lastMonth daysInMonth];
    // 获取当前月的天数
    NSInteger daysInMonth = [_currentDate daysInMonth];
    // 获取当前月第一天是星期几
    NSInteger firstWeekDay = [_currentDate firstWeekday];
    
    // 当前月需要展示完全的周数
    NSInteger weeks = (daysInMonth + firstWeekDay - 1 + 6) / kDaysOfOneWeek;
    NSInteger year, month, day;
    
    NSMutableArray *mutableArray = [NSMutableArray new];
    for (NSInteger i = 0; i != kDaysOfOneWeek * weeks; ++ i) {
        
        DateModel *model = [DateModel new];
        
        if (i < firstWeekDay - 1) {
            year = compoentsInLastMonth.year;
            month = compoentsInLastMonth.month;
            day = daysInLastMonth - (firstWeekDay - 1) + 1 + i;
            model.currentMonth = NO;
        } else if (i >= daysInMonth + firstWeekDay - 1){
            year = compoentsInNextMonth.year;
            month = compoentsInNextMonth.month;
            day = i - (daysInMonth + firstWeekDay - 1) + 1;
            model.currentMonth = NO;
        } else {
            year = compoentsInThisMonth.year;
            month = compoentsInThisMonth.month;
            day = i - (firstWeekDay - 1) + 1;
            model.currentMonth = YES;
        }
        
        NSInteger iDate = [[NSString stringWithFormat:@"%04ld%02ld%02ld", year, month, day] integerValue];
        model.date = iDate;
        model.hasData = (_delegateHas.hasDataInDate) ? ([_delegate calendarView:self hasDataInDate:iDate]) : (NO);
        [mutableArray addObject:model];
    }
    
    _dataSource = mutableArray.copy; // 重新设置数据源
    [self.collectionView reloadData];// 刷新视图
}

- (void)dismiss {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGRect finalRect = CGRectOffset(self.frame, width, 0);
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.frame = finalRect;
        } completion:^(BOOL finished) {
            [self.closeButton.layer removeAllAnimations];
            [self removeFromSuperview];
        }];
    });
}

#pragma mark - Event Response
- (void)closeButtonTapped:(UIButton *)sender {
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.fromValue = [NSNumber numberWithFloat:M_PI * 0];
    basicAnimation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    basicAnimation.duration = 0.25;
    basicAnimation.repeatCount = 1;
    basicAnimation.removedOnCompletion = NO;
    [sender.layer addAnimation:basicAnimation forKey:@"transform.rotation.z"];
    if (self.pbVideoCalender) {
        
        [_delegate calendarView:self didSelectDate:-1];
    }else{
    
        [self dismiss];
    }
}

#pragma mark - Getter && Setter
- (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyyMMdd"];
    });
    return formatter;
}

- (void)setDelegate:(id<CalendarViewDelegate>)delegate {
    _delegate = delegate;
    
    _delegateHas.hasDataInDate = [delegate respondsToSelector:@selector(calendarView:hasDataInDate:)];
    _delegateHas.didSelectDate = [delegate respondsToSelector:@selector(calendarView:didSelectDate:)];
    
    [self setNeedsLayout];
}

- (void)setDisableCloseButton:(BOOL)disableCloseButton {
    _disableCloseButton = disableCloseButton;
    self.closeButton.hidden = _disableCloseButton;
}

- (DatePickerView *)datePicker {
    if (!_datePicker) {
        DatePickerStyle style = (CalendarViewLight == _style) ? DatePickerLight : DatePickerDark;
        _datePicker = [[DatePickerView alloc] initWithStyle:style type:DatePickerByMonth];
        _datePicker.delegate = self;
    }
    return _datePicker;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"calendar_close_nor"] forState:UIControlStateNormal];
        [_closeButton setBackgroundImage:[UIImage imageNamed:@"calendar_close_press"] forState:UIControlStateHighlighted];
        [_closeButton addTarget:self action:@selector(closeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [UICollectionViewFlowLayout new];
        _flowLayout.minimumLineSpacing = kSpacing;
        _flowLayout.minimumInteritemSpacing = kSpacing;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _flowLayout;
}

- (UICollectionViewFlowLayout *)weekFlowLayout {
    if (!_weekFlowLayout) {
        _weekFlowLayout = [UICollectionViewFlowLayout new];
        _weekFlowLayout.minimumLineSpacing = kSpacing;
        _weekFlowLayout.minimumInteritemSpacing = kSpacing;
        _weekFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _weekFlowLayout;
}

- (UICollectionView *)weekCollectionView {
    if (!_weekCollectionView) {
        _weekCollectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.weekFlowLayout];
        _weekCollectionView.dataSource = self;
        _weekCollectionView.delegate = self;
        _weekCollectionView.scrollEnabled = NO;
        _weekCollectionView.showsVerticalScrollIndicator = NO;
        _weekCollectionView.backgroundColor = [UIColor clearColor];
        [_weekCollectionView registerClass:[CalendarWeekCell class] forCellWithReuseIdentifier:kWeekCellID];
    }
    return _weekCollectionView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:self.flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[CalendarDateCell class] forCellWithReuseIdentifier:kDateCellID];
    }
    return _collectionView;
}

- (NSArray *)weekArray {
    if (!_weekArray) {
        _weekArray = @[FSLocalizedString(@"FS_Video_Calendar_Sun"),FSLocalizedString(@"FS_Video_Calendar_Mon"),
                       FSLocalizedString(@"FS_Video_Calendar_Tue"),FSLocalizedString(@"FS_Video_Calendar_Wed"),
                       FSLocalizedString(@"FS_Video_Calendar_Thu"),FSLocalizedString(@"FS_Video_Calendar_Fri"),
                       FSLocalizedString(@"FS_Video_Calendar_Sat")
                       ];
    }
    return _weekArray;
}

@end

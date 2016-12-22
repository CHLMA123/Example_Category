//
//  DatePickerView.m
//  Foscam
//
//  Created by JackChan on 16/8/1.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import "DatePickerView.h"
#import "NSDate+Calendar.h"
#import "Masonry.h"

@interface DatePickerView ()

// 前按钮
@property (nonatomic, strong) UIButton *lastButton;

// 后按钮
@property (nonatomic, strong) UIButton *nextButton;

// 日期显示按钮
@property (nonatomic, strong) UIButton *dateButton;

// 当前日期数据
@property (nonatomic, strong) NSDate *currentDate;

// 选择器类型
@property (nonatomic, assign) DatePickerTypes type;

// 选择器风格
@property (nonatomic, assign) DatePickerStyle style;

// 当前日期字符串
@property (nonatomic, strong, readonly) NSString *dateTitle;

@end

@implementation DatePickerView

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(DatePickerStyle)style type:(DatePickerTypes)type {
    if (self = [super init]) {
        _currentDate = [NSDate date]; // 默认当前日期
        _style = style;
        _type = type;
        [self initializer];
    }
    return self;
}

- (instancetype)initWithType:(DatePickerTypes)type {
    return [self initWithStyle:DatePickerDefault type:type];
}

- (void)initializer {
    [self addSubview:self.dateButton];
    [self addSubview:self.lastButton];
    [self addSubview:self.nextButton];
    
    [self updateView];
}

- (void)layoutSubviews {
    
    [self.dateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(89, 32));
    }];
    
    [self.lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dateButton);
        make.right.equalTo(self.dateButton.mas_left);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lastButton);
        make.left.equalTo(self.dateButton.mas_right);
        make.size.equalTo(self.lastButton);
    }];
}

#pragma mark - Event Response
- (void)lastButtonTapped:(UIButton *)sender {
    
    if (DatePickerByDay == _type) {
        _currentDate = [_currentDate previousDay];
    } else if (DatePickerByMonth == _type) {
        _currentDate = [_currentDate previousMonth];
    }
    
    [self updateView];
    [self didChangeDate];
}

- (void)nextButtonTapped:(UIButton *)sender {
    
    if (DatePickerByDay == _type) {
        _currentDate = [_currentDate nextDay];
    } else if (DatePickerByMonth == _type) {
        _currentDate = [_currentDate nextMonth];
    }
    
    [self updateView];
    [self didChangeDate];
}

- (void)dateButtonTapped:(UIButton *)sender {
    
    if ([_delegate respondsToSelector:@selector(datePickerView:didTapButtonWithDate:)]) {
        [_delegate datePickerView:self didTapButtonWithDate:_currentDate];
    }
}

#pragma mark - Private Methods
- (void)updateView {
    
    // 更新dateButton的文本内容
    NSString *title = self.dateTitle;
    [self.dateButton setTitle:title forState:UIControlStateNormal];
    
    // 更新左右按钮是否可点击
    if ([_delegate respondsToSelector:@selector(datePickerView:disableOperation:withSelectDate:)]) {
        self.lastButton.enabled = [_delegate datePickerView:self disableOperation:DatePickerLast withSelectDate:_currentDate];
        self.nextButton.enabled = [_delegate datePickerView:self disableOperation:DatePickerNext withSelectDate:_currentDate];
    }
}

- (void)didChangeDate {
    
    if ([_delegate respondsToSelector:@selector(datePickerView:didChangeDate:)]) {
        [_delegate datePickerView:self didChangeDate:_currentDate];
    }
}

#pragma mark - Getter && Setter
- (void)setDelegate:(id<DatePickerViewDelegate>)delegate {
    _delegate = delegate;
    [self updateView];
}

- (void)setDate:(NSDate *)date {
    _currentDate = date; // 设置当前日期
    [self updateView]; // 刷新
}

- (NSString *)dateTitle {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:_currentDate];
    
    NSString *title = nil;
    if (DatePickerByDay == _type) {
        title = [NSString stringWithFormat:@"%04ld-%02ld-%02ld", components.year, components.month, components.day];
    } else if (DatePickerByMonth == _type) {
        title = [NSString stringWithFormat:@"%04ld-%02ld", components.year, components.month];
    }
    
    return title;
}

- (UIButton *)lastButton {
    if (!_lastButton) {
        _lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lastButton addTarget:self action:@selector(lastButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        if (DatePickerLight == _style) {
            [_lastButton setImage:[UIImage imageNamed:@"date_leftarrow_light_nor"] forState:UIControlStateNormal];
            [_lastButton setImage:[UIImage imageNamed:@"date_leftarrow_light_press"] forState:UIControlStateHighlighted];
            [_lastButton setImage:[UIImage imageNamed:@"date_leftarrow_light_disable"] forState:UIControlStateDisabled];
        } else {
            [_lastButton setImage:[UIImage imageNamed:@"date_leftarrow_dark_nor"] forState:UIControlStateNormal];
            [_lastButton setImage:[UIImage imageNamed:@"date_leftarrow_dark_press"] forState:UIControlStateHighlighted];
            [_lastButton setImage:[UIImage imageNamed:@"date_leftarrow_dark_disable"] forState:UIControlStateDisabled];
        }
    }
    return _lastButton;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton addTarget:self action:@selector(nextButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        if (DatePickerLight == _style) {
            [_nextButton setImage:[UIImage imageNamed:@"date_rightarrow_light_nor"] forState:UIControlStateNormal];
            [_nextButton setImage:[UIImage imageNamed:@"date_rightarrow_light_press"] forState:UIControlStateHighlighted];
            [_nextButton setImage:[UIImage imageNamed:@"date_rightarrow_light_disable"] forState:UIControlStateDisabled];
        } else {
            [_nextButton setImage:[UIImage imageNamed:@"date_rightarrow_dark_nor"] forState:UIControlStateNormal];
            [_nextButton setImage:[UIImage imageNamed:@"date_rightarrow_dark_press"] forState:UIControlStateHighlighted];
            [_nextButton setImage:[UIImage imageNamed:@"date_rightarrow_dark_disable"] forState:UIControlStateDisabled];
        }
    }
    return _nextButton;
}

- (UIButton *)dateButton {
    if (!_dateButton) {
        _dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dateButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_dateButton addTarget:self action:@selector(dateButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        if (DatePickerLight == _style) {
            [_dateButton setTitleColor:RGBCOLOR(81, 88, 89) forState:UIControlStateNormal];
            [_dateButton setTitleColor:RGBCOLOR(176, 176, 199) forState:UIControlStateHighlighted];
        } else {
            [_dateButton setTitleColor:RGBCOLOR(176, 176, 199) forState:UIControlStateNormal];
            [_dateButton setTitleColor:RGBCOLOR(72, 72, 92) forState:UIControlStateHighlighted];
        }
    }
    return _dateButton;
}

@end

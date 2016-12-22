//
//  CalendarDateCell.m
//  Foscam
//
//  Created by JackChan on 16/8/3.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import "CalendarDateCell.h"
#import "Masonry.h"

static CGFloat const kLengthOfButton = 24;
static CGFloat const kLengthOfDot = 6;

@interface CalendarDateCell ()

/**
 * 日期按钮
 */
@property (nonatomic, strong) UIButton *dateButton;

/**
 * 存在数据的小圆点
 */
@property (nonatomic, strong) UIImageView *dotImageView;

@end

@implementation CalendarDateCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    _style = CalendarDateCellDefault;
    [self addSubview:self.dateButton];
    [self addSubview:self.dotImageView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.dateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kLengthOfButton, kLengthOfButton));
    }];
    
    [self.dotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateButton.mas_bottom).offset(2);
        make.centerX.equalTo(self.dateButton);
        make.size.mas_equalTo(CGSizeMake(kLengthOfDot, kLengthOfDot));
    }];
}

#pragma mark - Event Methods
- (void)dateButtonTapped:(UIButton *)sender {
    if ([_collectionView.delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
        NSIndexPath *indexPath = [_collectionView indexPathForCell:self];
        [_collectionView.delegate collectionView:_collectionView didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - Getter && Setter
- (UIButton *)dateButton {
    if (!_dateButton) {
        _dateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _dateButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [_dateButton setTitleColor:RGBCOLOR(176, 176, 199) forState:UIControlStateNormal];
        [_dateButton setTitleColor:RGBCOLOR(9, 235, 255) forState:UIControlStateSelected];
        [_dateButton setTitleColor:RGBCOLOR(9, 235, 255) forState:UIControlStateHighlighted];
        [_dateButton setTitleColor:RGBCOLOR(72, 72, 92) forState:UIControlStateDisabled];
        [_dateButton setBackgroundImage:[UIImage imageNamed:@"date_selectbg"] forState:UIControlStateSelected];
        [_dateButton setBackgroundImage:[UIImage imageNamed:@"date_selectbg"] forState:UIControlStateHighlighted];
        [_dateButton addTarget:self action:@selector(dateButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dateButton;
}

- (UIImageView *)dotImageView {
    if (!_dotImageView) {
        _dotImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellow_dot"]];
    }
    return _dotImageView;
}

- (void)setDate:(NSInteger)date {
    _date = date % 100;
    NSString *title = [NSString stringWithFormat:@"%ld", _date];
    [self.dateButton setTitle:title forState:UIControlStateNormal];
}

- (void)setFlags:(CalendarDateFlags)flags {
    _flags = flags;
    
    CGFloat alpha = 1; // 透明度
    if (_flags & CalendarDateCurrentMonth) {
        self.dateButton.enabled = YES;
        self.dateButton.selected = (_flags & CalendarDateSelected);
    } else {
        alpha = 0.6;
        self.dateButton.selected = NO;
        self.dateButton.enabled = NO;
    }
    
    if (_flags & CalendarDateIsToday) {
        [_dateButton setTitleColor:[RGBCOLOR(255, 55, 50) colorWithAlphaComponent:alpha]
                          forState:UIControlStateNormal];
        [_dateButton setTitleColor:[RGBCOLOR(255, 55, 50) colorWithAlphaComponent:alpha]
                          forState:UIControlStateDisabled];
    } else {
        if (CalendarDateCellLight == _style) {
            [_dateButton setTitleColor:RGBCOLOR(72, 72, 92) forState:UIControlStateNormal];
            [_dateButton setTitleColor:RGBCOLOR(176, 176, 199) forState:UIControlStateDisabled];
        } else {
            [_dateButton setTitleColor:RGBCOLOR(176, 176, 199) forState:UIControlStateNormal];
            [_dateButton setTitleColor:RGBCOLOR(72, 72, 92) forState:UIControlStateDisabled];
        }
    }
    
    if (_flags & CalendarDateHasData) {
        self.dotImageView.hidden = NO;
        self.dotImageView.alpha = alpha;
    } else {
        self.dotImageView.hidden = YES;
    }
}

- (void)setStyle:(CalendarDateCellStyle)style {
    _style = style;
}

@end

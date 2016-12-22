//
//  CalendarWeekCell.m
//  Foscam
//
//  Created by JackChan on 16/8/3.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import "CalendarWeekCell.h"
#import "Masonry.h"

@implementation CalendarWeekCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initializer];
    }
    return self;
}

- (void)initializer {
    [self addSubview:self.label];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self);
    }];
}

#pragma mark - Getter && Setter
- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = RGBCOLOR(176, 176, 199);
        _label.font = [UIFont systemFontOfSize:14];
        _label.backgroundColor = [UIColor clearColor];
    }
    return _label;
}

@end

//
//  MATableViewCell.m
//  MAPayPalDemo
//
//  Created by MCL on 16/3/19.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "MTableViewCell.h"

@implementation MTableViewCell

//为了让菜单显示，目标视图必须在responder链中，很多UIKit视图默认并无法成为一个responder，因此你需要使这些视图重载 canBecomeFirstResponder方法，并返回YES
- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  UIButton+Extend.m
//  Example_Category
//
//  Created by MCL on 16/9/19.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "UIButton+Extend.h"

@implementation UIButton (Extend)

+ (instancetype)fsKeepPasswordButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"CheckBox.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"CheckBoxSelected.png"] forState:UIControlStateSelected];
    [button setTitle:FSLocalizedString(@"FS_Login_KeepPassword") forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
    [button sizeToFit];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    return button;
}

@end

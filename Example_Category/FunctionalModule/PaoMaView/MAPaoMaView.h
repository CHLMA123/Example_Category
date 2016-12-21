//
//  MALable.h
//  UILableDemo
//
//  Created by MACHUNLEI on 16/3/27.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import <UIKit/UIKit.h>

//跑马灯

@interface MAPaoMaView : UIView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title;

- (void)start;

- (void)stop;

@end

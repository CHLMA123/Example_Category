//
//  UIFont+MyFont.m
//  HCSystemicQRCodeDemo
//
//  Created by Caoyq on 16/5/4.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import "UIFont+MyFont.h"

@implementation UIFont (MyFont)

+ (UIFont *)FontWithSize:(CGFloat)size {
    CGFloat realSize = size * SCREEN_RATIO;
    return [UIFont systemFontOfSize:realSize];
}

@end

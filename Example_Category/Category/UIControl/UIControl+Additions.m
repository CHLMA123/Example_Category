//
//  UIControl+Additions.m
//  Category_Additions_SET
//  用runtime 解决UIButton 重复点击问题
//
//  Created by MCL on 16/7/23.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "UIControl+Additions.h"
#import <objc/runtime.h>

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *UIControl_ignoreEvent = "UIControl_ignoreEvent";

@implementation UIControl (Additions)

//改变两个方法的实现。在类第一次使用的时候回调用这个方法
+(void)load{
    
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(__uxy_sendAction:to:forEvent:));
    //改变两个方法的实现
    method_exchangeImplementations(a, b);
}

//通过关联对象重写get和set方法
- (NSTimeInterval)uxy_acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setUxy_acceptEventInterval:(NSTimeInterval)uxy_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(uxy_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 现在是否可点的get和set。通过关联对象。

-(BOOL)ignoreEvent{
    
    return [objc_getAssociatedObject(self, UIControl_ignoreEvent) boolValue];
}

-(void)setIgnoreEvent:(BOOL)ignoreEvent{
    
    objc_setAssociatedObject(self, UIControl_ignoreEvent, @(ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)__uxy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    if (self.ignoreEvent) return;
    if (self.uxy_acceptEventInterval > 0)
    {
        
        self.ignoreEvent = YES;
        [self performSelector:@selector(setIgnoreEvent:) withObject:@(NO) afterDelay:self.uxy_acceptEventInterval];
    }
    //调用系统实现
    [self __uxy_sendAction:action to:target forEvent:event];
}

@end

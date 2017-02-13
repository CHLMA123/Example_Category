//
//  SingletonUI.m
//  Example_Category
//
//  Created by MCL on 16/9/7.
//  Copyright © 2016年 MCL. All rights reserved.
//

/**
 *  创建对象的步骤分为申请内存(alloc)、初始化(init)这两个步骤，我们要确保对象的唯一性，因此在第一步这个阶段我们就要拦截它。当我们调用alloc方法时，OC内部会调用allocWithZone这个方法来申请内存，我们重写这个方法，然后在这个方法中调用shareInstance方法返回单例对象，这样就可以达到我们的目的。拷贝对象也是同样的原理，重写copyWithZone方法，然后在这个方法中调用shareInstance方法返回单例对象。
 */

#import "SingleClass.h"

@implementation SingleClass

static SingleClass* _instance = nil;

+ (instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init] ;
    }) ;
    
    return _instance ;
}

/**
  alloc 给对象分配内存空间，init是对对象的初始化，包括设置成员变量初值这些工作。而给对象分配空间，除了alloc方法之外，还有另一个方法： allocWithZone.
  在NSObject 这个类的官方文档里面，allocWithZone方法介绍说，该方法的参数是被忽略的，正确的做法是传nil或者NULL参数给它。
 */
+ (id) allocWithZone:(struct _NSZone *)zone
{
    return [SingleClass shareInstance] ;
}

- (id) copyWithZone:(struct _NSZone *)zone
{
    return [SingleClass shareInstance] ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

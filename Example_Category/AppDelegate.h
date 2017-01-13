//
//  AppDelegate.h
//  Example_Category
//
//  Created by MCL on 16/6/12.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import <UIKit/UIKit.h>

//App迭代开发版本号的规则
/*
 1 如果修复Bug或者优化功能, 我们只修改叠加第三位数字, 其他不变
 
 2.如果有了新的需求, 在原来的基础上增加了一个新功能, 那么我们的版本号变为1.1.0, 需要清空第三位数字为0, 来叠加修改第二位数字
 
 3.如果App需求功能大改, 更新量非常大, 那我们的版本号变为2.0.0, 需要叠加修改第一位数字, 清空其他数字为0
 */

/// 类的描述
@interface AppDelegate : UIResponder <UIApplicationDelegate>
/// 属性的描述
@property (strong, nonatomic) UIWindow *window;
/**
 appDelegate 方法
 */
+ (instancetype)appDelegate;

@end


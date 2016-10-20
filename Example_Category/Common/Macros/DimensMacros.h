//
//  DimensMacros.h
//  Example_Category
//
//  Created by MCL on 16/9/7.
//  Copyright © 2016年 MCL. All rights reserved.
//

#ifndef DimensMacros_h
#define DimensMacros_h

/**
 *  定义尺寸类的宏
 */

//以iphone5s,iphone5为基础 坐标都以iphone5s,iphone5为基准 进行代码的适配
#define ratio         [[UIScreen mainScreen] bounds].size.width/320.0

//状态栏高度
#define STATUS_BAR_HEIGHT 20
//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44
//状态栏 ＋ 导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))

/**
 *  获取屏幕 宽度、高度
 */
#pragma mark - Device Frame
// Get the screen's height.
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

// Get the screen's width.
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

// Get the screen's bounds.
#define kScreenBounds ([UIScreen mainScreen].bounds)

#define CONTENT_HEIGHT (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT)

// iPad & iPhone
// Judge whether the device it is ipad.
#define kIsiPad \
([[UIDevice currentDevice] respondsToSelector:@selector(userInterfaceIdiom)]\
&& [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define kIS_iPhone      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// Judge whether current orientation is landscape.
#define kIsLandscape (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]))

#define IsOrientationLandscape  ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)

#define IsPortrait ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)


#define IS_IPHONE_4     (kIS_iPhone && SCREEN_HEIGHT == 480.0)
#define IS_IPHONE_5     (kIS_iPhone && SCREEN_HEIGHT == 568.0)
#define IS_IPHONE_6     (kIS_iPhone && SCREEN_HEIGHT == 667.0)
#define IS_IPHONE_6p    (kIS_iPhone && SCREEN_HEIGHT == 736.0)

//针对IOS8添加  ios8横屏时  width跟height调转
#define SCREEN_Min      MIN(SCREEN_WIDTH,SCREEN_HEIGHT)
#define SCREEN_Max      MAX(SCREEN_WIDTH,SCREEN_HEIGHT)

//获取系统版本
#define IOS_VERSION     [[[UIDevice currentDevice] systemVersion] floatValue]
#define VersionLocation [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))

//获取当前语言
#define Language        IsChinese ? @"CHS" : @"ENU"

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define IsChinese       [CurrentLanguage rangeOfString:@"zh-Hans"].length// 简体zh-Hans

#define FSLocalizedString(key) (([CurrentLanguage rangeOfString:@"zh-Hans"].length || [CurrentLanguage rangeOfString:@"de"].length || [CurrentLanguage rangeOfString:@"fr"].length || [CurrentLanguage rangeOfString:@"es"].length)?([[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]):([[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]] localizedStringForKey:key value:@"" table:nil]))


#endif /* DimensMacros_h */

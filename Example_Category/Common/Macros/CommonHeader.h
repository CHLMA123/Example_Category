//
//  CommonHeader.h
//  Example_Category
//
//  Created by MCL on 16/9/3.
//  Copyright © 2016年 MCL. All rights reserved.
//

#ifndef CommonHeader_h
#define CommonHeader_h

#import "MacroHeader.h"
#import "ThirdMacrosHeader.h"

#define SharedAppDelegate       ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define GetImageByName(x)       [UIImage imageNamed:x]

#define MIGUOBackgroundColor    RGBCOLOR(229, 229, 229)

#define ScrollHight 31

/**
 *  获取屏幕 宽度、高度
 */

#define SCREEN_WIDTH    ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT   ([UIScreen mainScreen].bounds.size.height)



// iPad & iPhone
#define kISiPad         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kIS_iPhone      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

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

//获取当前语言
#define Language        IsChinese ? @"CHS" : @"ENU"

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define IsChinese       [CurrentLanguage rangeOfString:@"zh-Hans"].length// 简体zh-Hans

#define FSLocalizedString(key) (([CurrentLanguage rangeOfString:@"zh-Hans"].length || [CurrentLanguage rangeOfString:@"de"].length || [CurrentLanguage rangeOfString:@"fr"].length || [CurrentLanguage rangeOfString:@"es"].length)?([[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]):([[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]] localizedStringForKey:key value:@"" table:nil]))

#define IsOrientationLandscape  ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)

/*
 * 工程字体
 */

#define SysFontOfSize_20    [UIFont systemFontOfSize:20.0]
#define SysFontOfSize_18    [UIFont systemFontOfSize:18.0]
#define SysFontOfSize_17    [UIFont systemFontOfSize:17.0]
#define SysFontOfSize_16    [UIFont systemFontOfSize:16.0]
#define SysFontOfSize_15    [UIFont systemFontOfSize:15.0]
#define SysFontOfSize_14    [UIFont systemFontOfSize:14.0]
#define SysFontOfSize_13    [UIFont systemFontOfSize:13.0]
#define SysFontOfSize_12    [UIFont systemFontOfSize:12.0]
#define SysFontOfSize_11    [UIFont systemFontOfSize:11.0]
#define SysFontOfSize_10    [UIFont systemFontOfSize:10.0]
#define SysFontOfSize_9     [UIFont systemFontOfSize:9.0]

/*
 *工程颜色
 */

// rgb颜色转换（16进制->10进制）
#define UIColorFromHEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define RGB_Clear   [UIColor clearColor]        //透明
#define RGB_White   [UIColor whiteColor]        //白色
#define RGB_Black   [UIColor blackColor]        //黑色

#define RGB_Random    [UIColor colorWithRed:arc4random()%256/255. green:arc4random()%256/255. blue:arc4random()%256/255. alpha:1]

#define RGB_Lightgreen      [[UIColor greenColor] colorWithAlphaComponent:0.25];
#define RGB_LightPurple     [[UIColor purple] colorWithAlphaComponent:0.25];
#define RGB_LightBlue       [[UIColor blueColor] colorWithAlphaComponent:0.35];
#define RGB_LightRed        [[UIColor redColor] colorWithAlphaComponent:0.25];
#define RGB_LightOrange     [[UIColor orangeColor] colorWithAlphaComponent:0.25];

#endif /* CommonHeader_h */

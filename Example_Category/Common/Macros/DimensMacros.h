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

//状态栏高度
#define STATUS_BAR_HEIGHT 20
//NavBar高度
#define NAVIGATION_BAR_HEIGHT 44
//状态栏 ＋ 导航栏 高度
#define STATUS_AND_NAVIGATION_HEIGHT ((STATUS_BAR_HEIGHT) + (NAVIGATION_BAR_HEIGHT))

/**
 *  获取屏幕 宽度、高度
 */
#pragma mark - Device Frame (宏 x, y, width, height)

// App Frame
#define Application_Frame       [[UIScreen mainScreen] applicationFrame]

// App Frame Height&Width
#define App_Frame_Height        [[UIScreen mainScreen] applicationFrame].size.height
#define App_Frame_Width         [[UIScreen mainScreen] applicationFrame].size.width

// Get the screen's bounds.
#define SCREEN_BOUNDS ([UIScreen mainScreen].bounds)

// Get the screen's height.
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// Get the screen's width.
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

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


#define IS_IPHONE_4     (kIS_iPhone && SCREEN_HEIGHT == 480.0)//320
#define IS_IPHONE_5     (kIS_iPhone && SCREEN_HEIGHT == 568.0)//320
#define IS_IPHONE_6     (kIS_iPhone && SCREEN_HEIGHT == 667.0)//375
#define IS_IPHONE_6p    (kIS_iPhone && SCREEN_HEIGHT == 736.0)//414

// 是否Retina屏
#define isRetinaMode                ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
                                    CGSizeEqualToSize(CGSizeMake(640, 960), \
                                                        [[UIScreen mainScreen] currentMode].size) : \
                                    NO)

// 是否iPhone5
#define isiPhone5                   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
                                    CGSizeEqualToSize(CGSizeMake(640, 1136), \
                                                        [[UIScreen mainScreen] currentMode].size) : \
                                    NO)
// 是否iPhone4
#define isiPhone4                   ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
                                    CGSizeEqualToSize(CGSizeMake(640, 960), \
                                                        [[UIScreen mainScreen] currentMode].size) : \
                                    NO)

// 是否iOS7
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
// 是否iOS6
#define isIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//针对iOS8添加 横屏时 width跟height调转
#define SCREEN_MIN      MIN(SCREEN_WIDTH,SCREEN_HEIGHT)
#define SCREEN_MAX      MAX(SCREEN_WIDTH,SCREEN_HEIGHT)

//获取系统版本
#define IOS_VERSION     [[[UIDevice currentDevice] systemVersion] floatValue]
#define VersionLocation [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//屏幕分辨率
#define SCREEN_RESOLUTION (SCREEN_WIDTH * SCREEN_HEIGHT * ([UIScreen mainScreen].scale))
//以iphone5s,iphone5为基础 坐标都以iphone5s,iphone5为基准 进行代码的适配
#define SCREEN_RATIO      [[UIScreen mainScreen] bounds].size.width/320.0

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#define IsChinese       [CurrentLanguage rangeOfString:@"zh-Hans"].length

#define FSLocalizedString(key) (([CurrentLanguage rangeOfString:@"zh-Hans"].length || [CurrentLanguage rangeOfString:@"de"].length || [CurrentLanguage rangeOfString:@"fr"].length || [CurrentLanguage rangeOfString:@"es"].length)?([[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]):([[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]] localizedStringForKey:key value:@"" table:nil]))


// NSLocalizedString(key, comment) 本质
// NSlocalizeString 第一个参数是内容,根据第一个参数去对应语言的文件中取对应的字符串，第二个参数将会转化为字符串文件里的注释，可以传nil，也可以传空字符串@""。
// #define NSLocalizedString(key, comment) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]


#endif /* DimensMacros_h */

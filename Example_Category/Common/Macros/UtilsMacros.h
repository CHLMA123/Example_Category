//
//  UtilsMacros.h
//  Example_Category
//
//  Created by MCL on 16/9/7.
//  Copyright © 2016年 MCL. All rights reserved.
//

#ifndef UtilsMacros_h
#define UtilsMacros_h

/**
 *  工具类的宏
 */

//一些缩写
#define SharedAppDelegate       ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define kApplication            [UIApplication sharedApplication]
#define kKeyWindow              [UIApplication sharedApplication].keyWindow
#define kUserDefaults           [NSUserDefaults standardUserDefaults]
#define kNotificationCenter     [NSNotificationCenter defaultCenter]

#define GetImageByName(x)       [UIImage imageNamed:x]

#define MIGUOBackgroundColor    RGBCOLOR(229, 229, 229)

#define ScrollHight 31

#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

//获取系统时间戳
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

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


#endif /* UtilsMacros_h */

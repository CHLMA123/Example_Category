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
#pragma mark - Funtion Method (宏 方法)

// Get weak reference object.
#define kWeakObject(object) __weak __typeof(object) weakObject = object;

// Get strong reference object.
#define kStrongObject(object) __strong __typedef(object) strongObject = object;

// Get dispatch_get_main_queue()
#define kMainThread (dispatch_get_main_queue())

// Get default dispatch_get_global_queue
#define kGlobalThread dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

// Radians convert to degress.
#define kRadiansToDegrees(radians) ((radians) * (180.0 / M_PI))

// Degrees convert to randians.
#define kDegreesToRadians(angle) ((angle) / 180.0 * M_PI)

// Fast to get iOS system version
#define kiOSVersion ([UIDevice currentDevice].systemVersion.floatValue)

// More fast way to get app delegate
#define SharedAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define kApplication            [UIApplication sharedApplication]

#define kKeyWindow              [UIApplication sharedApplication].keyWindow

/**---------------------------------Load Image-------------------------------*/
#pragma mark - Load Image

// PNG JPG 图片路径
#define PNGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME, EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

// More easy way to load an image.
#define kImage(Name) ([UIImage imageNamed:Name])

// More easy to load an image from file.
#define kImageOfPNGFile(Name) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:Name ofType:@"png"]])
#define kImageOfJPGFile(Name) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:Name ofType:@"jpg"]])

/**---------------------------------System Singletons-------------------------------*/
#pragma mark - System Singletons

// More easy way to get user default object.
#define kUserDefaults [NSUserDefaults standardUserDefaults]

// More easy way to get NSNotificationCenter object.
#define kNotificationCenter  [NSNotificationCenter defaultCenter]

// More easy way to get [NSFileManager defaultManager]
#define kFileManager [NSFileManager defaultManager]

// More easy way to post a notification from notification center.
#define kPostNotificationWithName(notificationName) \
[kNotificationCenter postNotificationName:notificationName object:nil userInfo:nil]

// More easy way to post a notification with user info from notification center.
#define kPostNotificationWithNameAndUserInfo(notificationName, userInfo) \
[kNotificationCenter postNotificationName:notificationName object:nil userInfo:userInfo]

/**---------------------------------Judge-------------------------------*/
#pragma mark - Judge

// Judge whether it is an empty string.//字符串是否为空
#define kIsEmptyString(s) (s == nil || [s isKindOfClass:[NSNull class]] || ([s isKindOfClass:[NSString class]] && s.length == 0))

// Judge whether it is a nil or null object.//是否是空对象
#define kIsEmptyObject(obj) (obj == nil || [obj isKindOfClass:[NSNull class]])

// Judge whether it is a vaid dictionary.//字典是否为空
#define kIsVaidDictionary(objDict) (objDict != nil && [objDict isKindOfClass:[NSDictionary class]])

// Judge whether it is a valid array.//数组是否为空
#define kIsVaidArray(objArray) (objArray != nil && [objArray isKindOfClass:[NSArray class]])

//获取系统时间戳 (UTC)
#define getCurentTime [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]]

//number转String
#define IntTranslateStr(int_str) [NSString stringWithFormat:@"%d",int_str];
#define FloatTranslateStr(float_str) [NSString stringWithFormat:@"%.2d",float_str];

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

/*
 * 工程字体
 */
#pragma mark - Load Font
// Generate font with size
#define kFontWithSize(size) [UIFont systemFontOfSize:size]

// Generate bold font with size.
#define kBoldFontWithSize(size) [UIFont boldSystemFontOfSize:size]

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
#pragma mark - Generate Color
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

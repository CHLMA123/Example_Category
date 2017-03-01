//
//  DebugMacros.h
//  Example_Category
//
//  Created by MCL on 2016/12/15.
//  Copyright © 2016年 MCL. All rights reserved.
//

#ifndef DebugMacros_h
#define DebugMacros_h

/**
 *  1 block self
 */

#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };

/*
 // 宏定义之前的用法
 if (completionBlock)   {
 completionBlock(arg1, arg2);
 }
 // 宏定义之后的用法
 BLOCK_EXEC(completionBlock, arg1, arg2);
 */

/**
 *  2 MRC和ARC混编设置方式
 */

/*
 在XCode中targets的build phases选项下Compile Sources下选择 不需要arc编译的文件
 双击输入 -fno-objc-arc 即可
 
 MRC工程中也可以使用ARC的类，方法如下：
 在XCode中targets的build phases选项下Compile Sources下选择要使用arc编译的文件
 双击输入 -fobjc-arc 即可
 */

/**
 *  3 日志宏，用DEBUG开关管理，只有在DEBUG模式下才让日志输出
 */

#ifdef DEBUG
#define kDebugLog(...)              NSLog(__VA_ARGS__)
#define kDebugLogMethod()           NSLog(@"%s (%d)", __PRETTY_FUNCTION__, __LINE__)
#define kDebugLogMethods( s, ... )   NSLog( @"< %@:(%d) > %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )//< AppDelegate.m:(37) > 2

#else
#define kDebugLog(...)
#define kDebugLogMethod()
#define kDebugLogMethods( s, ... )

#endif

#ifdef DEBUG



#else

#define kDebugLogMethod( s, ... )

#endif


/**
 *  4 计算方法耗时时间间隔
 */

#define TICK   CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define TOCK   NSLog(@"{%@/%@}^{Time_Consuming: %f}", NSStringFromClass([self class]), NSStringFromSelector(_cmd), CFAbsoluteTimeGetCurrent() - start);

/**
 *  5 区分真机模拟器的时候务必用TARGET_IPHONE_SIMULATOR来判断
 */

#if TARGET_IPHONE_SIMULATOR//模拟器
#define SIMULATOR 1
#elif TARGET_OS_IPHONE//真机
#define SIMULATOR 0
#endif

/*
 TARGET_IPHONE_SIMULATOR和TARGET_OS_IPHONE 是苹果的两个宏定义，
 在真机sdk中位于ios->usr/include/targetconditionals.h中，
 在模拟器sdk中位于simulator->usr/include/targetconditionals.h中
 
 模拟器sdk中的定义：
 #define TARGET_OS_IPHONE            1
 #define TARGET_IPHONE_SIMULATOR     1
 
 真机sdk中的定义：
 
 #define TARGET_OS_IPHONE            1
 #define TARGET_IPHONE_SIMULATOR     0
 */

///**
// *  6 showModelContent
// */
//
//#define showModelContent(model) [AssistantTool dictionaryFromModel:model]


#endif /* DebugMacros_h */

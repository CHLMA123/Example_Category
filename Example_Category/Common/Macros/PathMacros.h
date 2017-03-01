//
//  PathMacros.h
//  Example_Category
//
//  Created by MCL on 16/9/7.
//  Copyright © 2016年 MCL. All rights reserved.
//

#ifndef PathMacros_h
#define PathMacros_h

/**
 *  沙盒路径
 */

//获取沙盒Document路径
#define kDocumentPath   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒temp路径
#define kTempPath       NSTemporaryDirectory()
//获取沙盒Cache路径
#define kCachePath      [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]


//PrivateInfo.plist文件Path
#define kPathPrivateInfo    [kPathDocument stringByAppendingPathComponent:@"PrivateInfo.plist"]
//启动图路径
#define kPathSplashScreen   [kPathCache stringByAppendingPathComponent:@"splashScreen"]


#endif /* PathMacros_h */

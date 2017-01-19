//
//  CrashModel.h
//  Foscam
//
//  Created by JackChan on 2016/11/9.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 崩溃类型

 - CrashException: 异常导致崩溃
 - CrashSignal:    信号量导致崩溃
 */
typedef NS_ENUM(NSInteger, CrashTypes) {
    CrashException,
    CrashSignal,
};

@interface CrashModel : NSObject

/**
 崩溃类型
 */
@property (nonatomic, assign) CrashTypes type;

/**
 崩溃原因
 */
@property (nonatomic, strong) NSString *reason;


/**
 ExceptionName
 */
@property (nonatomic, strong) NSString *name;

/**
 崩溃堆栈信息
 */
@property (nonatomic, strong) NSString *stackSymbols;

@end

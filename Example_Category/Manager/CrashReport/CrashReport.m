//
//  CrashReport.m
//  Foscam
//
//  Created by JackChan on 2016/11/9.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import "CrashReport.h"
#import "CrashModel.h"
#import <libkern/OSAtomic.h>

@interface CrashLogger : NSObject

+ (void)log:(CrashModel *)crashModel;

@end

@implementation CrashLogger

+ (void)log:(CrashModel *)crashModel {
    NSLog(@"%@", crashModel);
    
    //将CrashReport.txt保存到Document目录下的DebugLog文件夹下
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"DebugLog"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:logDirectory];
    if (!fileExists) {
        [fileManager createDirectoryAtPath:logDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd-HHmmss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSString *filePath = [logDirectory stringByAppendingFormat:@"/%@_CrashReport.txt",dateStr];
    NSData *crashData = [[crashModel description] dataUsingEncoding:NSUTF8StringEncoding];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        
        [fileManager createFileAtPath:filePath contents:crashData attributes:nil];
    }else{
        
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:crashData];
        [fileHandle closeFile];
    }
}

@end



volatile int32_t UncaughtExceptionCount = 0;
const int32_t UncaughtExceptionMaximum = 1;

void CrashReportUncaughtExceptionHandler(NSException *exception) {
    
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum) {
        return ;
    }
    
    CrashModel *crashModel = [CrashModel new];
    crashModel.type = CrashException;
    crashModel.reason = [exception reason];
    crashModel.stackSymbols = [[exception callStackSymbols] componentsJoinedByString:@"\n"];
    
    [CrashLogger log:crashModel];
    
    NSSetUncaughtExceptionHandler(NULL);
    [exception raise];
}

void CrashReportSignalHandler(int iSignal) {
    
    int32_t exceptionCount = OSAtomicIncrement32(&UncaughtExceptionCount);
    if (exceptionCount > UncaughtExceptionMaximum) {
        return ;
    }
    
    CrashModel *crashModel = [CrashModel new];
    crashModel.type = CrashSignal;
    crashModel.reason = [NSString stringWithFormat:@"%d", iSignal];
    crashModel.stackSymbols = [[NSThread callStackSymbols] componentsJoinedByString:@"\n"];
    
    [CrashLogger log:crashModel];
    
    signal(SIGABRT, SIG_DFL);
    signal(SIGILL, SIG_DFL);
    signal(SIGSEGV, SIG_DFL);
    signal(SIGFPE, SIG_DFL);
    signal(SIGBUS, SIG_DFL);
    signal(SIGPIPE, SIG_DFL);
    
    kill(getgid(), iSignal);
}



@interface CrashReport ()

@end

@implementation CrashReport

+ (instancetype)sharedInstance {
    
    static CrashReport *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CrashReport alloc] init];
    });
    return manager;
}

- (void)startUp {
    
    NSSetUncaughtExceptionHandler(CrashReportUncaughtExceptionHandler);
    
    signal(SIGABRT, CrashReportSignalHandler);
    signal(SIGILL, CrashReportSignalHandler);
    signal(SIGSEGV, CrashReportSignalHandler);
    signal(SIGFPE, CrashReportSignalHandler);
    signal(SIGBUS, CrashReportSignalHandler);
    signal(SIGPIPE, CrashReportSignalHandler);
}

@end
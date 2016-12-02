//
//  CrashReport.h
//  Foscam
//
//  Created by JackChan on 2016/11/9.
//  Copyright © 2016年 Foscam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrashReport : NSObject

+ (instancetype)sharedInstance;

- (void)startUp;

@end

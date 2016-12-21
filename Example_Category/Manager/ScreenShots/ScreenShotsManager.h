//
//  ScreenShotsManager.h
//  AirMonitor
//
//  Created by MCL on 2016/12/16.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScreenShotsManager : NSObject

+ (instancetype)shareManager;

- (UIImage *)makeScreenShots:(UIView *)screenView;

@end

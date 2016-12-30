//
//  MAKeyChain.h
//  MAPayPalDemo
//
//  Created by MCL on 16/3/19.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKeyChain : NSObject

+ (void)save:(NSString *)service data:(id)data ;

+ (id)load:(NSString *)service ;

+ (void)delete:(NSString *)service ;


@end

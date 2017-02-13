//
//  MyRuntimeClass.h
//  Example_Category
//
//  Created by APP on 2017/2/13.
//  Copyright © 2017年 MCL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRuntimeClass : NSObject

@property (nonatomic, strong) NSArray *array;

@property (nonatomic, copy) NSString *string;

+ (void)classMethod1;

- (void)method1;

- (void)method2;

@end

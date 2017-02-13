//
//  MyRuntimeClass.m
//  Example_Category
//
//  Created by APP on 2017/2/13.
//  Copyright © 2017年 MCL. All rights reserved.
//

#import "MyRuntimeClass.h"

@interface MyRuntimeClass (){
    
    NSInteger       _instance1;
    NSString    *   _instance2;
}
@property (nonatomic, assign) NSUInteger integer;

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2;

@end

@implementation MyRuntimeClass

+ (void)classMethod1 {
    
}

- (void)method1 {
    NSLog(@"call method method1");
}

- (void)method2 {
    
}

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2 {
    
    NSLog(@"arg1 : %ld, arg2 : %@", arg1, arg2);
}

@end

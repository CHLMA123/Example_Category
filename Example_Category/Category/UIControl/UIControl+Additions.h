//
//  UIControl+Additions.h
//  Category_Additions_SET
//  用runtime 解决UIButton 重复点击问题
//
//  Created by MCL on 16/7/23.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Additions)

@property (nonatomic, assign) NSTimeInterval uxy_acceptEventInterval;// 可以用这个给重复点击加间隔

@property (nonatomic, assign) BOOL ignoreEvent;

@end

/*
 Usage:
     - (void)viewDidLoad {
     [super viewDidLoad];
     UIButton *tempBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     tempBtn.frame = CGRectMake(100, 100, 30, 30);
     tempBtn.backgroundColor = [UIColor greenColor];
     [tempBtn addTarget:self action:@selector(clickWithInterval:) forControlEvents:UIControlEventTouchUpInside];
     tempBtn.uxy_acceptEventInterval = 2.5;
     
     [self.view addSubview:tempBtn];
     }
     
     #pragma mark 这里其实就是调用我们自定义的那个方法。
     -(void)clickWithInterval:(UIButton *)sender{
     NSLog(@"你现在能点哥了。");
     }
 
 */
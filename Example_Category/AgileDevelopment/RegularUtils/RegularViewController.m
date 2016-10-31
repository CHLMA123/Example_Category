//
//  RegularViewController.m
//  Example_Category
//
//  Created by MACHUNLEI on 16/9/23.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "RegularViewController.h"
#import "NSString+Extend.h"
#import "RegularUtils.h"

@interface RegularViewController ()

@end

@implementation RegularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *str =@"sbk-@126.com";//验证结果: 正则表达式不包含“-”符号的
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    BOOL b = [str isValidSMTPServer];
//    NSLog(@"%d", b);
    BOOL b = [RegularUtils hyb_isEmail:str];
    NSLog(@"%d", b);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

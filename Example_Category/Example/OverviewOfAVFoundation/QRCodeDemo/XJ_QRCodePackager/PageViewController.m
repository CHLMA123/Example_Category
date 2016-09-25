//
//  PageViewController.m
//  QRCodeDemo
//
//  Created by puxj on 16/9/12.
//  Copyright © 2016年 bcinfo. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"扫描结果";
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc] init];
    lab.bounds = CGRectMake(0, 0, 300, 300);
    lab.center = self.view.center;
    lab.font = [UIFont systemFontOfSize:15];
    lab.text = self.message;
    lab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lab];
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

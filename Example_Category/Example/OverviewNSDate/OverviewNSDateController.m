//
//  OverviewNSDateController.m
//  Example_Category
//
//  Created by MACHUNLEI on 16/9/23.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "OverviewNSDateController.h"

@interface OverviewNSDateController ()

@end

@implementation OverviewNSDateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupData];
    
}

- (void)setupData{
    // iOS开发时间控件怎么强制24小时制
    // eg1:
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // 这里是用大写的 H 24小时制
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSLog(@"dateString = %@",dateString);
    
    // eg2:
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"]; // 这里是用大写的 H 12小时制
    NSString *dateString2 = [dateFormatter stringFromDate:date];
    NSLog(@"dateString2 = %@",dateString2);
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

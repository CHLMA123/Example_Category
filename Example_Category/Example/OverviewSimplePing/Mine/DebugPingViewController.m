//
//  DebugPingViewController.m
//  Example_Category
//
//  Created by MCL on 16/9/21.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "DebugPingViewController.h"
#import "DebugPingServices.h"
#import "DebugTextView.h"

@interface DebugPingViewController ()

@property(nonatomic, strong) UITextField            *textField;
@property(nonatomic, strong) DebugTextView          *textView;
@property(nonatomic, strong) DebugPingServices      *pingServices;

@end

@implementation DebugPingViewController

- (void)dealloc {
    [self.pingServices cancel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Ping网络";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(_clearDebugViewActionFired:)];
    if ([UIViewController instancesRespondToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout  = UIRectEdgeNone;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(self.view.frame) - 80, 30)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"请输入IP地址或者域名";
    self.textField.text = @""; // https://api.myfoscam.com
    [self.view addSubview:self.textField];
    
    UIButton *goButton = [UIButton buttonWithType:UIButtonTypeCustom];
    goButton.frame = CGRectMake(CGRectGetMaxX(self.textField.frame) + 10, 10, 60, 30);
    [goButton setTitle:@"Ping" forState:UIControlStateNormal];
    [goButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [goButton addTarget:self action:@selector(_pingActionFired:) forControlEvents:UIControlEventTouchUpInside];
    goButton.tag = 10001;
    [self.view addSubview:goButton];
    
    self.textView = [[DebugTextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.textField.frame) + 10, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - CGRectGetMaxY(self.textField.frame) - 10)];
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.textView.editable = NO;
    [self.view addSubview:self.textView];
}

- (void)_clearDebugViewActionFired:(id)sender {
    self.textView.text = nil;
}

- (void)_pingActionFired:(UIButton *)button {
    //    [SimplePingHelper ping:self.textField.text target:self sel:@selector(_pingCallback:)];
    [self.textField resignFirstResponder];
    if (button.tag == 10001) {
        __weak DebugPingViewController *weakSelf = self;
        [button setTitle:@"Stop" forState:UIControlStateNormal];
        button.tag = 10002;
        self.pingServices = [DebugPingServices startPingAddress:self.textField.text callbackHandler:^(DPingItem *pingItem, NSArray *pingItems) {
            if (pingItem.status != STDPingStatusFinished) {
                [weakSelf.textView appendText:pingItem.description];
            } else {
                [weakSelf.textView appendText:[DPingItem statisticsWithPingItems:pingItems]];
                [button setTitle:@"Ping" forState:UIControlStateNormal];
                button.tag = 10001;
                weakSelf.pingServices = nil;
            }
        }];
    } else {
        [self.pingServices cancel];
    }
    
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

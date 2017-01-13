//
//  JS_OC_ControlViewController.m
//  Example_Category
//
//  Created by MCL on 2017/1/12.
//  Copyright © 2017年 MCL. All rights reserved.
//

#import "JS_OC_ControlViewController.h"
#import "UIWebViewViewController.h"
#import "WKWebViewViewController.h"

@interface JS_OC_ControlViewController ()

@property (nonatomic, strong) UIButton *mUIWebViewBtn;
@property (nonatomic, strong) UIButton *mWKWebViewBtn;

@end

@implementation JS_OC_ControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"JS_OC_Control";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mUIWebViewBtn];
    [self.view addSubview:self.mWKWebViewBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)UIWebView_JS{

    UIWebViewViewController *web1 = [[UIWebViewViewController alloc] init];
    [self.navigationController pushViewController:web1 animated:YES];
}

- (void)WKWebView_JS{

    WKWebViewViewController *web2 = [[WKWebViewViewController alloc] init];
    [self.navigationController pushViewController:web2 animated:YES];
}

- (UIButton *)mUIWebViewBtn{

    if (_mUIWebViewBtn==nil) {
        _mUIWebViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mUIWebViewBtn.frame = CGRectMake((self.view.frame.size.width-150)/2, 80, 150, 60);
        _mUIWebViewBtn.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.6];
        [_mUIWebViewBtn setTitle:@"UIWebView_JS" forState:UIControlStateNormal];
        [_mUIWebViewBtn addTarget:self action:@selector(UIWebView_JS) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mUIWebViewBtn;
}

- (UIButton *)mWKWebViewBtn{
    
    if (_mWKWebViewBtn==nil) {
        _mWKWebViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mWKWebViewBtn.frame = CGRectMake((self.view.frame.size.width-150)/2, 150, 150, 60);
        _mWKWebViewBtn.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.6];
        [_mWKWebViewBtn setTitle:@"WKWebView_JS" forState:UIControlStateNormal];
        [_mWKWebViewBtn addTarget:self action:@selector(WKWebView_JS) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mWKWebViewBtn;
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

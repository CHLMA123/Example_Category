//
//  LoadHtmlDocController.m
//  Example_Category
//
//  Created by MCL on 2016/11/8.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "LoadHtmlDocController.h"

@interface LoadHtmlDocController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation LoadHtmlDocController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        UIViewController *topVC = [self getCurrentTopVC];
        NSLog(@"topVC = %@", [topVC class]);
        NSLog(@"self.class ... : %@",NSStringFromClass(self.class));
        NSLog(@"currentVC = %@", [self getCurrentVC]);
    });
    
//    UIViewController *topVC = [self getCurrentTopVC];
//    NSLog(@"topVC = %@", [topVC class]);
//    NSLog(@"self.class ... : %@",NSStringFromClass(self.class));
//    NSLog(@"currentVC = %@", [self getCurrentVC]);
    /*
     2017-02-28 16:06:01.369017 Example_Category[1401:547218] topVC = UINavigationController
     2017-02-28 16:06:01.369158 Example_Category[1401:547218] self.class ... : LoadHtmlDocController
     2017-02-28 16:06:01.369255 Example_Category[1401:547218] currentVC = <LoadHtmlDocController: 0x131d1eec0>
     */
}

- (UIViewController *)getCurrentTopVC{

    UIViewController *tempVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = tempVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

- (UIViewController *)getCurrentVC{

    NSArray *vcArray = self.navigationController.viewControllers;
    if (vcArray.count > 0) {
        return vcArray[0];
    }else{
    
        return self;
    }
    
}

- (void)setupView{

    NSString *htmlpath = [[NSBundle mainBundle] pathForResource:@"help_enu" ofType:@"html"];
    NSString *htmlCont = [NSString stringWithContentsOfFile:htmlpath encoding:NSUTF8StringEncoding error:nil];
    
    // 获取当前应用的根目录
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    
    // 通过baseURL的方式加载的HTML
    // 可以在HTML内通过相对目录的方式加载js,css,img等文件
    [self.webView loadHTMLString:htmlCont baseURL:baseURL];
    [self.view addSubview:self.webView];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"webViewDidFinishLoad");
}

- (UIWebView *)webView{

    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _webView.delegate = self;
    }
    return _webView;
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

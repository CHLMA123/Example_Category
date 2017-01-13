//
//  WebViewViewController.m
//  WKWebView
//
//  Created by MCL on 2017/1/10.
//  Copyright © 2017年 CHLMA. All rights reserved.
//

#import "UIWebViewViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface UIWebViewViewController ()<UIWebViewDelegate>

@property(nonatomic, strong) UIWebView* mUIWebView;

@end

@implementation UIWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"UIWebView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.mUIWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate (一共有四个方法)

/// 是否允许加载网页，也可获取js要打开的url，通过截取此url可与js交互
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    NSLog(@"urlString=%@---urlComps=%@",urlString,urlComps);
    return YES;
}

/// 开始加载网页
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSURLRequest *request = webView.request;
    NSLog(@"webViewDidStartLoad-url=%@--%@",[request URL],[request HTTPBody]);
}

/// 网页加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSURLRequest *request = webView.request;
    NSURL *url = [request URL];
    if ([url.path isEqualToString:@"/normal.html"]) {
        NSLog(@"isEqualToString");
    }
    NSLog(@"webViewDidFinishLoad-url=%@--%@",[request URL],[request HTTPBody]);
    // 获取网页的title
    NSLog(@"document.title:%@",[self.mUIWebView stringByEvaluatingJavaScriptFromString:@"document.title"]);
    
    NSString *controlStr = [NSString stringWithFormat:@"var mycontrol = document.getElementById('codeValue');mycontrol.innerHTML='codeValue'"];
    [webView stringByEvaluatingJavaScriptFromString:controlStr];
    
//    NSString *controlStr1 = [NSString stringWithFormat:@"var mycontrol1 = document.getElementById('sucessImg'); custom.src='config_ok.png'"];
//    [webView stringByEvaluatingJavaScriptFromString:controlStr1];
    
    JSContext *jscontent = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    jscontent[@"openWWWCloudService"]=^(){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"html actions");
            [self openWWWCloudService];
        });
    };
}

/// 网页加载错误
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSURLRequest *request = webView.request;
    NSLog(@"didFailLoadWithError-url=%@--%@",[request URL],[request HTTPBody]);
}

- (void)openWWWCloudService{

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.smart029.com"]];
}

#pragma mark Setter && Getter
/**
 1.创建webview，并设置大小，"20"为状态栏高度
 2.创建请求
 3.加载网页
 */
//- (UIWebView *)mUIWebView{
//
//    if (_mUIWebView == nil) {
//        
//        _mUIWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cnblogs.com/mddblog/"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
//        [_mUIWebView setDelegate:self];
//        [_mUIWebView loadRequest:request];
//    }
//    return _mUIWebView;
//}


/**
 加载本地HTML文件
 */
- (UIWebView *)mUIWebView{
    
    if (_mUIWebView == nil) {
        
        _mUIWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        NSString *htmlFilePath = [[NSBundle mainBundle] pathForResource:@"couponcode" ofType:@"html"];
        NSString *htmlContent = [NSString stringWithContentsOfFile:htmlFilePath encoding:NSUTF8StringEncoding error:nil];
        NSURL *baseURL = [NSURL URLWithString:[[NSBundle mainBundle] bundlePath]];
        [_mUIWebView loadHTMLString:htmlContent baseURL:baseURL];
        [_mUIWebView setDelegate:self];
    }
    return _mUIWebView;
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

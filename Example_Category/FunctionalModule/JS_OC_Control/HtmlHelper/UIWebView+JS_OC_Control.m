//
//  UIWebView+JS_OC_Control.m
//  js_OCtest
//
//  Created by foscom on 16/9/7.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import "UIWebView+JS_OC_Control.h"
#import <JavaScriptCore/JavaScriptCore.h>
@implementation UIWebView (JS_OC_Control)

- (void)changeMarkWith:(NSString *)oldmarkId andNew:(NSString *)newMark
{
    NSString *controlStr = [NSString stringWithFormat:@"var custom=document.getElementById('%@');custom.innerHTML='%@'",oldmarkId,newMark];
    [self stringByEvaluatingJavaScriptFromString:controlStr];
}

- (void)changeImageWithPlace:(NSString *)imageId andNew:(NSString *)imageName
{
    
    NSString *control = [NSString stringWithFormat:@"var custom = document.getElementById('%@'); custom.src='%@'",imageId,imageName];
    [self stringByEvaluatingJavaScriptFromString:control];
    
}

- (void)getHtml_Action:(HTMLBlock)htmlBlock
{
    JSContext *jscontent = [self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    jscontent[@"activate_html_Action"]=^(){
        if (htmlBlock) {
            dispatch_async(dispatch_get_main_queue(), ^{
                htmlBlock();
            });
        }
    };

}

@end

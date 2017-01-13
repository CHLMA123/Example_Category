//
//  UIWebView+JS_OC_Control.h
//  js_OCtest
//
//  Created by foscom on 16/9/7.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HTMLBlock)();

@interface UIWebView (JS_OC_Control)<UIWebViewDelegate>

/**
 *  替换 js 中的字串
 *
 *  @param oldmarkId 被替换 js 中的字串id
 *  @param newMark 替换字串
 */
- (void)changeMarkWith:(NSString *)oldmarkId andNew:(NSString *)newMark;

- (void)changeImageWithPlace:(NSString *)imageId andNew:(NSString *)imageName;

- (void)getHtml_Action:(HTMLBlock)htmlBlock;


@end

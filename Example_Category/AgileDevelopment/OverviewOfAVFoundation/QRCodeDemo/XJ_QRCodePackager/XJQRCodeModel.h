//
//  XJQRCodeModel.h
//  QRCodeDemo
//
//  Created by puxj on 16/9/12.
//  Copyright © 2016年 bcinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XJQRCodeModel : NSObject


/**
 *根据传入的字符串来生成相应的二维码
 *@param   string     传入的字符串
 *@param   vc         调用方法时当前的Viewcontroller
 *@return  UIImage(二维码)
 */

//生成二维码
+ (UIImage *)createQRCodeWithString:(NSString *)string ViewController:(UIViewController *)vc;


//使用iOS 7后的CIFilter对象操作，生成二维码图片imgQRCode（会拉伸图片，比较模糊，效果不佳）
+ (CIImage *)createQRCodeImage:(NSString *)source;


//使用核心绘图框架CG（Core Graphics）对象操作，进一步针对大小生成二维码图片imgAdaptiveQRCode（图片大小适合，清晰，效果好）
+ (UIImage *)resizeQRCodeImage:(CIImage *)image withSize:(CGFloat)size;


//默认产生的黑白色的二维码图片；我们可以让它产生其它颜色的二维码图片
+ (UIImage *)specialColorImage:(UIImage*)image withRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;


//给二维码添加logo的2个方法
///使用核心绘图框架CG（Core Graphics）对象操作，合并二维码图片和用于中间显示的图标图片
+ (UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withIconSize:(CGSize)iconSize;
+ (UIImage *)addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withScale:(CGFloat)scale;


@end

//
//  ScreenShotsManager.m
//  AirMonitor
//
//  Created by MCL on 2016/12/16.
//  Copyright © 2016年 zengjia. All rights reserved.
//
/** 在开发项目中，有很多时候我们需要一个全局的对象，而且要保证全局有且仅有一份即可。
 *  创建对象的步骤分为申请内存(alloc)、初始化(init)这两个步骤，我们要确保对象的唯一性，因此在第一步这个阶段我们就要拦截它。当我们调用alloc方法时，OC内部会调用allocWithZone这个方法来申请内存，我们重写这个方法，然后在这个方法中调用shareInstance方法返回单例对象，这样就可以达到我们的目的。拷贝对象也是同样的原理，重写copyWithZone方法，然后在这个方法中调用shareInstance方法返回单例对象。
 */

#import "ScreenShotsManager.h"

static ScreenShotsManager *manager = nil;

@implementation ScreenShotsManager

+ (instancetype)shareManager{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super allocWithZone:NULL] init];
    });
    return manager;
}

+ (id) allocWithZone:(struct _NSZone *)zone
{
    return [ScreenShotsManager shareManager] ;
}

- (id) copyWithZone:(struct _NSZone *)zone
{
    return [ScreenShotsManager shareManager] ;
}

- (UIImage *)makeScreenShots:(UIView *)screenView
{
    //UIView *screenView = [UIApplication sharedApplication].keyWindow.viewForLastBaselineLayout;
    //CGSize s = [UIScreen mainScreen].bounds.size;
    
    CGSize s = screenView.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数。
    //    float scale = [[UIScreenmainScreen] scale];//得到设备的分辨率
    //    scale = 1; 的时候是代表当前设备是320*480的分辨率（就是iphone4之前的设备）
    //    scale = 2; 的时候是代表分辨率为640*960的分辨率
    NSLog(@"[UIScreen mainScreen].scale = %f",[UIScreen mainScreen].scale);
    //绘图
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    //渲染
    [screenView.layer renderInContext:UIGraphicsGetCurrentContext()];
    //生成图片
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //保存图片到相册
    [self SavedPhotosAlbum:image];
    return image;
}

/**
 image  要保存到用户设备中的图片
 completionTarget 当保存完成后，回调方法所在的对象
 completionSelector 当保存完成后，所调用的回调方法。 形式如下：
 - (void) image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo;
 contextInfo 可选的参数，保存了一个指向context数据的指针，它将传递给回调方法。
 */
- (void)SavedPhotosAlbum:(UIImage *)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage,self, @selector(image:didFinishSavingWithError:contextInfo:),NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    NSLog(@"%@", msg);
    
}

@end

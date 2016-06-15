//
//  ViewController.m
//  图层蒙版
//
//  Created by MCL on 16/6/7.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "ViewController.h"
#import "ViewController_push.h"
#import "YRActivityIndicator.h"
#import "LKBadgeView.h"

@interface ViewController ()
{
    YRActivityIndicator *activityIndicator;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 89, 290, 60);
    btn.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.6];
    [btn addTarget:self action:@selector(pushVCAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    // 1 控件的局部圆角问题: 图层蒙版(一个button或者label，只要右边的两个角圆角，或者只要一个圆角)。
    CGRect rect = CGRectMake(0, 0, 100, 50);
    CGSize radio = CGSizeMake(15, 2);//圆角尺寸
    UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerTopRight;//圆角位置
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radio];
    
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];//创建shapelayer
    masklayer.frame = btn.bounds;
    masklayer.path = path.CGPath;//设置路径
    btn.layer.mask = masklayer;
    
    
    // 2 侧滑手势返回 btn:pushVCAction
    /*
     一个第三方库 :https://github.com/CHLMA123/FDFullscreenPopGesture
     对系统的侧滑返回手势进行拓展，不用从边缘滑动，只要右滑即可返回。最重要的是，只需要加入项目中即可，不需要一行代码即可实现。
     
     just add 2 files and no need for any setups, all navigation controllers will be able to use fullscreen pop gesture automatically.
     
     To disable this pop gesture of a navigation controller:
     
     navigationController.fd_fullscreenPopGestureRecognizer.enabled = NO;
     To disable this pop gesture of a view controller:
     
     viewController.fd_interactivePopDisabled = YES;
     */
    
    // 3 关于block使用的ji点注意事项
    /*
     a 在使用block前需要对block指针做判空处理。不判空直接使用，一旦指针为空直接产生崩溃。
     
     b 使用方将self或成员变量加入block之前要先将self变为__weak
     
     c 在多线程环境下（block中的weakSelf有可能被析构的情况下），需要先将self转为strong指针，避免在运行到某个关键步骤时self对象被析构。
     
     b、c合起来有个名词叫weak–strong dance，来自于2011 WWDC Session #322 (Objective-C Advancements in Depth）https://developer.apple.com/videos/
     
     以下代码来自AFNetworking，堪称使用weak–strong dance的经典。
     __weak __typeof(self)weakSelf = self;//为防止callback内部对self强引用，weak一下。
     AFNetworkReachabilityStatusBlock callback = ^(AFNetworkReachabilityStatus status) {
     __strong __typeof(weakSelf)strongSelf = weakSelf;
     strongSelf.networkReachabilityStatus = status;
     if (strongSelf.networkReachabilityStatusBlock) {
     strongSelf.networkReachabilityStatusBlock(status);
     }
     };
     */
    
    
    // 4 图片处理只拿到图片的一部分
    
    UIImage *image = [UIImage imageNamed:@"Default"];// 750 * 1334
    CGImageRef imageRef = image.CGImage;
    CGRect rect1 = CGRectMake(100, 550, 50, 50);
    //这里的宽高是相对于图片的真实大小
    //比如你的图片是150x150的那么（0，0，150，150）就是图片的全尺寸，想取哪一部分就设置相应坐标即可;
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, rect1);
    UIImage *imageRect = [[UIImage alloc] initWithCGImage:imageRefRect];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.frame = CGRectMake(20, 159, 290, 60);
    imageV.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5];
    imageV.image = imageRect;
    imageV.contentMode = UIViewContentModeCenter;
    [self.view addSubview:imageV];
    
    // 4 给UIView设置图片
    //    UIView *layerView = [[UIView alloc] init];
    //    layerView.backgroundColor = [UIColor blackColor];
    //    layerView.frame = CGRectMake(20, 229, 150, 150);
    //    UIImage *image1 = [UIImage imageNamed:@"findhome_1455525720807"];
    //    layerView.layer.contents = (__bridge id)image1.CGImage;
    //    layerView.layer.contentsCenter = CGRectMake(0.25, 0.25, 0.5, 0.5);
    //    //同样可以设置显示的图片范围
    //    //不过此处略有不同，这里的四个值均为0-1之间；对应的依然是写x,y,widt,height
    //    [self.view addSubview:layerView];
  
    // 5
    LKBadgeView *timestampLabel = [[LKBadgeView alloc] initWithFrame:CGRectMake(5, 500, self.view.bounds.size.width-10, 55)];
    timestampLabel.backgroundColor = [UIColor grayColor];
    timestampLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
    timestampLabel.badgeColor = [UIColor redColor];
    timestampLabel.textColor = [UIColor blackColor];
    timestampLabel.font = [UIFont systemFontOfSize:10.0f];
    timestampLabel.text = @"99";
    //    timestampLabel.center = CGPointMake(CGRectGetWidth([[UIScreen mainScreen] bounds]) / 2.0, timestampLabel.center.y);
    [self.view addSubview:timestampLabel];

    
}

- (void)viewWillAppear:(BOOL)animated{

    activityIndicator = [[YRActivityIndicator alloc] init];
    activityIndicator.frame = CGRectMake(0, 0, 50, 50);
    activityIndicator.center = self.view.center;
    //    activityIndicator.maxItems = 7;
    //    activityIndicator.itemImage = [UIImage imageNamed:@"findhome_20160126202805dianying"];
        activityIndicator.itemColor = [UIColor redColor];
    //    activityIndicator.maxItemSize = CGSizeMake(25, 25);
    //    activityIndicator.minItemSize = CGSizeMake(5, 5);
    //    activityIndicator.radius = 80;
    //    activityIndicator.cycleDuration = 2.5;
    //    activityIndicator.maxSpeed = 1.6;
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushVCAction{
    
    dispatch_after(2.0f, dispatch_get_main_queue(), ^{
        [activityIndicator stopAnimating];
        ViewController_push *push = [[ViewController_push alloc] init];
        [self.navigationController pushViewController:push animated:YES];
    });
}

@end

//
//  ViewController.m
//  Example_Category
//
//  Created by MCL on 16/6/12.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "ViewController.h"
#import "GetDeviceAllInfo.h"
#import "AnimatedImageViewController.h"
#import "UIImage+Extend.h"

static NSInteger i = 0;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //    self.edgesForExtendedLayout = UIRectEdgeBottom;//当有导航栏时 设置该项 那么起点坐标从0.0开始 否则从0.64开始
    //    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    //    [self.view addSubview:view];
    //    view.backgroundColor = [UIColor redColor];
    
#pragma mark - Examples
    
    [self familyNameAction];                    // 获取设备中的所有字体
    [self waterMarkImageAction];                // 图片加水印
    [self NSRecursiveLockAction];               // 递归锁使用
    [self getWIFINameAction];                   // wifiName
    [self getContentTypeOfImage];               // 判断是否为gif/png图片的正确姿势
    [self getstartOfToday];                     // 凌晨时间获取
    [self otherNSStringTestAction];             // NSString使用stringWithFormat拼接的相关知识
    [self getCurrentTimeZone];                  // getCurrentTimeZone
    [self compareStringTest];                   // compareStringTest
    [self blockTestAction];                     // block 可以作为参数传递
    [self testDictonaryAction];                 // testDictonaryAction
    [self pushAnimatedImage];                   // AnimatedImageViewController gif动画加载
    [self cutCircleImageAction];                // iOS开发中设置圆角的几种方法
    
}

#pragma mark - iOS开发中设置圆角的几种方法
- (void)cutCircleImageAction{
    
    // method1 强烈建议摒弃 因为使用图层过量会有卡顿现象, 特别是弄圆角或者阴影会很卡
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.layer.cornerRadius = 20;
    imageView.layer.masksToBounds = YES;
    
    // method2 用绘图来做 /** 设置圆形图片(放到分类中使用) */
    UIImage *image = [[UIImage imageNamed:@"Default@3x"] cutCircleImage];
    imageView.image = image;
}

#pragma mark - gif动画加载
- (void)pushAnimatedImage{
    
    AnimatedImageViewController *push = [[AnimatedImageViewController alloc] init];
    [self.navigationController pushViewController:push animated:YES];

}

#pragma mark - testDictonaryAction
- (void)testDictonaryAction{
    
    NSDictionary *dic = [NSDictionary dictionary];
    NSInteger data = [[dic objectForKey:@"data"] integerValue];
    NSLog(@"data : %ld", (long)data);
    
    NSDictionary *dic2 = [NSDictionary dictionary];
    dic2 = @{@"data2":@(1)};
    NSInteger data2 = [[dic2 objectForKey:@"data2"] integerValue];
    NSLog(@"data2 : %ld", (long)data2);
    
    NSDictionary *dic3 = nil;
    NSInteger data3 = [[dic3 objectForKey:@"data3"] integerValue];
    NSLog(@"data3 : %ld", (long)data3);
    
}

#pragma mark - block 可以作为参数传递
- (void)blockTestAction{
    
    [self testBlockAction:^(NSString *value) {
        NSLog(@"value: %@", value);
    }];
}

- (void)testBlockAction:(void(^)(NSString *)) block{
    
    [self testBlockAction2:^(NSString * value) {
        
        if ([value isEqualToString:@"990001"]) {
            [self testBlockAction:block];
        }else{
            
            block(value);
        }
    }];
    
    
}

- (void)testBlockAction2:(void(^)(NSString *)) block{
    
    if (i == 0) {
        i = 1;
        block(@"990001");
    }else{
        block(@"12345");
    }
    
}


#pragma mark - compareStringTest
- (void)compareStringTest{
    
    NSString *string1 = @"2.0.5";
    NSString *string2 = @"2.1.5";
    NSString *string3 = @"2.2.5";
    
    NSComparisonResult ret = [string1 compare:string2];
    NSComparisonResult ret1 = [string3 compare:string2];
    NSLog(@"-- 比较结果 ret = %ld ret1 = %ld", (long)ret , (long)ret1);
}

#pragma mark - getCurrentTimeZone
- (void)getCurrentTimeZone{
    
    //手机时区获取 和夏令时有关
    NSDate *sourceDate = [NSDate date];
    NSTimeZone *sourcetimeZone =[NSTimeZone localTimeZone];
    NSInteger srcGMTOffset = [sourcetimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval dstOffset = [sourcetimeZone daylightSavingTimeOffsetForDate:sourceDate];
    NSInteger dstGMTOffset = srcGMTOffset - dstOffset;
    NSLog(@"----- dstGMTOffset = %ld",(long)dstGMTOffset);//dstGMTOffset 是相对UTC时间的偏移值，如果是北京时间，那么dstGMTOffset = 288000, 即8h .
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:dstGMTOffset];
    NSLog(@"----- timeZone = %@",timeZone);
}

#pragma mark - stringWithFormat拼接的相关知识
/**
 *  NSString使用stringWithFormat拼接的相关知识
 */
- (void)otherNSStringTestAction{
    
    //保留2位小数点
    //.2代表小数点后面保留2位(2代表保留的数量)
    NSString *string = [NSString stringWithFormat:@"%.2f",M_PI];
    //输出结果是: 3.14
    NSLog(@"%@", string);
    
    //用0补全的方法
    NSInteger count = 5;
    //02代表:如果count不足2位 用0在最前面补全(2代表总输出的个数)
    NSString *string1 = [NSString stringWithFormat:@"%02zd",count];
    //输出结果是: 05
    NSLog(@"%@", string1);
    
    //字符串中有特殊符号%
    NSInteger count2 = 50;
    //%是一个特殊符号 如果在NSString中用到%需要如下写法
    NSString *string2 = [NSString stringWithFormat:@"%zd%%",count2];
    //输出结果是: 50%
    NSLog(@"%@", string2);
    
    //字符串中有特殊符号"
    NSInteger count3 = 50;
    //"是一个特殊符号, 如果在NSString中用到"需要用\进行转义
    NSString *string3 = [NSString stringWithFormat:@"%zd\"",count3];
    //输出结果是: 50"
    NSLog(@"%@", string3);
    
}

#pragma mark - 凌晨时间获取
- (void)getstartOfToday{
    
    NSDate *nowDate = [NSDate date];
    NSLog(@"nowDate : %@", nowDate);
    
    NSDate *startOfToday = [[NSCalendar currentCalendar] startOfDayForDate:nowDate];
    NSLog(@"startOfToday : %@", startOfToday);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:nowDate];
    NSDate *previousDate = [calendar dateFromComponents:components];
    NSLog(@"previousDate : %@", previousDate);
}

#pragma mark - 判断是否为gif/png图片的正确姿势
- (void)getContentTypeOfImage{
    
    NSString *path = @"http://pic.rpgsky.net/images/2016/07/26/3508cde5f0d29243c7d2ecbd6b9a30f1.png";
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
    //调用获取图片扩展名
    NSString *string = [self contentTypeForImageData:data];
    //输出结果为 png
    NSLog(@"getContentTypeOfImage = %@",string);
}

/**
 *  通过图片Data数据第一个字节 来获取图片扩展名
 *
 *  图片数据的第一个字节是固定的,一种类型的图片第一个字节就是它的标识
 */
- (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}

#pragma mark - wifiName
- (void)getWIFINameAction{
    
    NSString *wifiName = [GetDeviceAllInfo UnitInfo:WIFI_INFO];
    NSLog(@"%@", wifiName);
    
}

#pragma mark - 递归锁使用
#warning 参考博客地址：http://www.cocoachina.com/ios/20150513/11808.html
- (void)NSRecursiveLockAction {
    //递归锁使用
    NSRecursiveLock *lock =[[NSRecursiveLock alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void (^RecursiveMethod)(int);
        RecursiveMethod = ^(int value){
            [lock lock];
            if (value > 0) {
                NSLog(@"value = %d",value);
                sleep(2);
                RecursiveMethod(value - 1);
            }
            [lock unlock];
        };
        RecursiveMethod(5);
    });
    
    //尝试在第二个线程中枷锁
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        BOOL flag = [lock lockBeforeDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        if (flag) {
            NSLog(@"Lock before date");
            [lock unlock];
        }else{
            NSLog(@"fail to lock before date");
        }
    });
    
}

#pragma mark - 图片加水印
- (void)waterMarkImageAction{
    
    UIImage *image = [UIImage imageNamed:@"启动页_1242x2208"];
    UIImage *waterImage = [self waterMarkImage:image withText:@"你好"];
    // 展示图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
    imageView.image = waterImage;
    [self.view addSubview:imageView];
    UIImageWriteToSavedPhotosAlbum(waterImage, nil, nil, nil);  //保存图片至相册
    
    [UIView animateWithDuration:5 delay:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.25, 0.25);
        
    } completion:^(BOOL finished) {
        
        imageView.transform = CGAffineTransformIdentity;
        imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
    }];
}

- (UIImage *)waterMarkImage:(UIImage *)image withText:(NSString *)text {
    
    UIGraphicsBeginImageContext(image.size);// 建立图像上下文
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];// 在画布中绘制内容
    [[UIColor darkGrayColor] set];// 绘制文字
    CGRect rect = CGRectMake(70, 220, 200, 60);
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:55],
                          NSObliquenessAttributeName:@1};
    //这里设置了字体，和倾斜度，具体其他参数文章结尾有详细说明的文章链接
    [text drawInRect:rect withAttributes:dic];
    
    //在iOS7之前用下列方法比较方便
    //    [text drawInRect:rect withFont:[UIFont systemFontOfSize:30] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    
    //    从画布中得到image
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return returnImage;
}

#pragma mark - 获取设备中的所有字体
- (void)familyNameAction{
    
    for (NSString *familyName in [UIFont familyNames]) {
        NSLog(@"字体族：%@",familyName);
        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
            NSLog(@"\t字体：%@",fontName);
        }
    }
    
    
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
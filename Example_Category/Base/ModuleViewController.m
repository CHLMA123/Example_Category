//
//  ViewController.m
//  Example_Category
//
//  Created by MCL on 16/6/12.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "ModuleViewController.h"
#import "GetDeviceAllInfo.h"
#import "AnimatedImageViewController.h"
#import "CreateAnimatedViewController.h"
#import "STDDebugPingViewController.h"
#import "OverviewNSDateController.h"
#import "RegularViewController.h"
#import "NSURLSessionController.h"

#import "ScreenShotsManager.h"


#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
//ImageView旋转状态枚举 NSEN
typedef NS_ENUM(NSInteger, RotateState) {
    RotateStateStop,
    RotateStateRunning,
};

static NSInteger i = 0;

@interface ModuleViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    CGFloat imageviewAngle;  /// 旋转角度
    UIImageView *imageView;  /// 旋转ImageView
    RotateState rotateState; /// 旋转状态
    UIImageView *screenshotsImageView;  /// 截屏
}

@end

@implementation ModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
     self.edgesForExtendedLayout = UIRectEdgeBottom;//当有导航栏时 设置该项 那么起点坐标从0.0开始 否则从0.64开始
     UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
     [self.view addSubview:view];
     view.backgroundColor = [UIColor redColor];
     */
#pragma mark - Examples (1 - 15)
    
//    [self familyNameAction];                    // 1 获取设备中的所有字体
//    [self waterMarkImageAction];                // 2 图片加水印
//    [self NSRecursiveLockAction];               // 3 递归锁使用
//    [self getWIFINameAction];                   // 4 wifiName
//    [self getContentTypeOfImage];               // 5 判断是否为gif/png图片的正确姿势

    [self sizeToFitTest];             //6 UILable 根据文字内容进行大小设置 sizeThatFits和sizeToFit
//    [self otherNSStringTestAction];             // 7 NSString使用stringWithFormat拼接的相关知识
    
//    [self compareStringTest];                   // 9 compareStringTest
//    [self blockTestAction];                     // 10 block 可以作为参数传递
    
//    [self testDictonaryAction];                 // 11 testDictonaryAction
//    [self pushAnimatedImage];                   // 12 AnimatedImageViewController gif动画加载
//    [self cutCircleImageAction];                // 13 iOS开发中设置圆角的几种方法
//    [self createAnimatedImage];                 // 14 使用图片实现GIF动画
//    [self createButtonRectCorner];              // 15 控件的局部圆角问题: 图层蒙版(一个button或者label，只要右边的两个角圆角，或者只要一个圆角)。
    
#pragma mark - Examples (16 - 30)
    
//    [self GetContendImageView];                 // 16 图片处理只拿到图片的一部分
//    [self setImageforUIView];                   // 17 给UIView设置图片
//    [self buildBarButtonItem];                  // 18 旋转动画

//    [self tableViewContentInset];               // 20 指定滚动条在scrollview的位置
    
//    [self testArraySum];                        // 21 array快速求总和, 最大值, 最小值和平均值
    
//    [self createButtonView];                    // 26 左右结构的button fsKeepPasswordButton
    
//    NSString *string = @"0";
//    NSLog(@"...longLongValue...: %lld", [string longLongValue]);
//    //2016-10-26 14:08:24.263 Example_Category[3864:1116044] ...longLongValue...: 0
    
    #pragma mark - Examples (31 - 45)//    // Typical usage
//    [self openScheme:@"tweetbot://timeline"];   // 32『iOS应用间相互跳转』
    
    NSString *str = @"-1";
    NSLog(@"[str integerValue] = %ld", (long)[str integerValue]);
    
    
}


#pragma mark - 『iOS应用间相互跳转』
//- (void)openScheme:(NSString *)scheme {
//    UIApplication *application = [UIApplication sharedApplication];
//    NSURL *URL = [NSURL URLWithString:scheme];
//    
//    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
//        /*
//         [application openURL:URL options:@{}
//         completionHandler:^(BOOL success) {
//         NSLog(@"Open %@: %d",scheme,success);
//         }];
//         */
//        
//        /*
//         UIApplication 头文件为options字典列出了一个key：
//         UIApplicationOpenURLOptionUniversalLinksOnly:如果这个要打开的URL有效，并且在应用中配置它布尔值为true（YES）时才可以打开，否则打不开。
//         为了覆盖默认行为，创建一个设置key值了True的字典作为参数传入：
//         设置它为true并打开URL：https://twitter.com/kharrison 时, 如果我并没有安装Twitter app那它就会失败，同时会调用safari来打开这个链接。
//         */
//        NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @YES};
//        [application openURL:URL options:options completionHandler:nil];
//        
//    } else {
//        BOOL success = [application openURL:URL];
//        NSLog(@"Open %@: %d",scheme,success);
//    }
//}

#pragma mark - createButtonView
- (void)createButtonView{
    
    UIButton *fsKeepPasswordButton = [UIButton fsKeepPasswordButton];
    fsKeepPasswordButton.backgroundColor = [UIColor lightGrayColor];
    fsKeepPasswordButton.frame = CGRectMake(0, 0, 200, 45);
    fsKeepPasswordButton.center = self.view.center;
    [self.view addSubview:fsKeepPasswordButton];
}

#pragma mark - array快速求总和, 最大值, 最小值和平均值
- (void)testArraySum{
    
    NSArray *array = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    CGFloat sum = [[array valueForKeyPath:@"@sum.floatValue"] floatValue];
    CGFloat avg = [[array valueForKeyPath:@"@avg.floatValue"] floatValue];
    CGFloat max =[[array valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat min =[[array valueForKeyPath:@"@min.floatValue"] floatValue];
    NSLog(@"%f\n%f\n%f\n%f",sum,avg,max,min);
}

#pragma mark - 指定滚动条在scrollview的位置
/*
 tableview刷新某个区域（section）或者某一行（row）
 
 //一个section刷新
     
     NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
     [tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

 //一个cell刷新
     
     NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
     [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationRight];
 */
- (void)tableViewContentInset{

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    //contentInset是scrollview的contentview的顶点相对于scrollview的位置
    tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    //指定滚动条在scrollview的位置
    tableView.scrollIndicatorInsets = tableView.contentInset;
    tableView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.25];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idf = @"123";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idf];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idf];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //修改UITableviewCell的分割线距离通常需要修改separatorInset属性的top, left, bottom, right：
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

#pragma mark - 截屏
- (void)Screenshots{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    btn.center = CGPointMake(100, 200);
    [btn addTarget:self action:@selector(ScreenshotsAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    screenshotsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 300, 200)];
    [self.view addSubview:screenshotsImageView];
}

- (void)ScreenshotsAction{
    
//    NSLog(@"%f", [UIScreen mainScreen].brightness);
//    [[UIScreen mainScreen]setBrightness:0.8];//点亮手机屏幕
    
    UIImage *image = [[ScreenShotsManager shareManager] makeScreenShots:self.view];
    NSLog(@"%@", NSStringFromCGSize(image.size));
}

#pragma mark - 旋转动画
#pragma mark  添加 RightBarButtonItem
-(void)buildBarButtonItem{
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon"]];
    imageView.autoresizingMask = UIViewAutoresizingNone;
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.bounds=CGRectMake(0, 0, 40, 40);
    //设置视图为圆形
    imageView.layer.masksToBounds=YES;
    imageView.layer.cornerRadius=20.f;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 40, 40);
    [button addSubview:imageView];
    [button addTarget:self action:@selector(animate) forControlEvents:UIControlEventTouchUpInside];
    imageView.center = button.center;
    //设置RightBarButtonItem
    UIBarButtonItem  *barItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barItem;
}
#pragma mark  点击 RightBarButtonItem
- (void)animate {
    //改变ImageView旋转状态
    if (rotateState==RotateStateStop) {
        rotateState=RotateStateRunning;
        [self rotateAnimate];
    }else{
        rotateState=RotateStateStop;
    }
}
#pragma mark - 旋转动画
-(void)rotateAnimate{
    imageviewAngle+=50;
    //0.5秒旋转50度
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        imageView.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(imageviewAngle));
    } completion:^(BOOL finished) {
        if (rotateState==RotateStateRunning) {
            [self rotateAnimate];
        }
    }];
}


#pragma mark - 给UIView设置图片
- (void)setImageforUIView{

    UIView *layerView = [[UIView alloc] init];
    layerView.backgroundColor = [UIColor blackColor];
    layerView.frame = CGRectMake(20, 229, 150, 150);
    UIImage *image1 = [UIImage imageNamed:@"findhome_1455525720807"];
    layerView.layer.contents = (__bridge id)image1.CGImage;
    layerView.layer.contentsCenter = CGRectMake(0.25, 0.25, 0.5, 0.5);
    //同样可以设置显示的图片范围
    //不过此处略有不同，这里的四个值均为0-1之间；对应的依然是写x,y,widt,height
    [self.view addSubview:layerView];

}

#pragma mark - 图片处理只拿到图片的一部分
- (void)GetContendImageView{

    UIImage *image = [UIImage imageNamed:@"Default@3x"];// 750 * 1334
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
}

#pragma mark - 控件的局部圆角问题
- (void)createButtonRectCorner{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 89, 290, 60);
    btn.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:0.6];
    [self.view addSubview:btn];

    CGRect rect = CGRectMake(0, 0, 100, 50);
    CGSize radio = CGSizeMake(15, 2);//圆角尺寸
    UIRectCorner corner = UIRectCornerTopLeft|UIRectCornerTopRight;//圆角位置
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radio];

    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];//创建shapelayer
    masklayer.frame = btn.bounds;
    masklayer.path = path.CGPath;//设置路径
    btn.layer.mask = masklayer;
    
}

#pragma mark - 使用图片实现GIF动画
- (void)createAnimatedImage{

    CreateAnimatedViewController *push = [[CreateAnimatedViewController alloc] init];
    [self.navigationController pushViewController:push animated:YES];
}

#pragma mark - iOS开发中设置圆角的几种方法
- (void)cutCircleImageAction{
    
//    // method1 强烈建议摒弃 因为使用图层过量会有卡顿现象, 特别是弄圆角或者阴影会很卡
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.layer.cornerRadius = 20;
//    imageView.layer.masksToBounds = YES;
    
    // method2 用绘图来做 /** 设置圆形图片(放到分类中使用) */
    UIImage *image = [[UIImage imageNamed:@"Default@3x"] cutCircleImage];
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.width)];
    [imageView2 setImage:image];
    [self.view addSubview:imageView2];
    imageView2.center = self.view.center;
    
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
 /*
 3 关于block使用的ji点注意事项
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

#pragma mark - UILable 根据文字内容进行大小设置 sizeThatFits和sizeToFit
/**
 UILabel经常用到的方法
 - (void)sizeToFit
 - (CGSize)sizeThatFits:(CGSize)size
 解释如下：
 
 sizeToFit会自动调用sizeThatFits方法；
 
 sizeToFit不应该在子类中被重写，应该重写sizeThatFits
 
 sizeThatFits传入的参数是receiver当前的size，返回一个适合的size
 
 sizeToFit可以被手动直接调用
 
 sizeToFit和sizeThatFits方法都没有递归，对subviews也不负责，只负责自己
 */
- (void)sizeToFitTest{
    
    NSString *str=@"左右结构，图片在左边，文字在右边。左右结构，图片在左边，文字在右边。";
    
    UILabel *sizeLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 65, 200, 30)];
    [self.view addSubview:sizeLable];
    sizeLable.text = str;
    sizeLable.textColor=[UIColor whiteColor];
    sizeLable.backgroundColor=[UIColor lightGrayColor];
    sizeLable.textAlignment=NSTextAlignmentCenter;
    sizeLable.numberOfLines = 0;
    {
        //调整当前view的大小自适应
        //[sizeLable sizeToFit];//调整label的大小来适应文字
    }
    {
        sizeLable.adjustsFontSizeToFitWidth = YES;//文本文字自适应大小
        //sizeThatFits传入的参数是receiver当前的size，返回一个适合的size
        [sizeLable sizeThatFits:CGSizeMake(100, 30)];
    }
    
    UILabel *notice=[[UILabel alloc]initWithFrame:CGRectMake(10, 100, 200, 30)];
    [self.view addSubview:notice];
    notice.text=str;
    notice.textColor=[UIColor whiteColor];
    notice.backgroundColor=[UIColor lightGrayColor];
    notice.textAlignment=NSTextAlignmentCenter;
    //文本文字自适应大小
    notice.adjustsFontSizeToFitWidth = YES;
    //使用sizeThatFit计算lable大小
    CGSize sizeThatFit=[notice sizeThatFits:CGSizeZero];
    //重新指定frame
    notice.frame=CGRectMake(0, 0, sizeThatFit.width, sizeThatFit.height);
    notice.center = CGPointMake(self.view.bounds.size.width/2, 200);
    
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
//#warning 参考博客地址：http://www.cocoachina.com/ios/20150513/11808.html
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
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageV.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
    imageV.image = waterImage;
    [self.view addSubview:imageV];
    UIImageWriteToSavedPhotosAlbum(waterImage, nil, nil, nil);  //保存图片至相册
    
    [UIView animateWithDuration:5 delay:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        imageV.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.25, 0.25);
        
    } completion:^(BOOL finished) {
        
        imageV.transform = CGAffineTransformIdentity;
        imageV.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
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

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

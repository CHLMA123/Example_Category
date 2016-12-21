//
//  QRCodeViewController.m
//  Example_Category
//
//  Created by MCL on 16/9/7.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "QRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "PureLayout.h"

@interface QRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>

{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    UIImageView * imageView;
    
    BOOL hasCameraRight;
    
    UIView *scanRectView;
}

@property (nonatomic, strong) AVCaptureDevice * device;

@property (nonatomic, strong) AVCaptureDeviceInput * input;

@property (nonatomic, strong) AVCaptureMetadataOutput * output;

@property (nonatomic, strong) AVCaptureSession * session;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer * preview;

@property (nonatomic, retain) UIImageView * line;

@property (nonatomic, assign) CGSize scanSize;

@property (nonatomic, assign) CGRect scanRect;

@end

@implementation QRCodeViewController

/**
 *  使用UIAlertController共需要三步
 
 *  1.实例化alert:alertControllerWithTitle
 
 *  2.实例化按钮:actionWithTitle
 
 *  3.显示alertController:presentViewController
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"扫一扫";
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"应用相机权限受限" message:@"请在设备的“设置-隐私-相机”中允许访问相机。" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertController addAction:alertAction];
        [self presentViewController:alertController animated:YES completion:nil];
        hasCameraRight = NO;
        return;
    }
    hasCameraRight = YES;
    
    _scanSize = CGSizeMake(SCREEN_WIDTH * 0.8, SCREEN_WIDTH * 0.8);
    _scanRect = CGRectMake((SCREEN_WIDTH - _scanSize.width)/2, 100, _scanSize.width, _scanSize.height);
    
    imageView = [[UIImageView alloc]initWithFrame:_scanRect];
    imageView.image = [UIImage imageNamed:@"contact_scanframe"];
    [self.view addSubview:imageView];
//    [imageView autoAlignAxis:ALAxisVertical toSameAxisOfView:self.view];
//    [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
//    [imageView autoSetDimensionsToSize:CGSizeMake(_scanSize.width, _scanSize.height)];
    
    UILabel * labIntroudction= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 290, 30)];
    labIntroudction.backgroundColor = [UIColor clearColor];
    labIntroudction.textColor=[UIColor whiteColor];
    labIntroudction.textAlignment = NSTextAlignmentCenter;
    labIntroudction.text=@"请对准二维码，即自动扫描";
    [self.view addSubview:labIntroudction];
    [labIntroudction autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:imageView];
    [labIntroudction autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:imageView];
    [labIntroudction autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:imageView withOffset:8];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50, 110, 220, 2)];
    _line.image = [UIImage imageNamed:@"line"];
    [self.view addSubview:_line];
    [_line autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:imageView withOffset:40];
    [_line autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:imageView withOffset:-40];
    [_line autoSetDimension:ALDimensionHeight toSize:2];
    [_line autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:imageView withOffset:10];
    
    [self setupCamera];
}

/**
     1 AVFoundation是基于session(会话)概念的。 一个session用于控制数据从input设备到output设备的流向。session允许定义音频视频录制的质量。
     2.capture device
     定义好session后，就该定义session所使用的设备AVCaptureDevice了。（使用AVMediaTypeVideo 来支持视频和图片）
     3.capture device input
     有了capture device, 然后就获取其input capture device， 并将该input device加到session上。
     4.preview
     在定义output device之前，我们可以先使用preview layer来显示一下camera buffer中的内容。这也将是相机的“取景器”。
     AVCaptureVideoPreviewLayer可以用来快速呈现相机(摄像头)所收集到的原始数据。
     使用第一步中定义的session来创建preview layer, 并将其添加到main view layer上。
     5.start Run
     最后需要start the session.
 */

- (void)setupCamera{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        // Device
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // Input
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
        
        /*
         // Output
         为了分析视频流,我们需要为output设置delegate,并且指定delegate方法在哪个线程被调用。需要主要的是,线程必须是串行的,确保视频帧按序到达。
         */
        _output = [[AVCaptureMetadataOutput alloc]init];
        //设置代理 在主线程里刷新
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        /*
         //AVCaptureMetadataOutput有个属性rectOfInterest,只处理在这个范围内捕获到的图像的信息。
         计算rectOfInterest 注意x,y交换位置(原因：AVCapture输出的图片大小都是横着的，而iPhone的屏幕是竖着的)
         
         在使用这个属性的时候。需要几点注意：
         
         1、这个CGRect参数和普通的Rect范围不太一样，它的四个值的范围都是0-1，表示比例。
         2、经过测试发现，这个参数里面的x对应的恰恰是距离左上角的垂直距离，y对应的是距离左上角的水平距离。
         3、宽度和高度设置的情况也是类似。
         */
        
        /*
         // Test 示例:
         CGRect rectTest = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64);
         _output.rectOfInterest = CGRectMake(rectTest.origin.y/SCREEN_HEIGHT, rectTest.origin.x/SCREEN_WIDTH, rectTest.size.height/SCREEN_HEIGHT, rectTest.size.width/SCREEN_WIDTH);
         scanRectView = [UIView new];
         [self.view addSubview:scanRectView];
         scanRectView.frame = rectTest;
         scanRectView.layer.borderColor = [UIColor redColor].CGColor;
         scanRectView.layer.borderWidth = 1;
         */
        
        _output.rectOfInterest = CGRectMake(_scanRect.origin.y/SCREEN_HEIGHT, _scanRect.origin.x/SCREEN_WIDTH, _scanRect.size.height/SCREEN_WIDTH, _scanRect.size.width/SCREEN_WIDTH);
        /**
         // Session
         *  AVCaptureSession 可以设置 sessionPreset 属性，这个决定了视频输入每一帧图像质量的大小。
         AVCaptureSessionPresetHigh 代表输入图片质量大小，一般来说AVCaptureSessionPreset640x480就够使用，但是如果要保证较小的二维码图片能快速扫描，最好设置高些, 如AVCaptureSessionPreset1920x1080(就是我们常说的1080p)。
         */
        _session = [[AVCaptureSession alloc]init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input])
        {
            [_session addInput:self.input];
        }
        
        if ([_session canAddOutput:self.output])
        {
            [_session addOutput:self.output];
        }
        
        // 条码类型 AVMetadataObjectTypeQRCode
        _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            // Preview
            _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
            _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
            _preview.frame = self.view.bounds;
            [self.view.layer insertSublayer:self.preview atIndex:0];
            // Start
            [_session startRunning];
        });
    });

}

#pragma mark -- AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if ( (metadataObjects.count == 0) )
    {
        return;
    }
    
    NSString *stringValue;
    
    if ([metadataObjects count] > 0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        [_session stopRunning];
        [timer invalidate];
        NSLog(@"%@",stringValue);
        
        if (stringValue.length > 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:metadataObject.stringValue message:@"" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
            
            [alert show];

        }
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
//    [self.session startRunning];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (hasCameraRight) {
        if (_session && ![_session isRunning]) {
            [_session startRunning];
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(sacnAnimation) userInfo:nil repeats:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [timer invalidate];
}

- (void)sacnAnimation{
    
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(CGRectGetMinX(_line.frame), 110+2*num, CGRectGetWidth(_line.frame), CGRectGetHeight(_line.frame));
        if (2 * num == CGRectGetHeight(imageView.frame) - 20) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(CGRectGetMinX(_line.frame), 110+2*num, CGRectGetWidth(_line.frame), CGRectGetHeight(_line.frame));
        if (num == 0) {
            upOrdown = NO;
        }
    }

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

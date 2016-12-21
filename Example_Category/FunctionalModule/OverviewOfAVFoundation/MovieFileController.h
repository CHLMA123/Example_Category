//
//  MovieFileController.h
//  Example_Category
//
//  Created by MCL on 16/9/7.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieFileController : UIViewController

@end

/*
 为了捕捉视频,我们需要这样几种类（与其它的子类）。
 
 AVCaptureDevice 代表了输入设备,例如摄像头与麦克风。
 
 AVCaptureInput 代表了输入数据源
 
 AVCaptureOutput 代表了输出数据源
 
 AVCaptureSession 用于协调输入与输出之间的数据流
 
 并且还有AVCaptureVideoPreviewLayer提供摄像头的预览功能
 
 */
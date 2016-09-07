//
//  AVFoundationController.h
//  Example_Category
//
//  Created by MCL on 16/9/7.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AVFoundationController : UIViewController

@end
/*
 一.概述
 在做图片和视频方面处理时有两种方法，一种是UIImagePickerController,另外一种方法是AVFoundation框架。
 UIImagePickerController是高封装的，所以我们利用它所提供的功能时就难免有些限制。当我们的应用对图片或
 视频的处理比较复杂时，就需要用的AVFoundation框架。利用这个框架我们首先要了解一些类：AVCaptureSession,
 AVCaptureInput、AVCaptureOutput、AVCaptureMovieFileOutput、AVCaptureStillImageOutput、
 AVCaptureVideoPreviewLayer、AVCaptureVideoDataOutput、AVCaptureAudioDataOutput、AVCaptureDevice等
 类。

 二.对关键类的概述
 1）AVCaptureDevice:代表硬件设备，我们可以从这个类中获取手机硬件的照相机、声音传感器等。当我们在应用程序
 中需要改变一些硬件设备的属性（例如：闪光模式改变、相机聚焦改变）的时候必须要调用lockForConfiguration
 为设备加锁，修改完成后调用unlockForConfiguration方法解锁。
 
 2）AVCaptureDeviceInput:设备输入数据管理对象，可以根据AVCaptureDevice创建对应的AVCaptureDeviceInput对象，
 该对象将会被添加到AVCaptureSession中管理。.代表输入设备，它配置抽象硬件设备的ports。通常的输入设备有（麦克风，
 相机等）。
 
 3）AVCaptureOutput:代表输出数据，输出的可以是图片（AVCaptureStillImageOutput）或者视频（
 AVCaptureMovieFileOutput）
 
 4）AVCaptureSession:媒体（音、视频）捕捉会话，负责把捕捉的音频视频数据输出到输出设备中。一个AVCaptureSession
 可以有多个输入或输出。它是连接AVCaptureInput和AVCaptureOutput的桥梁，它协调input到output之间传输数据。
 它有startRunning和stopRunning两种方法来开启会话和结束会话。每个session称之为一个会话，也就是在应用运行
 过程中如果你需要改变会话的一些配置（例如：切换摄像头）,此时需要先开启配置，配置完成之后再提交配置。
 改变会话的部分代码：
 //改变会话的配置前一定要先开启配置，配置完成后提交配置改变
 [self.captureSession beginConfiguration];
 //移除原有输入对象
 [self.captureSession removeInput:self.captureDeviceInput];
 //添加新的输入对象
 if ([self.captureSession canAddInput:toChangeDeviceInput]) {
 [self.captureSession addInput:toChangeDeviceInput];
 self.captureDeviceInput=toChangeDeviceInput;
 }
 //提交会话配置
 [self.captureSession commitConfiguration];
 
 5）AVCaptureConnection:以下是AVCaptrueConnection官方原话介绍-AVCaptureConnection represents a connection
 between an AVCaptureInputPort or ports, and an AVCaptureOutput or AVCaptureVideoPreviewLayer present
 in an AVCaptureSession.即它是一个连接，这个连接是inputPort和output之间或者是图像当前预览层和当前会话之间的。
 
 6）AVCaptureVideoPreviewLayer:它是图片预览层。我们的照片以及视频是如何显示在手机上的呢？那就是通过把这个对象添加到UIView 的layer上的。
 
 三.利用AVFoundation拍照并存储到本地相册的一般步骤如下：
 1）创建AVCaptureSession对象
 2）使用AVCaptureDevice的静态方法获得需要使用的设备。拍照和录像需要使用摄像头，录音就需要使用麦克风设备。
 3）利用输入设备AVCaptureDevice初始化AVCaptureDeviceInput对象。
 4）初始化输出设备管理对象，如果要拍照就初始化AVCaptureStillImageOutput对象；如果拍摄视频就初始化AVCaptureMovieFileOutput对象。
 5）将数据输入对象AVCaptureDeviceInput和数据输出对象AVCaptureOutput添加到AVCaptureSession中去。
 6）创建视频预览图层AVCaptureVideoPreviewLayer并指定媒体会话，添加图层到显示器中，调用AVCaptureSession中的stratRunning方法开始捕获图像。
 7）将捕获的音视频文件输出到指定文件。
 
 */
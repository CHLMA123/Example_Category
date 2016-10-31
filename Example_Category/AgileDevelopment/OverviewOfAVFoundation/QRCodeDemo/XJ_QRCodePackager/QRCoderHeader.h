//
//  QRCoderHeader.h
//  QRCodeDemo
//
//  Created by puxj on 16/9/12.
//  Copyright © 2016年 bcinfo. All rights reserved.
//

#ifndef QRCoderHeader_h
#define QRCoderHeader_h

//以iphone5s,iphone5为基础 坐标都以iphone5s,iphone5为基准 进行代码的适配
#define ratio         [[UIScreen mainScreen] bounds].size.width/320.0

//设置图片
#define ImgName(imagename) [UIImage imageNamed:imagename]


#define kBgImgX             45*ratio
#define kBgImgY             (60)*ratio
#define kBgImgWidth         230*ratio

#define kScrollLineHeight   20*ratio

#define kTipY               (kBgImgY+kBgImgWidth+kTipHeight)
#define kTipHeight          40*ratio

#define kLampX              ([[UIScreen mainScreen] bounds].size.width-kLampWidth)/2
#define kLampY              ([[UIScreen mainScreen] bounds].size.height-kLampWidth-30*ratio-64*ratio)
#define kLampWidth          64*ratio

#define kBgAlpha            0.6

static NSString *bgImg_img = @"image.bundle/scanBackground";
static NSString *Line_img = @"image.bundle/scanLine";
static NSString *turn_on = @"image.bundle/turn_on";
static NSString *turn_off = @"image.bundle/turn_off";
static NSString *ringPath = @"image.bundle/ring";
static NSString *ringType = @"wav";


#endif /* QRCoderHeader_h */

//
//  XJQRCodeViewController.h
//  QRCodeDemo
//
//  Created by puxj on 16/9/12.
//  Copyright © 2016年 bcinfo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^successBlock)(NSString *QRCodeInfo);

@interface XJQRCodeViewController : UIViewController

@property (strong, nonatomic) successBlock block;

/**
 *将扫码成功后获得的 二维码/条形码 信息进行回传
 */
- (void)successfulGetQRCodeInfo:(successBlock)success;

@end


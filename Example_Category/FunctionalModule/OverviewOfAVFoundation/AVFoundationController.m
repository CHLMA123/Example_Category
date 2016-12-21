//
//  AVFoundationController.m
//  Example_Category
//
//  Created by MCL on 16/9/7.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "AVFoundationController.h"
#import "QRCodeViewController.h"
#import "MovieFileController.h"

#import "QRCodeCreateViewController.h"
#import "XJQRCodeViewController.h"

@interface AVFoundationController ()

@end

@implementation AVFoundationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    scanBtn.frame = CGRectMake((SCREEN_WIDTH - 200)/2, 100, 200, 44);
    [scanBtn setTitle:@"SCAN" forState:UIControlStateNormal];
    [scanBtn setTitleColor:RGB_Black forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
    
    UIButton *VideoBtn = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    VideoBtn.frame = CGRectMake((SCREEN_WIDTH - 200)/2, CGRectGetMaxY(scanBtn.frame) + 20, 200, 44);
    [VideoBtn setTitle:@"RECORD" forState:UIControlStateNormal];
    [VideoBtn setTitleColor:RGB_Black forState:UIControlStateNormal];
    [VideoBtn addTarget:self action:@selector(videoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:VideoBtn];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom]
    ;
    settingBtn.frame = CGRectMake((SCREEN_WIDTH - 200)/2, CGRectGetMaxY(VideoBtn.frame) + 20, 200, 44);
    [settingBtn setTitle:@"SETTING Wi-Fi" forState:UIControlStateNormal];
    [settingBtn setTitleColor:RGB_Black forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(wifiButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:settingBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scanButtonAction{
    
    QRCodeViewController *vc = [[QRCodeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)videoButtonAction{
    
//    MovieFileController *vc = [[MovieFileController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    NSInteger indexPath = 0;
    switch (indexPath) {
            
        case 0: {
            
            QRCodeCreateViewController *codeVC = [[QRCodeCreateViewController alloc] init];
            codeVC.isHaveLogo = NO;
            [self.navigationController pushViewController:codeVC animated:YES];
            
        }
            break;
        case 1: {
            
            QRCodeCreateViewController *codeVC = [[QRCodeCreateViewController alloc] init];
            codeVC.isHaveLogo = YES;
            [self.navigationController pushViewController:codeVC animated:YES];
            
        }
            break;
        case 2: {
            
            XJQRCodeViewController *QRCodeVC = [[XJQRCodeViewController alloc] init];
            [self.navigationController pushViewController:QRCodeVC animated:YES];
            
        }
            break;
            
        default:
            break;
    }

    
}

/**
 *  iOS从App跳转至系统设置菜单各功能项的编写方法讲解 http://www.cnblogs.com/linxiu-0925/p/5500817.html
 *  具体详见【prefsIndex.png】
 */

/**
 *  跳到系统设置里的WiFi界面
 *  info里面设置:
 *  在项目中的info.plist中添加 URL types 并设置一项URL Schemes为prefs
 */
- (void)wifiButtonAction{
    
//    //打开应用的设置
    NSURL *url = [NSURL URLWithString:@"prefs:root=com.test.Example-Category"];
//    if (IOS_VERSION > 8.0) {
//        
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
//    }
    
//    NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
    return;
}

/*
 指定应用设置：prefs:root=应用bundleID //bundleID
 关于：About — prefs:root=General&path=About
 辅助功能：Accessibility — prefs:root=General&path=ACCESSIBILITY
 飞行模式：Airplane Mode On — prefs:root=AIRPLANE_MODE
 自动锁定：Auto-Lock — prefs:root=General&path=AUTOLOCK
 亮度：Brightness — prefs:root=Brightness
 蓝牙：Bluetooth — prefs:root=General&path=Bluetooth
 日期：Date & Time — prefs:root=General&path=DATE_AND_TIME
 视频：FaceTime — prefs:root=FACETIME
 通用：General — prefs:root=General
 键盘：Keyboard — prefs:root=General&path=Keyboard
 iCloud登录:iCloud — prefs:root=CASTLE
 语言和地区：International — prefs:root=General&path=INTERNATIONAL
 定位服务：Location Services — prefs:root=LOCATION_SERVICES
 音乐：Music — prefs:root=MUSIC
 备忘录：Notes — prefs:root=NOTES
 推送：Notification — prefs:root=NOTIFICATION
 相册：Photos — prefs:root=Photos
 描述文件：Profile — prefs:root=General&path=ManagedConfigurationList
 还原：Reset — prefs:root=General&path=Reset
 声音：Sounds — prefs:root=Sounds
 系统更新：Software Update — prefs:root=General&path=SOFTWARE_UPDATE_LINK
 AppStore:Store — prefs:root=STORE
 墙纸：Wallpaper — prefs:root=Wallpaper
 WiFi：Wi-Fi — prefs:root=WIFI
 热点 — prefs:root=INTERNET_TETHERING
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

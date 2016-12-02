//
//  AppDelegate.m
//  Example_Category
//
//  Created by MCL on 16/6/12.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MYLogManger.h"
#import "UIViewController+Swizzled.h"
#import "CrashReport.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (instancetype)appDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
/*
 - (void)setupBarStyle {
 
 [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
 [[UINavigationBar appearance] setTintColor:[UIColor redColor]];//系统返回的箭头颜色定制
 [[UIBarButtonItem appearance] setTitleTextAttributes:@{
 NSForegroundColorAttributeName: [UIColor whiteColor],
 NSFontAttributeName: [UIFont systemFontOfSize:17]}
 forState:UIControlStateNormal];//返回UIBarButtonItem的文字
 }
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 0 设置导航栏整体样式
    // [self setupBarStyle];
    // 1 To map the way inside an application
    SWIZZ_IT
    // 2 NSLog文件重定向
    [MYLogManger shareManger]; // 连接xcode时可以从监视器中看日志 没连接时Log日志会输出到文件中
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    [[CrashReport sharedInstance] startUp];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

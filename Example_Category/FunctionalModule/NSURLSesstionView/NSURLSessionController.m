//
//  NSURLSessionController.m
//  Example_Category
//
//  Created by MCL on 2016/11/11.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "NSURLSessionController.h"

@interface NSURLSessionController ()<NSURLSessionDataDelegate>

@end

@implementation NSURLSessionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSURLSessionConfiguration *defaultconfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
//    NSURLSession *defaultsession = [NSURLSession sessionWithConfiguration:defaultconfiguration];
//    NSURLSessionTask *task = [defaultsession dataTaskWithRequest:request
//                                               completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
//    {
//        NSLog(@"≥≥≥ %@",data);
//    }];
//    [task resume];
    
    
//    NSURLSessionConfiguration * defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    NSURLSession * defaultSession = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
//    
//    NSURLSessionTask * task= [defaultSession dataTaskWithRequest:request];
//    [task resume];
    
    [self testNStimerInRunLoop];
}

/**
 *   在子线程中使用定时器，将定时器添加到RunLoop中
 */
- (void)testNStimerInRunLoop{

    dispatch_queue_t queue = dispatch_queue_create("mm", DISPATCH_QUEUE_SERIAL);
    
    // 串行队列中执行异步任务
    dispatch_async(queue, ^{
        
        // 在子线程中使用定时器
        
        /*************************************************************/
        
        ///*
         
         // 第一种方式
         
         // 此种方式创建的timer已经添加至runloop中
         [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(doSomething) userInfo:nil repeats:NO];
         
         // 在线程中使用定时器，如果不启动run loop，timer的事件是不会响应的，而子线程中runloop默认没有启动
         // 让线程执行一个周期性的任务，如果不启动run loop， 线程跑完就可能被系统释放了
         [[NSRunLoop currentRunLoop] run];// 如果没有这句，doSomething将不会执行！！！
        
         //*/
        
        /*************************************************************/
        
        
        
        /*************************************************************/
        
//        // 第二种方式
//        NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(doAnything) userInfo:nil repeats:NO];
//        
//        // 将定时器添加到runloop中
//        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
//        
//        // 在线程中使用定时器，如果不启动run loop，timer的事件是不会响应的，而子线程中runloop默认没有启动
//        // 让线程执行一个周期性的任务，如果不启动run loop， 线程跑完就可能被系统释放了
//        [[NSRunLoop currentRunLoop] run];// 如果没有这句，doAnything将不会执行！！！
//        
        /*************************************************************/
        
        NSLog(@"子线程结束");
        
    });
}

- (void)doSomething{
    
    NSLog(@"doSomething...");
}

- (void)doAnything{
    
    NSLog(@"doAnything...");
}

//#pragma mark - NSURLSessionDataDelegate
////开始接受数据
//-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
//    NSLog(@"≥≥≥ =======%@",data);
//}
////接受数据结束
//-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
//    NSLog(@"≥≥≥ 完成：error%@",error);
//}

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

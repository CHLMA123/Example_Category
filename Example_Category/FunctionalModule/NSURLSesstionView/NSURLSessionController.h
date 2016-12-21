//
//  NSURLSessionController.h
//  Example_Category
//
//  Created by MCL on 2016/11/11.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "BaseViewController.h"

@interface NSURLSessionController : BaseViewController

@end

/*
 iOS的URL加载系统包含许多类与协议，这些类和协议相互协作完成URL加载的信息配置，协议支持，身份验证，cookie和缓存等功能。APPLE开发文档中有如下图表示他们之间的关系：URL加载框架.png
 
 备注：关于URL加载系统，在iOS7之后，NSURLSession是首选的API框架，在iOS9中NSURLConnection相关的方法被弃用，如果需要兼容十分旧的版本，依然需要使用NSURLConnection。
 
     1.NSURLRequest
     
     NSURLRequest类负责一个具体的网络请求，其内部封装一个请求路径NSURL对象。如果需要对请求参数进行配置，可以使用NSMutableURLRequest。
     2.NSURLResponse
     
     NSURLResponse类封装了相应数据，相应数据包括两部分，一部分是返回数据的状态码，数据长度、编码等信息，另一部分是内容数据本身。
     3.NSURLCredential、NSURLProtectionSpace、NSURLCredentialStorage、NSURLAuthenticatioChallenge
     
     一些访问请求需要证书或者身份凭证进行验证，上面4个类对请求凭证进行相关设置。
     4.NSURLCache
     
     在应用程序的开发中，为了减小对网络的依赖，提高程序性能，常常会对一些非实时性的数据进行缓存处理，NSURLCache类用于管理NSURLRequest请求缓存。
     5.NSHTTPCookieStorage、NSHTTPCookie
     
     NSHTTPCookieStorage与NSHTTPCookie用于持久化的存储HTTP请求的Cookie数据。
 */

/*  
 //NSURLRequest类中常用方法和属性总结
 
 //通过类方法创建默认的请求对象
 /*
     通过这种方式创建的请求对象 默认使用NSURLRequestUseProtocolCachePolicy缓存逻辑 默认请求超时时限为60s
     */
    // + (instancetype)requestWithURL:(NSURL *)URL;
    //返回一个BOOL值 用于判断是否支持安全编码
    // + (BOOL)supportsSecureCoding;
    //请求对象的初始化方法 创建时设置缓存逻辑和超时时限
    // + (instancetype)requestWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval;
    //init方法进行对象的创建 默认使用NSURLRequestUseProtocolCachePolicy缓存逻辑 默认请求超时时限为60s
    // - (instancetype)initWithURL:(NSURL *)URL;
    //init方法进行对象的创建
    // - (instancetype)initWithURL:(NSURL *)URL cachePolicy:(NSURLRequestCachePolicy)cachePolicy timeoutInterval:(NSTimeInterval)timeoutInterval;
    //只读属性 获取请求对象的URL
    // @property (nullable, readonly, copy) NSURL *URL;
    //只读属性 缓存策略枚举
    /*
     NSURLRequestCachePolicy枚举如下：
     typedef NS_ENUM(NSUInteger, NSURLRequestCachePolicy)
     {
     //默认的缓存协议
     NSURLRequestUseProtocolCachePolicy = 0,
     //无论有无本地缓存数据 都进行从新请求
     NSURLRequestReloadIgnoringLocalCacheData = 1,
     //忽略本地和远程的缓存数据 未实现的策略
     NSURLRequestReloadIgnoringLocalAndRemoteCacheData = 4,
     //无论有无缓存数据 都进行从新请求
     NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData,
     //先检查缓存 如果没有缓存再进行请求
     NSURLRequestReturnCacheDataElseLoad = 2,
     //类似离线模式，只读缓存 无论有无缓存都不进行请求
     NSURLRequestReturnCacheDataDontLoad = 3,
     //未实现的策略
     NSURLRequestReloadRevalidatingCacheData = 5, // Unimplemented
     };
     */
    // @property (readonly) NSURLRequestCachePolicy cachePolicy;
    //只读属性 获取请求的超时时限
    // @property (readonly) NSTimeInterval timeoutInterval;
    //主文档地址 这个地址用来存放缓存
    // @property (nullable, readonly, copy) NSURL *mainDocumentURL;
    //获取网络请求的服务类型 枚举如下
    /*
     typedef NS_ENUM(NSUInteger, NSURLRequestNetworkServiceType)
     {
     NSURLNetworkServiceTypeDefault = 0,	// Standard internet traffic
     NSURLNetworkServiceTypeVoIP = 1,	// Voice over IP control traffic
     NSURLNetworkServiceTypeVideo = 2,	// Video traffic
     NSURLNetworkServiceTypeBackground = 3, // Background traffic
     NSURLNetworkServiceTypeVoice = 4	   // Voice data
     };
     */
    // @property (readonly) NSURLRequestNetworkServiceType networkServiceType;
    //获取是否允许使用服务商蜂窝网络
    // @property (readonly) BOOL allowsCellularAccess;
//*/

// NSMutableURLRequest类中常用方法与属性总结
/*
     //设置请求的URL
     @property (nullable, copy) NSURL *URL;
     //设置请求的缓存策略
     @property NSURLRequestCachePolicy cachePolicy;
     //设置超时时间
     @property NSTimeInterval timeoutInterval;
     //设置缓存目录
     @property (nullable, copy) NSURL *mainDocumentURL;
     //设置网络服务类型
     @property NSURLRequestNetworkServiceType networkServiceType NS_AVAILABLE(10_7, 4_0);
     //设置是否允许使用服务商蜂窝网
     @property BOOL allowsCellularAccess NS_AVAILABLE(10_8, 6_0);
 */

/*
    NSURLRequest请求对象与HTTP/HTTPS协议相关请求的属性设置:
        以下属性的设置必须使用NSMutableURLRequest类，如果是NSURLRequest，则只可以读，不可以修改。
 */
/*
     //设置HPPT请求方式 默认为“GET”
     @property (copy) NSString *HTTPMethod;
     //通过字典设置HTTP请求头的键值数据
     @property (nullable, copy) NSDictionary<NSString *, NSString *> *allHTTPHeaderFields;
     //设置http请求头中的字段值
     - (void)setValue:(nullable NSString *)value forHTTPHeaderField:(NSString *)field;
     //向http请求头中添加一个字段
     - (void)addValue:(NSString *)value forHTTPHeaderField:(NSString *)field;
     //设置http请求体 用于POST请求
     @property (nullable, copy) NSData *HTTPBody;
     //设置http请求体的输入流
     @property (nullable, retain) NSInputStream *HTTPBodyStream;
     //设置发送请求时是否发送cookie数据
     @property BOOL HTTPShouldHandleCookies;
     //设置请求时是否按顺序收发 默认禁用 在某些服务器中设为YES可以提高网络性能
     @property BOOL HTTPShouldUsePipelining;
 */

/*
 NSRunLoop 学习笔记
 http://blog.iostalks.com/2016/05/25/NSRunLoop-study-note/
 
 NSRunLoop 在 iOS 中应该算是基础的概念，但在实际的编码中并不多见。最常用到的地方可能就是在有 ScrollView 的界面，为了防止定时器失效，需要将定时器加入到 NSRunLoopCommonModes 中去。
 
 然而，RunLoop 的用途远不止与此，我们在给程序下断点后，可以在主线程的调用栈中看到与 RunLoop 相关的函数，我们所写的代码都是通过 NSRunLoop 调用进去的。要深入理解 NSRunLoop 不仅需要反复理解基础概念，更重要的还是到 demo 中感受其运作方式。
 
 之前有个需求，要在子线程中持续处理定时器事件，就尝试实践了下 NSRunLoop，以下是在研究时提出的一些问题，并给出了理解之后的解答。
 1. 什么是 NSRunLoop
 
 一般来说，一个线程一次只能执行一个任务，任务执行完毕后线程便会退出。如果我们想让线程持续的为我们处理事件（比如点击屏幕），就需要有一个循环来阻止线程的退出。但是如果线程中一直在循环某块代码，就如同死循环了，无法再接收外部的事件。
 
 实际中，我们的应用程序是可以随时响应外部事件的，这就是 NSRunLoop 起的作用，RunLoop 为线程提供了事件循环的入口，并管理其需要处理的事件和消息。
 2. RunLoop 和线程之间的关系
 
 iOS 中线程默认会绑定有 RunLoop，每一个线程对应一个 RunLoop 对象。我们并不能自己创建 RunLoop，但是可以在当前线程使用 + currentRunLoop 获取，如果不主动获取，它就一直不会有。
 
 NSRunLoop 是基于 CFRunLoopRef 的封装，提供面向对象的 API， 但是 NSRunLoop 是线程不安全的。除了主线程外，只能在当前线程内部获取其 RunLoop。
 
 主线程的 RunLoop 会在 App 启动时自动的运行，子线程需要手动运行。在子线程中若只需要线性执行任务，那可以不用理会 RunLoop ；但是当需要在子线程中处理循环事件时，比如 NSTimer 事件，就必须要手动获取 RunLoop ，并保证线程不退出。
 3. RunLoop 退出（返回）是什么意思和线程退出有什么关系？
 
 在自定义线程中，RunLoop 的退出和线程的退出本质上并没有什么联系。接口文档中 RunLoop 有一下几种方式进入循环状态：
 
 // 运行 NSRunLoop，运行模式为默认的 NSDefaultRunLoopMode 模式，没有超时限制
 - (void)run;
 
 
 // 运行 NSRunLoop: 参数为运时间期限，运行模式为默认的 NSDefaultRunLoopMode 模式
 - (void)runUntilDate:(NSDate *)limitDate;
 
 
 // 运行 NSRunLoop: 参数为运行模式、时间期限，返回值为 YES 表示是处理事件后返回的，NO 表示是超时、强制停止运行或者当前 mode 下没有任何事件导致的返回
 - (BOOL)runMode:(NSString *)mode beforeDate:(NSDate *)limitDate;
 
 进入循环状态后，就类似进入了一个 do-while 循环。之后只有两种情况，要么退出循环，要么一直循环。退出循环代表 RunLoop 返回了，一直循环若没有事件加入 RunLoop 便会沉睡，接收到下一次事件时又会被唤醒。
 
 若 RunLoop 从循环状态中退出了，且线程的 main 函数中没有其他的循环包裹，那么执行完 main 方法后整个线程便会退出。
 
 为了保证线程的不退出，我们一般会在运行 Runloop 的外层用 while 循环包裹，形势如下：
 
 - (void)main
 {
 // 添加事件源
 [self myInstallCustomInputSource];
 while (!self.isCancelled)
 {
 [self doSomeTask];
 BOOL ret = [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
 beforeDate:[NSDate distantFuture]];
 NSLog(@"Exiting runloop: %d", ret);
 
 }
 }
 
 当线我们需要持续处理事件时，保持外部循环条件为 YES，这样即使 RunLoop 在执行事件时候退出了一次，也不会导致整个线程退出。
 4. RunLoop 何时退出？
 
 RunLoop 的退出与当前 mode 下的 item 密切相关。一个 RunLoop 包含若干个 Mode，每个 mode 又包含若干个 Source/Timer/Observer。 在子线程的 main 函数中启动 RunLoop，都需要指定一种 mode，默认情况下为 NSDefaultRunLoopMode。
 
 Source/Timer/Observer 被称为 mode item，若 mode 中一个 item 也没有，那么 RunLoop 就会从这种 mode 中退出。
 
 我们也可以手动调用 CFRunLoopStop(CFRunLoopRef rl) 方法来强制 RunLoop 退出，然而它只对 -runMode:beforeDate: 启动的 RunLoop 有效，对 -run 启动的无效。
 
 处理完 Input Source item 事件之后 RunLoop 就会退出，而处理 Timer item 事件不会导致 RunLoop 退出。
 
 系统提供的几个 -performSelector: API调用的 selector 被分发一次就会导致 RunLoop 退出，然而 performSelector:onThread: 和 performSelector:afterDelay: 比调特殊，它会向当前线程中加入 Timer，当再次进入 RunLoop 时，若无其他事件处理，RunLoop不会退出，而是进入睡眠状态。
 5. 什么时候需要用到 RunLoop？
 
 需要使用 Port 或者自定义 Input Source 与其他线程进行通信;
 需要在线程中使用 NSTimer;
 在子线程外部 performSelector:onThread: 方法到该线程。
 使用子线程执行周期性的任务;
 NSURLConnection 在子线程发起异步请求调用;
 
 参考：
 NSRunLoop Guide
 深入理解 NSRunLoop
 iOS多线程编程Part 1/3 - NSThread & Run Loop
 走进Run Loop的世界 (一)：什么是Run Loop？

 */

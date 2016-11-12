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



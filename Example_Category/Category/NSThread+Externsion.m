//
//  NSThread+Externsion.m
//  Example_Category
//
//  Created by APP on 2017/3/1.
//  Copyright © 2017年 MCL. All rights reserved.
//

/*
 主线程中也不绝对安全的 UI 操作 
 
 即使是在主线程中执行的代码，也很可能不是运行在主队列中(反之则必然)。但是在苹果的 MapKit 框架中，有一个叫做 addOverlay 的方法，它在底层实现的时候，不仅仅要求代码执行在主线程上，还要求执行在 GCD 的主队列上。 如果我们在子队列中调用 MapKit 的 addOverlay 方法，即使当前处于主线程，也会导致 bug 的产生，因为这个方法的底层实现判断的是主队列而非主线程。
 
 解决方案:
 
 由于提交到主队列的 block 一定在主线程运行，并且在 GCD 中线程切换通常都是由指定某个队列引起的，我们可以做一个更加严格的判断，即用判断是否处于主队列来代替是否处于主线程。
 使用 dispatch_queue_set_specific 和 dispatch_get_specific 这一组方法为主队列打上标记,用 isMainQueue 方法代替 [NSThread isMainThread] 即可获得更好的安全性。
 
 http://mp.weixin.qq.com/s?__biz=MzAxMzE2Mjc2Ng==&mid=2652155138&idx=1&sn=258d00352d18fc3d9dc333abb63bb477&mpshare=1&scene=23&srcid=0228nBY78MmgxDIpDyXMmi7x%23rd
 */

#import "NSThread+Externsion.h"

@implementation NSThread (Externsion)

- (BOOL)isMainQueue{
    
    static const void* mainQueueKey = @"mainQueue";
    static void* mainQueueContext = @"mainQueue";
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dispatch_queue_set_specific(dispatch_get_main_queue(), mainQueueKey, mainQueueContext, nil);
        
    });
    return dispatch_get_specific(mainQueueKey) == mainQueueContext;
}

@end

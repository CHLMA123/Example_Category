//
//  SingletonUI.h
//  Example_Category
//
//  Created by MCL on 16/9/7.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  在开发项目中，有很多时候我们需要一个全局的对象，而且要保证全局有且仅有一份即可。没错，单例在这个时候就是最佳的选择，但是需要注意的是：在多线程的环境下也需要做好线程保护。其实系统已经有很多单例存在，例如UIApplication、NSNotification、NSFileManager等等就是很不错的例子——我们总有时候需要用到单例模式，不过写起代码来还是需要考虑考虑。
 */

@interface SingleClass : UIView

+ (instancetype) shareInstance;

@end

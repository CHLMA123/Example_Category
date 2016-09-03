//
//  NSObject+modelConvertDic.h
//  PhotoManger
//
//  Created by foscom on 16/6/15.
//  Copyright © 2016年 zengjia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (modelConvertDic)<NSCoding>
// model 转化为字典
- (NSDictionary *)dictionaryFromModelWithShowLog:(BOOL)show;

// 字典转化 model
-(void)assginToPropertyWithDic:(NSDictionary *)dic;


@end

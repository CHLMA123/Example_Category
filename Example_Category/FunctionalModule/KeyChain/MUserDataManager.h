//
//  MAUserDataManager.h
//  MAPayPalDemo
//
//  Created by MCL on 16/3/19.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MUserDataManager : NSObject

/**
*  @brief  存储密码
*
*  @param  password    密码内容
*/
+ (void)savePassWord:(NSString *)password;
+ (void)savePassWord:(NSString *)password usrname:(NSString *)usrname;
/**
 *  @brief  读取密码
 *
 *  @return 密码内容
 */
+ (id)readPassWord;
+ (id)readPassWordwithAccount:(NSString *)usrname;
/**
 *  @brief  删除密码数据
 */
+ (void)deletePassWord;

@end

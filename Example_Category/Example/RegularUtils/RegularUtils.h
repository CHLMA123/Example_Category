//
//  RegularUtils.h
//  UimBank
//  正则表达式集成
//  Created by Jdb on 15/11/16.
//  Copyright © 2015年 Cheney Chan. All rights reserved.
//
//  ios中常用到的正则表达式大全，下载后只需添加两个类文件，调用类方法即可实现正则。
//  https://github.com/Jdb156158/DBRegularUtils

#import <Foundation/Foundation.h>

@interface RegularUtils : NSObject
//#pragma 正则匹配手机号
//+ (BOOL)checkTelNumber:(NSString *) telNumber;
//#pragma 正则匹配用户密码6-18位数字和字母组合
//+ (BOOL)checkPassword:(NSString *) password;
//#pragma 正则匹配用户姓名,20位的中文或英文
//+ (BOOL)checkUserName : (NSString *) userName;
//#pragma 正则匹配用户身份证号
//+ (BOOL)checkUserIdCard: (NSString *) idCard;
//#pragma 正则匹配验证码为4位数字
//+ (BOOL)checkUserCode: (NSString *) Code;
#pragma mark - Check email, phone, tel, or persion id.
/**
 *	Check whether the string is a valid kind of email format.
 *
 *	@param email The string to be checked.
 *
 *	@return YES if it is a valid format, otherwise false.
 */
+ (BOOL)hyb_isEmail:(NSString *)email;
/**
 *	Check whether the string is a valid kind of mobile phone format.
 *
 *  @param phone The phone to be checked.
 *
 *	@return YES if passed, otherwise false.
 */
+ (BOOL)hyb_isMobilePhone:(NSString *)phone;

/**
 *	Check whether it is a valid kind of tel number format.
 *
 *	@param telNumber	The tel number to be checked.
 *
 *	@return YES if passed, otherwise false.
 */
+ (BOOL)hyb_isTelNumber:(NSString *)telNumber;

/**
 *	Check whether it is a valid kind of Chinese Persion ID
 *
 *	@param PID	The Chinese Persion ID to be checked.
 *
 *	@return YES if it is valid kind of PID, otherwise false.
 */
+ (BOOL)hyb_isPersonID:(NSString *)PID;

@end

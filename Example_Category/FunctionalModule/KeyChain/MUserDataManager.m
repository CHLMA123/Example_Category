//
//  MAUserDataManager.m
//  MAPayPalDemo
//
//  Created by MCL on 16/3/19.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "MUserDataManager.h"
#import "MKeyChain.h"
/*
 使用keychain需要注意的问题
 
 当我们不支持Keychain Access Group，并且没有entitlement文件时，keychain默认以bundle id为group。
 如果我们在版本更新的时候改变了bundle id，那么新版本就访问不了旧版本的keychain信息了。
 解决办法是打开KeychainSharing，添加Keychain Access Group，并且指定每条keychain Item的group，私有的信息就指定app的bundle id为它的group。
 代码内Access group名称一定要有AppIdentifierPrefix前缀。
 Keychain是基于数据库存储，不允许添加重复的条目。所以每条item都必须指定对应的唯一标识符也就是那些主要的key，如果Key指定不正确，可能会出现添加后查找不到的问题。
 kSecAttrSynchronizable也会作为主要的key之一。它的value值默认为No，如果之前添加的item此条属性为YES，在搜索，更新，删除的时候必须添加此条属性才能查找到之前添加的item。
 Kechain item字典内添加自定义key时会出现参数不合法的错误。

 */
@implementation MUserDataManager

static NSString * const KEY_IN_KEYCHAIN = @"com.test.Example-Category.app.allinfo";// boundle ID 公用信息

static NSString * const KEY_PASSWORD = @"READMEKit.app.password";
static NSString * const KEY_USRNAME = @"READMEKit.app.usrname";

+ (void)savePassWord:(NSString *)password{
    
    [MUserDataManager savePassWord:password usrname:@""];
}

+ (void)savePassWord:(NSString *)password usrname:(NSString *)usrname{
    
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[MKeyChain load:KEY_IN_KEYCHAIN];
    if (!usernamepasswordKVPair) {
        usernamepasswordKVPair = [NSMutableDictionary dictionary];
    }
    [usernamepasswordKVPair setObject:password forKey:usrname];
    
    [MKeyChain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPair];
}

+ (id)readPassWord{
    
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[MKeyChain load:KEY_IN_KEYCHAIN];
    NSLog(@"usernamepasswordKVPair: %@", usernamepasswordKVPair);
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+ (id)readPassWordwithAccount:(NSString *)usrname{
    
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[MKeyChain load:KEY_IN_KEYCHAIN];
    NSLog(@"usernamepasswordKVPair: %@", usernamepasswordKVPair);
    return [usernamepasswordKVPair objectForKey:usrname];
}

+ (void)deletePassWord{
    
    [MKeyChain delete:KEY_IN_KEYCHAIN];
}

@end

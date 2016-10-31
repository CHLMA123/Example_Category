//
//  GetAllDeviceInfo.h
//  ClientTest
//
//  Created by foscom on 16/7/11.
//  Copyright © 2016年 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, InfoTypeName){
    IDFA,                   // 广告位标识符
    UUID,                   // 唯一识别码UUID
    UNIT_TYPE,              // 设备型号
    DEVICE_IP,              // 设备IP 地址
    MAC_ADDRESS,            // Mac 地址
    SYSTEM_NAME,            // 系统名称
    DEVICE_NAME,            // 设备名称
    APP_VERSION,            // 当前APP版本号
    DEVICE_MODEL,           // 设备类型
    DEVICE_TOKEN,
    BATTERY_LEVEL,          // 剩余电量
    SYSTEM_VERSION,         //  系统版本号
    LOCAL0ZIED_MODEL,
    WIFI_INFO              //获取WiFi 信息
};
@interface GetDeviceAllInfo : NSObject

+ (NSString *)UnitInfo:(InfoTypeName)infoName;

@end

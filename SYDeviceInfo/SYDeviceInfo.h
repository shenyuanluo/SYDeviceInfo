//
//  SYDeviceInfo.h
//  SYDeviceInfoExample
//
//  Created by shenyuanluo on 2017/11/27.
//  Copyright © 2017年 shenyuanluo. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 设备版本号枚举 */
typedef NS_ENUM(NSUInteger, SYNameType) {
    SYName_Unknow                   = 0x0000,                   // Unknow type
    SYName_Simulator                = 0x0001,                   // Simulator
    
    SYName_iPod                     = 0x0010,                   // iPod touch
    SYName_iPod__2                  = 0x0011,                   // iPod touch (2nd generation)
    SYName_iPod__3                  = 0x0012,                   // iPod touch (3rd generation)
    SYName_iPod__4                  = 0x0013,                   // iPod touch (4th generation)
    SYName_iPod__5                  = 0x0014,                   // iPod touch (5th generation)
    SYName_iPod__6                  = 0x0015,                   // iPod touch (6th generation)
    
    SYName_iPhone                   = 0x0100,                   // iPhone
    SYName_iPhone_3G                = 0x0101,                   // iPhone 3G
    SYName_iPhone_3GS               = 0x0102,                   // iPhone 3GS
    SYName_iPhone_4                 = 0x0103,                   // iPhone 4
    SYName_iPhone_4S                = 0x0104,                   // iPhone 4S
    SYName_iPhone_5                 = 0x0105,                   // iPhone 5
    SYName_iPhone_5C                = 0x0106,                   // iPhone 5c
    SYName_iPhone_5S                = 0x0107,                   // iPhone 5S
    SYName_iPhone_6                 = 0x0108,                   // iPhone 6
    SYName_iPhone_6_Plus            = 0x0109,                   // iPhone 6 Plus
    SYName_iPhone_6S                = 0x010A,                   // iPhone 6S
    SYName_iPhone_6S_Plus           = 0x010B,                   // iPhone 6S Plus
    SYName_iPhone_SE                = 0x010C,                   // iPhone SE
    SYName_iPhone_7                 = 0x010D,                   // iPhone 7
    SYName_iPhone_7_Plus            = 0x010E,                   // iPhone 7 Plus
    SYName_iPhone_8                 = 0x010F,                   // iPhone 8
    SYName_iPhone_8_Plus            = 0x0110,                   // iPhone 8 Plus
    SYName_iPhone_X                 = 0x0111,                   // iPhone X
    SYName_iPhone_XS                = 0x0112,                   // iPhone XS
    SYName_iPhone_XS_Max            = 0x0113,                   // iPhone XS Max
    SYName_iPhone_XR                = 0x0114,                   // iPhone XR
    SYName_iPhone_11                = 0x0115,                   // iPhone 11
    SYName_iPhone_11_Pro            = 0x0116,                   // iPhone 11 Pro
    SYName_iPhone_11_Pro_Max        = 0x0117,                   // iPhone 11 Pro Max
    
    SYName_iPad                     = 0x0200,                   // iPad
    SYName_iPad__2                  = 0x0201,                   // iPad 2
    SYName_iPad__3                  = 0x0202,                   // iPad (3rd generation)
    SYName_iPad__4                  = 0x0203,                   // iPad (4th generation)
    SYName_iPad__5                  = 0x0204,                   // iPad (5th generation)
    
    SYName_iPad_Air                 = 0x0300,                   // iPad Air
    SYName_iPad_Air__2              = 0x0301,                   // iPad Air 2
    
    SYName_iPad_Mini                = 0x0400,                   // iPad mini
    SYName_iPad_Mini__2             = 0x0401,                   // iPad mini 2
    SYName_iPad_Mini__3             = 0x0402,                   // iPad mini 3
    SYName_iPad_Mini__4             = 0x0403,                   // iPad mini 4
    
    SYName_iPad_Pro_9_7             = 0x0500,                   // iPad Pro (9.7-inch)
    
    SYName_iPad_Pro_10_5            = 0x0600,                   // iPad Pro (10.5-inch)
    
    SYName_iPad_Pro_12_9            = 0x0700,                   // iPad Pro (12.9-inch)
    SYName_iPad_Pro_12_9__2         = 0x0701,                   // iPad Pro (12.9-inch, 2nd generation)
};


/** 设备类型枚举 */
typedef NS_ENUM(NSUInteger, SYDeviceType) {
    SYType_Unknow                   = 0x00,                     // Unknow type
    SYType_Simulator                = 0x01,                     // Simulator
    SYType_iPod                     = 0x02,                     // iPod
    SYType_iPhone                   = 0x03,                     // iPhone
    SYType_iPad                     = 0x04,                     // iPad
};


/** 屏幕尺寸类型枚举 */
typedef NS_ENUM(NSUInteger, SYScreenType) {
    SYScreen_Unknow                 = 0x00,                     // Unknow screen size
    SYScreen_iPod_3_5               = 0x01,                     // iPod (3.5-inch)
    SYScreen_iPod_4_0               = 0x02,                     // iPod (4.0-inch)
    
    SYScreen_iPhone_3_5             = 0x10,                     // iPhone (3.5-inch)
    SYScreen_iPhone_4_0             = 0x11,                     // iPhone (4.0-inch)
    SYScreen_iPhone_4_7             = 0x12,                     // iPhone (4.7-inch)
    SYScreen_iPhone_5_5             = 0x13,                     // iPhone (5.5-inch)
    SYScreen_iPhone_5_8             = 0x14,                     // iPhone (5.8-inch)
    SYScreen_iPhone_6_1             = 0x15,                     // iPhone (6.1-inch)
    SYScreen_iPhone_6_5             = 0x16,                     // iPhone (6.5-inch)
    
    SYScreen_iPad_7_9               = 0x20,                     // iPad mini (7.9-inch)
    SYScreen_iPad_9_7               = 0x21,                     // iPad 、iPad Air (9.7-inch)
    SYScreen_iPad_10_5              = 0x22,                     // iPad Pro (10.5-inch)
    SYScreen_iPad_12_9              = 0x23,                     // iPad Pro (12.9-inch)
};


/** 电池状态枚举 */
typedef NS_ENUM(NSUInteger, SYBatteryState) {
    SYBattery_Unknow                = 0x00,                     // 未知
    SYBattery_Unplugged             = 0x01,                     // 未充电
    SYBattery_Charging              = 0x02,                     // 正在充电，未充满
    SYBattery_Full                  = 0x03,                     // 正在充电，且已充满
};

/** iOS 设备当前系统语言 详细列表参见：https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes */
typedef NS_ENUM(NSInteger, LanguageType) {
    Language_Chinese        = 0,    // 中文
    Language_English        = 1,    // 英语
    Language_Japanese       = 2,    // 日语
    Language_German         = 3,    // 德语
    Language_French         = 4,    // 法语
    Language_Spanish        = 5,    // 西班牙语
    Language_Korean         = 6,    // 韩语
};


@interface SYDeviceInfo : NSObject


/**
 获取当前设备的'名称'，参见'SYNameType'
 
 @return 具体的设备类型, 参见‘DeviceType’
 */
+ (SYNameType)syDeviceName;


/**
 获取当前设备的‘类型’，参见'SYDeviceType'
 
 @return 设备类型，参见‘SYDeviceType’
 */
+ (SYDeviceType)syDeviceType;


/**
 获取当前设备屏幕的‘大小’，参见'SYScreenType'
 
 @return 屏幕大小，参见‘ScreenType’
 */
+ (SYScreenType)syScreenType;


/**
 获取设备昵称
 
 @return 昵称
 */
+ (NSString *)syNickName;


/**
 获取通用唯一识别码‘UUID’
 
 @return UUID
 */
+ (NSString *)syUUID;


/**
 获取屏幕宽度
 
 @return 屏幕宽度
 */
+ (CGFloat)syDeviceWidth;


/**
 获取屏幕高度
 
 @return 屏幕高度
 */
+ (CGFloat)syDeviceHeight;

/**
 获取设备状态栏高度
 
 return 状态栏高度
 */
+ (CGFloat)syStatusBarHeight;

/**
 获取设备导航栏高度
 
 return 状态栏高度
 */
+ (CGFloat)syNavigationBarHeight;

/**
 获取设备状态栏 + 导航栏高度
 
 return 状态栏高度
 */
+ (CGFloat)syStatusAndNavBarHeight;

/**
 获取底部安全区域高度
 
 return 安全区域高度
 */
+ (CGFloat)syBottomSafeAreaHeight;


/**
 获取电池电量
 
 @return 电量
 */
+ (CGFloat)syBatteryLevel;


/**
 获取电池当前的状态
 
 @return 电池状态，参见‘SYBatteryState’
 */
+ (SYBatteryState)syBatteryState;


/**
 获取系统名称
 
 @return 系统名称
 */
+ (NSString *)sySystemName;


/**
 获取系统版本号
 
 @return 系统版本号
 */
+ (NSString *)sySystemVersion;


/**
 获取设备 IP
 
 @return 设备 IP
 */
+ (NSString *)syDeviceIp;


/**
 获取设备 MAC 地址
 
 @return 设备 MAC 地址
 */
+ (NSString *)syDeviceMac;


/**
 获取总内存大小
 
 @return 总内存大小
 */
+ (unsigned long long)syTotalMemory;


/**
 获取可用内存
 
 @return 可用内存
 */
+ (unsigned long long)syFreeMemory;


/**
 获取总存储空间大小
 
 @return 总存储空间大小
 */
+ (unsigned long long)syTotalSpace;


/**
 获取可用存储空间大小
 
 @return 可用存储空间大小
 */
+ (unsigned long long)syFreeSpace;

/**
 获取当前语言
 
 @return 当前语言
 */
+ (NSString *)syLanguage;

/**
 获取当前系统语言类型
 
 @return 语言类型，参见‘LanguageType’
 */
+ (LanguageType)syLanguageType;

/**
 获取型号名
 
 @return 设备型号名
 */
+ (NSString *)syModelName;

@end

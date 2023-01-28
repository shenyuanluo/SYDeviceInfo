//
//  SYDeviceInfo.m
//  SYDeviceInfoExample
//
//  Created by shenyuanluo on 2017/11/27.
//  Copyright © 2017年 shenyuanluo. All rights reserved.
//

#import "SYDeviceInfo.h"
#import <sys/utsname.h>
#import <sys/mount.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <mach/mach.h>
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>

@implementation SYDeviceInfo


#pragma mark --  获取当前设备的'名称'
+ (SYNameType)syDeviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary *deviceNamesByCode = nil;
    
    if (!deviceNamesByCode)
    {
        deviceNamesByCode = @{
                              @"i386"       : @(SYName_Simulator),
                              @"x86_64"     : @(SYName_Simulator),
                              
                              // iPod
                              @"iPod1,1"    : @(SYName_iPod),
                              @"iPod2,1"    : @(SYName_iPod__2),
                              @"iPod3,1"    : @(SYName_iPod__3),
                              @"iPod4,1"    : @(SYName_iPod__4),
                              @"iPod5,1"    : @(SYName_iPod__5),
                              @"iPod7,1"    : @(SYName_iPod__6),
                              @"iPod9,1"    : @(SYName_iPod__7),
                              
                              // iPhone
                              @"iPhone1,1"  : @(SYName_iPhone),
                              @"iPhone1,2"  : @(SYName_iPhone_3G),
                              @"iPhone2,1"  : @(SYName_iPhone_3GS),
                              
                              @"iPhone3,1"  : @(SYName_iPhone_4),
                              @"iPhone3,2"  : @(SYName_iPhone_4),
                              @"iPhone3,3"  : @(SYName_iPhone_4),
                              @"iPhone4,1"  : @(SYName_iPhone_4S),
                              
                              @"iPhone5,1"  : @(SYName_iPhone_5),
                              @"iPhone5,2"  : @(SYName_iPhone_5),
                              @"iPhone5,3"  : @(SYName_iPhone_5C),
                              @"iPhone5,4"  : @(SYName_iPhone_5C),
                              @"iPhone6,1"  : @(SYName_iPhone_5S),
                              @"iPhone6,2"  : @(SYName_iPhone_5S),
                              
                              @"iPhone7,2"  : @(SYName_iPhone_6),
                              @"iPhone7,1"  : @(SYName_iPhone_6_Plus),
                              @"iPhone8,1"  : @(SYName_iPhone_6S),
                              @"iPhone8,2"  : @(SYName_iPhone_6S_Plus),
                              
                              @"iPhone8,4"  : @(SYName_iPhone_SE),
                              
                              @"iPhone9,1"  : @(SYName_iPhone_7),
                              @"iPhone9,3"  : @(SYName_iPhone_7),
                              @"iPhone9,2"  : @(SYName_iPhone_7_Plus),
                              @"iPhone9,4"  : @(SYName_iPhone_7_Plus),
                              
                              @"iPhone10,1" : @(SYName_iPhone_8),
                              @"iPhone10,4" : @(SYName_iPhone_8),
                              @"iPhone10,2" : @(SYName_iPhone_8_Plus),
                              @"iPhone10,5" : @(SYName_iPhone_8_Plus),
                              
                              @"iPhone10,3" : @(SYName_iPhone_X),
                              @"iPhone10,6" : @(SYName_iPhone_X),
                              
                              @"iPhone11,2" : @(SYName_iPhone_XS),
                              @"iPhone11,4" : @(SYName_iPhone_XS_Max),
                              @"iPhone11,6" : @(SYName_iPhone_XS_Max),
                              @"iPhone11,8" : @(SYName_iPhone_XR),
                              
                              @"iPhone12,1" : @(SYName_iPhone_11),
                              @"iPhone12,3" : @(SYName_iPhone_11_Pro),
                              @"iPhone12,5" : @(SYName_iPhone_11_Pro_Max),
                              
                              @"iPhone12,8" : @(SYName_iPhone_SE_2),
                              @"iPhone13,1" : @(SYName_iPhone_12_mini),
                              @"iPhone13,2" : @(SYName_iPhone_12),
                              @"iPhone13,3" : @(SYName_iPhone_12_Pro),
                              @"iPhone13,4" : @(SYName_iPhone_12_Pro_Max),
                              
                              @"iPhone14,4" : @(SYName_iPhone_13_mini),
                              @"iPhone14,5" : @(SYName_iPhone_13),
                              @"iPhone14,2" : @(SYName_iPhone_13_Pro),
                              @"iPhone14,3" : @(SYName_iPhone_13_Pro_Max),
                              
                              @"iPhone14,6" : @(SYName_iPhone_SE_3),
                              @"iPhone14,7" : @(SYName_iPhone_14),
                              @"iPhone14,8" : @(SYName_iPhone_14_Plus),
                              @"iPhone15,2" : @(SYName_iPhone_14_Pro),
                              @"iPhone15,3" : @(SYName_iPhone_14_Pro_Max),
                              
                              // iPad
                              @"iPad1,1"    : @(SYName_iPad),
                              @"iPad2,1"    : @(SYName_iPad_2),
                              @"iPad2,2"    : @(SYName_iPad_2),
                              @"iPad2,3"    : @(SYName_iPad_2),
                              @"iPad2,4"    : @(SYName_iPad_2),
                              
                              @"iPad3,1"    : @(SYName_iPad_3),
                              @"iPad3,2"    : @(SYName_iPad_3),
                              @"iPad3,3"    : @(SYName_iPad_3),
                              
                              @"iPad3,4"    : @(SYName_iPad_4),
                              @"iPad3,5"    : @(SYName_iPad_4),
                              @"iPad3,6"    : @(SYName_iPad_4),
                              
                              @"iPad6,11"   : @(SYName_iPad_5),
                              @"iPad6,12"   : @(SYName_iPad_5),
                              
                              @"iPad7,5"   : @(SYName_iPad_6),
                              @"iPad7,6"   : @(SYName_iPad_6),
                              
                              @"iPad7,11"   : @(SYName_iPad_7),
                              @"iPad7,12"   : @(SYName_iPad_7),
                              
                              @"iPad11,6"   : @(SYName_iPad_8),
                              @"iPad11,7"   : @(SYName_iPad_8),
                              
                              @"iPad12,1"   : @(SYName_iPad_9),
                              @"iPad12,2"   : @(SYName_iPad_9),
                              
                              // iPad Air
                              @"iPad4,1"    : @(SYName_iPad_Air),
                              @"iPad4,2"    : @(SYName_iPad_Air),
                              @"iPad4,3"    : @(SYName_iPad_Air),
                              @"iPad5,3"    : @(SYName_iPad_Air_2),
                              @"iPad5,4"    : @(SYName_iPad_Air_2),
                              @"iPad11,3"   : @(SYName_iPad_Air_3),
                              @"iPad11,4"   : @(SYName_iPad_Air_3),
                              @"iPad13,1"   : @(SYName_iPad_Air_4),
                              @"iPad13,2"   : @(SYName_iPad_Air_4),
                              @"iPad13,16"  : @(SYName_iPad_Air_5),
                              @"iPad13,17"  : @(SYName_iPad_Air_5),
                              
                              // iPad mini
                              @"iPad2,5"    : @(SYName_iPad_Mini),
                              @"iPad2,6"    : @(SYName_iPad_Mini),
                              @"iPad2,7"    : @(SYName_iPad_Mini),
                              
                              @"iPad4,4"    : @(SYName_iPad_Mini_2),
                              @"iPad4,5"    : @(SYName_iPad_Mini_2),
                              @"iPad4,6"    : @(SYName_iPad_Mini_2),
                              
                              @"iPad4,7"    : @(SYName_iPad_Mini_3),
                              @"iPad4,8"    : @(SYName_iPad_Mini_3),
                              @"iPad4,9"    : @(SYName_iPad_Mini_3),
                              
                              @"iPad5,1"    : @(SYName_iPad_Mini_4),
                              @"iPad5,2"    : @(SYName_iPad_Mini_4),
                              
                              @"iPad11,1"    : @(SYName_iPad_Mini_5),
                              @"iPad11,2"    : @(SYName_iPad_Mini_5),
                              
                              @"iPad14,1"    : @(SYName_iPad_Mini_6),
                              @"iPad14,2"    : @(SYName_iPad_Mini_6),
                              
                              // iPad Pro
                              @"iPad6,3"    : @(SYName_iPad_Pro_9_7),
                              @"iPad6,4"    : @(SYName_iPad_Pro_9_7),
                              
                              @"iPad7,3"    : @(SYName_iPad_Pro_10_5),
                              @"iPad7,4"    : @(SYName_iPad_Pro_10_5),
                              
                              @"iPad8,1"    : @(SYName_iPad_Pro_11__1),
                              @"iPad8,2"    : @(SYName_iPad_Pro_11__1),
                              @"iPad8,3"    : @(SYName_iPad_Pro_11__1),
                              @"iPad8,4"    : @(SYName_iPad_Pro_11__1),
                              
                              @"iPad8,9"    : @(SYName_iPad_Pro_11__2),
                              @"iPad8,10"   : @(SYName_iPad_Pro_11__2),
                              
                              @"iPad13,4"   : @(SYName_iPad_Pro_11__3),
                              @"iPad13,5"   : @(SYName_iPad_Pro_11__3),
                              @"iPad13,6"   : @(SYName_iPad_Pro_11__3),
                              @"iPad13,7"   : @(SYName_iPad_Pro_11__3),
                              
                              @"iPad6,7"    : @(SYName_iPad_Pro_12_9),
                              @"iPad6,8"    : @(SYName_iPad_Pro_12_9),
                              
                              @"iPad7,1"    : @(SYName_iPad_Pro_12_9__2),
                              @"iPad7,2"    : @(SYName_iPad_Pro_12_9__2),
                              
                              @"iPad8,5"    : @(SYName_iPad_Pro_12_9__3),
                              @"iPad8,6"    : @(SYName_iPad_Pro_12_9__3),
                              @"iPad8,7"    : @(SYName_iPad_Pro_12_9__3),
                              @"iPad8,8"    : @(SYName_iPad_Pro_12_9__3),
                              
                              @"iPad8,11"   : @(SYName_iPad_Pro_12_9__4),
                              @"iPad8,12"   : @(SYName_iPad_Pro_12_9__4),
                              
                              @"iPad13,8"   : @(SYName_iPad_Pro_12_9__5),
                              @"iPad13,9"   : @(SYName_iPad_Pro_12_9__5),
                              @"iPad13,10"  : @(SYName_iPad_Pro_12_9__5),
                              @"iPad13,11"  : @(SYName_iPad_Pro_12_9__5),
                              };
    }
    
    NSNumber *nameNumber = [deviceNamesByCode objectForKey:code];
    if(nameNumber)
    {
        return [nameNumber unsignedIntegerValue];
    }
    
    return SYName_Unknow;
}


#pragma mark -- 获取当前设备的‘类型’
+ (SYDeviceType)syDeviceType
{
    SYDeviceType deviceType = SYType_Unknow;
    
    SYNameType nameType = [self syDeviceName];
    if (SYName_Simulator == nameType)
    {
        deviceType = SYType_Simulator;
    }
    else if (SYName_iPod == nameType
             || SYName_iPod__2 == nameType
             || SYName_iPod__3 == nameType
             || SYName_iPod__4 == nameType
             || SYName_iPod__5 == nameType
             || SYName_iPod__6 == nameType
             || SYName_iPod__7 == nameType)
    {
        deviceType = SYType_iPod;
    }
    else if (SYName_iPhone == nameType
             || SYName_iPhone_3G == nameType
             || SYName_iPhone_3GS == nameType
             || SYName_iPhone_4 == nameType
             || SYName_iPhone_4S == nameType
             || SYName_iPhone_5 == nameType
             || SYName_iPhone_5C == nameType
             || SYName_iPhone_5S == nameType
             || SYName_iPhone_6 == nameType
             || SYName_iPhone_6_Plus == nameType
             || SYName_iPhone_6S == nameType
             || SYName_iPhone_6S_Plus == nameType
             || SYName_iPhone_SE == nameType
             || SYName_iPhone_7 == nameType
             || SYName_iPhone_7_Plus == nameType
             || SYName_iPhone_8 == nameType
             || SYName_iPhone_8_Plus == nameType
             || SYName_iPhone_X == nameType
             
             || SYName_iPhone_XS == nameType
             || SYName_iPhone_XS_Max == nameType
             || SYName_iPhone_XR == nameType
             || SYName_iPhone_11 == nameType
             || SYName_iPhone_11_Pro == nameType
             || SYName_iPhone_11_Pro_Max == nameType
             
             || SYName_iPhone_SE_2 == nameType
             || SYName_iPhone_12_mini == nameType
             || SYName_iPhone_12 == nameType
             || SYName_iPhone_12_Pro == nameType
             || SYName_iPhone_12_Pro_Max == nameType
             
             || SYName_iPhone_13_mini == nameType
             || SYName_iPhone_13 == nameType
             || SYName_iPhone_13_Pro == nameType
             || SYName_iPhone_13_Pro_Max == nameType
             
             || SYName_iPhone_SE_3 == nameType
             || SYName_iPhone_14 == nameType
             || SYName_iPhone_14_Plus == nameType
             || SYName_iPhone_14_Pro == nameType
             || SYName_iPhone_14_Pro_Max == nameType)
    {
        deviceType = SYType_iPhone;
    }
    else if (SYName_iPad == nameType
             || SYName_iPad_2 == nameType
             || SYName_iPad_3 == nameType
             || SYName_iPad_4 == nameType
             || SYName_iPad_5 == nameType
             || SYName_iPad_6 == nameType
             || SYName_iPad_7 == nameType
             || SYName_iPad_8 == nameType
             || SYName_iPad_9 == nameType
             || SYName_iPad_Air == nameType
             || SYName_iPad_Air_2 == nameType
             || SYName_iPad_Air_3 == nameType
             || SYName_iPad_Air_4 == nameType
             || SYName_iPad_Air_5 == nameType
             || SYName_iPad_Mini == nameType
             || SYName_iPad_Mini_2 == nameType
             || SYName_iPad_Mini_3 == nameType
             || SYName_iPad_Mini_4 == nameType
             || SYName_iPad_Mini_5 == nameType
             || SYName_iPad_Mini_6 == nameType
             || SYName_iPad_Pro_9_7 == nameType
             || SYName_iPad_Pro_10_5 == nameType
             || SYName_iPad_Pro_11__1 == nameType
             || SYName_iPad_Pro_11__2 == nameType
             || SYName_iPad_Pro_11__3 == nameType
             || SYName_iPad_Pro_12_9 == nameType
             || SYName_iPad_Pro_12_9__2 == nameType
             || SYName_iPad_Pro_12_9__3 == nameType
             || SYName_iPad_Pro_12_9__4 == nameType
             || SYName_iPad_Pro_12_9__5 == nameType)
    {
        deviceType = SYType_iPad;
    }
    
    return deviceType;
}


#pragma mark -- 获取当前设备屏幕的‘大小’
+ (SYScreenType)syScreenType
{
    SYScreenType screenSize = SYScreen_Unknow;
    
    SYNameType nameType = [self syDeviceName];
    
    if (SYName_iPod == nameType
        || SYName_iPad_2 == nameType
        || SYName_iPad_3 == nameType
        || SYName_iPad_4 == nameType)
    {
        screenSize = SYScreen_iPod_3_5;
    }
    else if (SYName_iPod__5 == nameType
             || SYName_iPod__6 == nameType
             || SYName_iPod__7 == nameType)
    {
        screenSize = SYScreen_iPod_4_0;
    }
    else if (SYName_iPhone_3G == nameType
             || SYName_iPhone_3GS == nameType
             || SYName_iPhone_4 == nameType
             || SYName_iPhone_4S == nameType)
    {
        screenSize = SYScreen_iPhone_3_5;
    }
    else if (SYName_iPhone_5 == nameType
             || SYName_iPhone_5C == nameType
             || SYName_iPhone_5S == nameType
             || SYName_iPhone_SE == nameType)
    {
        screenSize = SYScreen_iPhone_4_0;
    }
    else if (SYName_iPhone_6 == nameType
             || SYName_iPhone_6S == nameType
             || SYName_iPhone_7 == nameType
             || SYName_iPhone_8 == nameType)
    {
        screenSize = SYScreen_iPhone_4_7;
    }
    else if (SYName_iPhone_12_mini == nameType
             || SYName_iPhone_13_mini == nameType)
    {
        screenSize = SYScreen_iPhone_5_4;
    }
    else if (SYName_iPhone_6_Plus == nameType
             || SYName_iPhone_6S_Plus == nameType
             || SYName_iPhone_7_Plus == nameType
             || SYName_iPhone_8_Plus == nameType
             || SYName_iPhone_SE_2 == nameType
             || SYName_iPhone_SE_3 == nameType)
    {
        screenSize = SYScreen_iPhone_5_5;
    }
    else if (SYName_iPhone_X == nameType
             || SYName_iPhone_XS == nameType
             || SYName_iPhone_11_Pro == nameType)
    {
        screenSize = SYScreen_iPhone_5_8;
    }
    else if (SYName_iPhone_XR == nameType
             || SYName_iPhone_11 == nameType
             || SYName_iPhone_12 == nameType
             || SYName_iPhone_12_Pro == nameType
             || SYName_iPhone_13 == nameType
             || SYName_iPhone_13_Pro == nameType
             || SYName_iPhone_14 == nameType
             || SYName_iPhone_14_Pro == nameType)
    {
        screenSize = SYScreen_iPhone_6_1;
    }
    else if (SYName_iPhone_XS_Max == nameType
             || SYName_iPhone_11_Pro_Max == nameType)
    {
        screenSize = SYScreen_iPhone_6_5;
    }
    else if (SYName_iPhone_12_Pro_Max == nameType
             || SYName_iPhone_13_Pro_Max == nameType
             || SYName_iPhone_14_Plus == nameType
             || SYName_iPhone_14_Pro_Max == nameType)
    {
        screenSize = SYScreen_iPhone_6_7;
    }
    else if (SYName_iPad_Mini == nameType
             || SYName_iPad_Mini_2 == nameType
             || SYName_iPad_Mini_3 == nameType
             || SYName_iPad_Mini_4 == nameType
             || SYName_iPad_Mini_5 == nameType)
    {
        screenSize = SYScreen_iPad_7_9;
    }
    else if (SYName_iPad_Mini_6 == nameType)
    {
        screenSize = SYScreen_iPad_8_3;
    }
    else if (SYName_iPad == nameType
             || SYName_iPad_2 == nameType
             || SYName_iPad_3 == nameType
             || SYName_iPad_4 == nameType
             || SYName_iPad_5 == nameType
             || SYName_iPad_6 == nameType
             || SYName_iPad_Air == nameType
             || SYName_iPad_Air_2 == nameType
             || SYName_iPad_Pro_9_7 == nameType)
    {
        screenSize = SYScreen_iPad_9_7;
    }
    else if (SYName_iPad_7 == nameType
             || SYName_iPad_8 == nameType
             || SYName_iPad_9 == nameType)
    {
        screenSize = SYScreen_iPad_10_2;
    }
    else if (SYName_iPad_Pro_10_5 == nameType
             || SYName_iPad_Air_3 == nameType)
    {
        screenSize = SYScreen_iPad_10_5;
    }
    else if (SYName_iPad_Pro_11__1 == nameType
             || SYName_iPad_Pro_11__2 == nameType
             || SYName_iPad_Pro_11__3 == nameType)
    {
        screenSize = SYScreen_iPad_11;
    }
    else if (SYName_iPad_Air_4 == nameType
             || SYName_iPad_Air_5 == nameType)
    {
        screenSize = SYScreen_iPad_10_9;
    }
    else if (SYName_iPad_Pro_12_9 == nameType
             || SYName_iPad_Pro_12_9__2 == nameType
             || SYName_iPad_Pro_12_9__3 == nameType
             || SYName_iPad_Pro_12_9__4 == nameType
             || SYName_iPad_Pro_12_9__5 == nameType)
    {
        screenSize = SYScreen_iPad_12_9;
    }
    
    return screenSize;
}


#pragma mark -- 获取设备昵称
+ (NSString *)syNickName
{
    return [UIDevice currentDevice].name;
}


#pragma mark -- 获取通用唯一识别码‘UUID’
+ (NSString *)syUUID
{
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}


#pragma mark -- 获取屏幕宽度
+ (CGFloat)syDeviceWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}


#pragma mark -- 获取屏幕高度
+ (CGFloat)syDeviceHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}

#pragma mark -- 获取状态栏高度
+ (CGFloat)syStatusBarHeight
{
    CGFloat statusBarHeight;
    SYScreenType screenType = [self syScreenType];
    switch (screenType)
    {
        case SYScreen_iPhone_4_0:
        case SYScreen_iPhone_4_7:
        case SYScreen_iPhone_5_5:
        {
            statusBarHeight = 20.0f;
        }
            break;
            
        case SYScreen_iPhone_5_8:
        case SYScreen_iPhone_6_1:
        case SYScreen_iPhone_6_5:
        {
            statusBarHeight = 44.0f;
        }
            break;
            
        default:
        {
            statusBarHeight = 20.0f;
        }
            break;
    }
    return statusBarHeight;
}

#pragma mark -- 获取设备导航栏高度
+ (CGFloat)syNavigationBarHeight
{
    return 44.0f;
}

#pragma mark -- 获取设备状态栏 + 导航栏高度
+ (CGFloat)syStatusAndNavBarHeight
{
    return [self syStatusBarHeight] + [self syNavigationBarHeight];
}

#pragma mark -- 获取底部安全区域高度
+ (CGFloat)syBottomSafeAreaHeight
{
    CGFloat safeAreaHeight;
    SYScreenType screenType = [self syScreenType];
    switch (screenType)
    {
        case SYScreen_iPhone_4_0:
        case SYScreen_iPhone_4_7:
        case SYScreen_iPhone_5_5:
        {
            safeAreaHeight = 0.0f;
        }
            break;
            
        case SYScreen_iPhone_5_8:
        case SYScreen_iPhone_6_1:
        case SYScreen_iPhone_6_5:
        {
            safeAreaHeight = 34.0f;
        }
            break;
            
        default:
        {
            safeAreaHeight = 0.0f;
        }
            break;
    }
    return safeAreaHeight;
}

#pragma mark -- 获取电池电量
+ (CGFloat)syBatteryLevel
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;    // 需要设置为YES，否则电池电量无法获取
    return [UIDevice currentDevice].batteryLevel;
}


#pragma mark -- 获取电池状态
+ (SYBatteryState)syBatteryState
{
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;    // 需要设置为YES，否则电池状态无法获取
    UIDeviceBatteryState batteryState = [UIDevice currentDevice].batteryState;
    switch (batteryState)
    {
        case UIDeviceBatteryStateUnknown:
            return SYBattery_Unknow;
            break;
            
        case UIDeviceBatteryStateUnplugged:
            return SYBattery_Unplugged;
            break;
            
        case UIDeviceBatteryStateCharging:
            return SYBattery_Charging;
            break;
            
        case UIDeviceBatteryStateFull:
            return SYBattery_Full;
            break;
            
        default:
            return SYBattery_Unknow;
            break;
    }
}


#pragma mark -- 获取系统名称
+ (NSString *)sySystemName
{
    return [UIDevice currentDevice].systemName;
}


#pragma mark -- 获取系统版本号
+ (NSString *)sySystemVersion
{
    return [UIDevice currentDevice].systemVersion;
}


#pragma mark -- 获取设备 IP
+ (NSString *)syDeviceIp
{
    NSString *address = @"Error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *tempAddr   = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    if (0 != success)   // 获取失败
    {
        return address;
    }
    
    tempAddr = interfaces;
    
    while (NULL != tempAddr)
    {
        if(AF_INET == tempAddr->ifa_addr->sa_family)
        {
            if ([[NSString stringWithUTF8String:tempAddr->ifa_name] isEqualToString:@"en0"])
            {
                // 转换
                address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)tempAddr->ifa_addr)->sin_addr)];
            }
        }
        tempAddr = tempAddr->ifa_next;
    }
    
    freeifaddrs(interfaces);
    return address;
}


#pragma mark --  获取设备 MAC 地址
+ (NSString *)syDeviceMac
{
    int mib[6];
    size_t len;
    char* buffer;
    unsigned char* ptr;
    struct if_msghdr* ifm;
    struct sockaddr_dl* sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if (0 == (mib[5] = if_nametoindex("en0")))
    {
        NSLog(@"Error: if_nametoindex error !");
        return NULL;
    }
    
    if (0 > sysctl(mib, 6, NULL, &len, NULL, 0))
    {
        NSLog(@"Error: sysctl error !");
        return NULL;
    }
    
    if (NULL == (buffer = malloc(len)))
    {
        NSLog(@"Error: malloc error !");
        return NULL;
    }
    
    if (0 > sysctl(mib, 6, buffer, &len, NULL, 0))
    {
        printf("Error: sysctl error !");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buffer;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    
    NSString *macAddr = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buffer);
    
    return [macAddr uppercaseString];
}


#pragma mark -- 获取总内存
+ (unsigned long long)syTotalMemory
{
    return [NSProcessInfo processInfo].physicalMemory;
}


#pragma mark -- 获取可用内存
+ (unsigned long long)syFreeMemory
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (KERN_SUCCESS != kernReturn)
    {
        return NSNotFound;
    }
    
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}


#pragma mark -- 总存储空间大小
+ (unsigned long long)syTotalSpace
{
    struct statfs buffer;
    unsigned long long maxspace = 0;
    
    if (0 <= statfs("/", &buffer))
    {
        maxspace = (unsigned long long)buffer.f_bsize * buffer.f_blocks;
    }
    if (0 <= statfs("/private/var", &buffer))
    {
        maxspace += (unsigned long long)buffer.f_bsize * buffer.f_blocks;
    }
    
    return maxspace;
}


#pragma mark -- 可用存储空间大小
+ (unsigned long long)syFreeSpace
{
    struct statfs buffer;
    long long freespace = 0;
    
    if(0 <= statfs("/var", &buffer))
    {
        freespace = (unsigned long long)(buffer.f_bsize * buffer.f_bfree);
    }
    return freespace;
}


#pragma mark -- 获取语言
+ (NSString *)syLanguage
{
    NSString *language = [[NSLocale preferredLanguages] firstObject];
    NSLog(@"language = %@", language);
    return language;
}

+ (LanguageType)syLanguageType
{
    NSString *language = [self syLanguage];
    static NSDictionary *languageByCode = nil;
    
    if (!languageByCode) {
        
        languageByCode = @{
                           @"zh" : @(Language_Chinese),
                           @"en" : @(Language_English),
                           @"ja" : @(Language_Japanese),
                           @"de" : @(Language_German),
                           @"fr" : @(Language_French),
                           @"es" : @(Language_Spanish),
                           @"ko" : @(Language_Korean),
                           };
    }
    NSString *localeLanguageCode = [language substringToIndex:2];
    
    NSLog(@"localeLanguageCode = %@", localeLanguageCode);
    
    return [languageByCode[localeLanguageCode] integerValue];
}

#pragma mark -- 获取型号名
+ (NSString *)syModelName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    
    // 模拟器
    if ([@"i386" isEqualToString:code] || [@"x86_64" isEqualToString:code])
    {
        return @"Simulator";
    }
    // iPod
    else if ([@"iPod1,1" isEqualToString:code])
    {
        return @"iPod touch";
    }
    else if ([@"iPod2,1" isEqualToString:code])
    {
        return @"iPod touch 2";
    }
    else if ([@"iPod3,1" isEqualToString:code])
    {
        return @"iPod touch 3";
    }
    else if ([@"iPod4,1" isEqualToString:code])
    {
        return @"iPod touch 4";
    }
    else if ([@"iPod5,1" isEqualToString:code])
    {
        return @"iPod touch 5";
    }
    else if ([@"iPod7,1" isEqualToString:code])
    {
        return @"iPod touch 6";
    }
    else if ([@"iPod9,1" isEqualToString:code])
    {
        return @"iPod touch 7";
    }
    // iPhone
    else if ([@"iPhone1,1" isEqualToString:code])
    {
        return @"iPhone";
    }
    else if ([@"iPhone1,2" isEqualToString:code])
    {
        return @"iPhone 3G";
    }
    else if ([@"iPhone2,1" isEqualToString:code])
    {
        return @"iPhone 3GS";
    }
    else if ([@"iPhone3,1" isEqualToString:code] || [@"iPhone3,2" isEqualToString:code] || [@"iPhone3,3" isEqualToString:code])
    {
        return @"iPhone 4";
    }
    else if ([@"iPhone4,1" isEqualToString:code])
    {
        return @"iPhone 4S";
    }
    else if ([@"iPhone5,1" isEqualToString:code] || [@"iPhone5,2" isEqualToString:code])
    {
        return @"iPhone 5";
    }
    else if ([@"iPhone5,3" isEqualToString:code] || [@"iPhone5,4" isEqualToString:code])
    {
        return @"iPhone 5C";
    }
    else if ([@"iPhone6,1" isEqualToString:code] || [@"iPhone6,2" isEqualToString:code])
    {
        return @"iPhone 5S";
    }
    else if ([@"iPhone7,2" isEqualToString:code])
    {
        return @"iPhone 6";
    }
    else if ([@"iPhone7,1" isEqualToString:code])
    {
        return @"iPhone 6-Plus";
    }
    else if ([@"iPhone8,1" isEqualToString:code])
    {
        return @"iPhone 6S";
    }
    else if ([@"iPhone8,2" isEqualToString:code])
    {
        return @"iPhone 6S-Plus";
    }
    else if ([@"iPhone8,4" isEqualToString:code])
    {
        return @"iPhone SE";
    }
    else if ([@"iPhone12,8" isEqualToString:code])
    {
        return @"iPhone SE 2";
    }
    else if ([@"iPhone14,6" isEqualToString:code])
    {
        return @"iPhone SE 3";
    }
    else if ([@"iPhone9,1" isEqualToString:code] || [@"iPhone9,3" isEqualToString:code])
    {
        return @"iPhone 7";
    }
    else if ([@"iphone9,2" isEqualToString:code] || [@"iphone9,4" isEqualToString:code])
    {
        return @"iPhone 7-Plsu";
    }
    else if ([@"iPhone10,1" isEqualToString:code] || [@"iPhone10,4" isEqualToString:code])
    {
        return @"iPhone 8";
    }
    else if ([@"iPhone10,2" isEqualToString:code] || [@"iPhone10,5" isEqualToString:code])
    {
        return @"iPhone 8-Plsu";
    }
    else if ([@"iPhone10,3" isEqualToString:code] || [@"iPhone10,6" isEqualToString:code])
    {
        return @"iPhone X";
    }
    else if ([@"iPhone11,2" isEqualToString:code])
    {
        return @"iPhone XS";
    }
    else if ([@"iPhone11,4" isEqualToString:code] || [@"iPhone11,6" isEqualToString:code])
    {
        return @"iPhone XS-Max";
    }
    else if ([@"iPhone11,8" isEqualToString:code])
    {
        return @"iPhone XR";
    }
    else if ([@"iPhone12,1" isEqualToString:code])
    {
        return @"iPhone 11";
    }
    else if ([@"iPhone12,2" isEqualToString:code])
    {
        return @"iPhone 11 Pro";
    }
    else if ([@"iPhone12,3" isEqualToString:code])
    {
        return @"iPhone 11 Pro Max";
    }
    else if ([@"iPhone13,1" isEqualToString:code])
    {
        return @"iPhone 12 mini";
    }
    else if ([@"iPhone13,2" isEqualToString:code])
    {
        return @"iPhone 12";
    }
    else if ([@"iPhone13,3" isEqualToString:code])
    {
        return @"iPhone 12 Pro";
    }
    else if ([@"iPhone13,4" isEqualToString:code])
    {
        return @"iPhone 12 Pro Max";
    }
    
    else if ([@"iPhone14,4" isEqualToString:code])
    {
        return @"iPhone 13_mini";
    }
    else if ([@"iPhone14,5" isEqualToString:code])
    {
        return @"iPhone 13";
    }
    else if ([@"iPhone14,2" isEqualToString:code])
    {
        return @"iPhone 13 Pro";
    }
    else if ([@"iPhone14,3" isEqualToString:code])
    {
        return @"iPhone 13 Pro Max";
    }
    else if ([@"iPhone14,7" isEqualToString:code])
    {
        return @"iPhone 14";
    }
    else if ([@"iPhone14,8" isEqualToString:code])
    {
        return @"iPhone 14 Plus";
    }
    else if ([@"iPhone15,2" isEqualToString:code])
    {
        return @"iPhone 14 Pro";
    }
    else if ([@"iPhone15,3" isEqualToString:code])
    {
        return @"iPhone 14 Pro Max";
    }
    
    // iPad
    else if ([@"iPad1,1" isEqualToString:code])
    {
        return @"iPad";
    }
    else if ([@"iPad2,1" isEqualToString:code] || [@"iPad2,2" isEqualToString:code]
             || [@"iPad2,3" isEqualToString:code] || [@"iPad2,4" isEqualToString:code])
    {
        return @"iPad 2";
    }
    else if ([@"iPad3,1" isEqualToString:code] || [@"iPad3,2" isEqualToString:code] || [@"iPad3,3" isEqualToString:code])
    {
        return @"iPad 3";
    }
    else if ([@"iPad3,4" isEqualToString:code] || [@"iPad3,5" isEqualToString:code] || [@"iPad3,6" isEqualToString:code])
    {
        return @"iPad 4";
    }
    else if ([@"iPad6,11" isEqualToString:code] || [@"iPad6,12" isEqualToString:code])
    {
        return @"iPad 5";
    }
    else if ([@"iPad7,5" isEqualToString:code] || [@"iPad7,6" isEqualToString:code])
    {
        return @"iPad 6";
    }
    else if ([@"iPad7,11" isEqualToString:code] || [@"iPad7,12" isEqualToString:code])
    {
        return @"iPad 7";
    }
    else if ([@"iPad11,6" isEqualToString:code] || [@"iPad11,7" isEqualToString:code])
    {
        return @"iPad 8";
    }
    else if ([@"iPad12,1" isEqualToString:code] || [@"iPad12,2" isEqualToString:code])
    {
        return @"iPad 9";
    }
    // iPad Air
    else if ([@"iPad4,1" isEqualToString:code] || [@"iPad4,2" isEqualToString:code] || [@"iPad4,3" isEqualToString:code])
    {
        return @"iPad Air";
    }
    else if ([@"iPad5,3" isEqualToString:code] || [@"iPad5,4" isEqualToString:code])
    {
        return @"iPad Air 2";
    }
    else if ([@"iPad11,3" isEqualToString:code] || [@"iPad11,4" isEqualToString:code])
    {
        return @"iPad Air 3";
    }
    else if ([@"iPad13,1" isEqualToString:code] || [@"iPad13,2" isEqualToString:code])
    {
        return @"iPad Air 4";
    }
    else if ([@"iPad13,16" isEqualToString:code] || [@"iPad13,17" isEqualToString:code])
    {
        return @"iPad Air 5";
    }
    // iPad mini
    else if ([@"iPad2,5" isEqualToString:code] || [@"iPad2,6" isEqualToString:code] || [@"iPad2,7" isEqualToString:code])
    {
        return @"iPad mini";
    }
    else if ([@"iPad4,4" isEqualToString:code] || [@"iPad4,5" isEqualToString:code] || [@"iPad4,6" isEqualToString:code])
    {
        return @"iPad mini 2";
    }
    else if ([@"iPad4,7" isEqualToString:code] || [@"iPad4,8" isEqualToString:code] || [@"iPad4,9" isEqualToString:code])
    {
        return @"iPad mini 3";
    }
    else if ([@"iPad5,1" isEqualToString:code] || [@"iPad5,2" isEqualToString:code])
    {
        return @"iPad mini 4";
    }
    else if ([@"iPad11,1" isEqualToString:code] || [@"iPad11,2" isEqualToString:code])
    {
        return @"iPad mini 5";
    }
    else if ([@"iPad14,1" isEqualToString:code] || [@"iPad14,2" isEqualToString:code])
    {
        return @"iPad mini 6";
    }
    // iPad Pro-9.7
    else if ([@"iPad6,3" isEqualToString:code] || [@"iPad6,4" isEqualToString:code])
    {
        return @"iPad Pro (9.7-inch)";
    }
    // iPad Pro 10.5
    else if ([@"iPad7,3" isEqualToString:code] || [@"iPad7,4" isEqualToString:code])
    {
        return @"iPad Pro (10.5-inch)";
    }
    // iPad Pro 11
    else if ([@"iPad8,1" isEqualToString:code] || [@"iPad8,2" isEqualToString:code]
             || [@"iPad8,3" isEqualToString:code] || [@"iPad8,4" isEqualToString:code])
    {
        return @"iPad Pro (11-inch)";
    }
    else if ([@"iPad8,9" isEqualToString:code] || [@"iPad8,10" isEqualToString:code])
    {
        return @"iPad Pro (11-inch) 2";
    }
    else if ([@"iPad13,4" isEqualToString:code] || [@"iPad13,5" isEqualToString:code]
             || [@"iPad13,6" isEqualToString:code] || [@"iPad13,7" isEqualToString:code])
    {
        return @"iPad Pro (11-inch) 3";
    }
    // iPad Pro 12.9
    else if ([@"iPad6,7" isEqualToString:code] || [@"iPad6,8" isEqualToString:code])
    {
        return @"iPad Pro (12.9-inch)";
    }
    else if ([@"iPad7,1" isEqualToString:code] || [@"iPad7,2" isEqualToString:code])
    {
        return @"iPad Pro (12.9-inch) 2";
    }
    else if ([@"iPad8,5" isEqualToString:code] || [@"iPad8,6" isEqualToString:code]
             || [@"iPad8,7" isEqualToString:code] || [@"iPad8,8" isEqualToString:code])
    {
        return @"iPad Pro (12.9-inch) 3";
    }
    else if ([@"iPad8,11" isEqualToString:code] || [@"iPad8,12" isEqualToString:code])
    {
        return @"iPad Pro (12.9-inch) 4";
    }
    else if ([@"iPad13,8" isEqualToString:code] || [@"iPad13,9" isEqualToString:code]
             || [@"iPad13,10" isEqualToString:code] || [@"iPad13,11" isEqualToString:code])
    {
        return @"iPad Pro (12.9-inch) 5";
    }
    return @"Unknow";
}

@end

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
             || SYName_iPhone_8 == nameType
             || SYName_iPhone_SE_2 == nameType
             || SYName_iPhone_SE_3 == nameType)
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
             || SYName_iPhone_8_Plus == nameType)
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
    else if (SYName_iPad_Air_4 == nameType
             || SYName_iPad_Air_5 == nameType)
    {
        screenSize = SYScreen_iPad_10_9;
    }
    else if (SYName_iPad_Pro_11__1 == nameType
             || SYName_iPad_Pro_11__2 == nameType
             || SYName_iPad_Pro_11__3 == nameType)
    {
        screenSize = SYScreen_iPad_11;
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
    if (@available(iOS 13.0, *))
    {
        NSSet<UIScene *> *scenes             = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene           = (UIWindowScene *)[scenes anyObject];
        UIStatusBarManager *statusBarManager = windowScene.statusBarManager;
        CGFloat statusBarHeight              = statusBarManager.statusBarFrame.size.height;
        if( @available(iOS 16.0, *))
        {
            // 在 iPhone 14 Pro 及 Max 取到的状态栏高度是44，实际是56，需要做调整
            BOOL needAdjust = (44 == statusBarHeight);
            if (56 == windowScene.windows.firstObject.safeAreaInsets.top && needAdjust)
            {
                statusBarHeight = 56;
            }
        }
        return statusBarHeight;
    }
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat safeAreaTop     = UIApplication.sharedApplication.windows.firstObject.safeAreaInsets.top;
    return MAX(statusBarHeight, safeAreaTop);
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

#pragma mark -- 获取’顶部‘安全区高度
+ (CGFloat)syTopSafeAreaHeight
{
    CGFloat top = 0;
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (false == window.isKeyWindow)
    {
        UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
        if (nil != keyWindow && CGRectEqualToRect(keyWindow.bounds, UIScreen.mainScreen.bounds))
        {
            window = keyWindow;
        }
    }
    if (@available(iOS 11.0, *))
    {
        top = window.safeAreaInsets.top;
    }
    return top;
}

#pragma mark -- 获取底部安全区域高度
+ (CGFloat)syBottomSafeAreaHeight
{
    CGFloat bottom = 0;
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    if (false == window.isKeyWindow)
    {
        UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
        if (nil != keyWindow && CGRectEqualToRect(keyWindow.bounds, UIScreen.mainScreen.bounds))
        {
            window = keyWindow;
        }
    }
    if (@available(iOS 11.0, *))
    {
        bottom = window.safeAreaInsets.bottom;
    }
    return bottom;
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
                           @"hk" : @(Language_Hongkong),
                           @"en" : @(Language_English),
                           @"ja" : @(Language_Japanese),
                           @"ko" : @(Language_Korean),
                           @"de" : @(Language_German),
                           @"fr" : @(Language_French),
                           @"it" : @(Language_Italy),
                           @"es" : @(Language_Spanish),
                           };
    }
    NSString *localeLanguageCode = [language substringToIndex:2];
    
    NSLog(@"localeLanguageCode = %@", localeLanguageCode);
    
    return [languageByCode[localeLanguageCode] integerValue];
}

#pragma mark -- 获取型号名
+ (NSString *)syModelName
{
    SYNameType nameType = [self syDeviceName];
    NSString *name      = @"DeviceNameUnknow";
    switch (nameType)
    {
        case SYName_Simulator: name = @"Simulator"; break;
        // iPod
        case SYName_iPod:    name = @"iPod";   break;
        case SYName_iPod__2: name = @"iPod 2"; break;
        case SYName_iPod__3: name = @"iPod 3"; break;
        case SYName_iPod__4: name = @"iPod 4"; break;
        case SYName_iPod__5: name = @"iPod 5"; break;
        case SYName_iPod__6: name = @"iPod 6"; break;
        case SYName_iPod__7: name = @"iPod 7"; break;
        // iPhone
        case SYName_iPhone:            name = @"iPhone";            break;
        case SYName_iPhone_3G:         name = @"iPhone 3G";         break;
        case SYName_iPhone_3GS:        name = @"iPhone 3GS";        break;
        case SYName_iPhone_4:          name = @"iPhone 4";          break;
        case SYName_iPhone_4S:         name = @"iPhone 4S";         break;
        case SYName_iPhone_5:          name = @"iPhone 5";          break;
        case SYName_iPhone_5C:         name = @"iPhone 5C";         break;
        case SYName_iPhone_5S:         name = @"iPhone 5S";         break;
        case SYName_iPhone_6:          name = @"iPhone 6";          break;
        case SYName_iPhone_6_Plus:     name = @"iPhone 6 Plus";     break;
        case SYName_iPhone_6S:         name = @"iPhone 6S";         break;
        case SYName_iPhone_6S_Plus:    name = @"iPhone 6S Plus";    break;
        case SYName_iPhone_SE:         name = @"iPhone SE";         break;
        case SYName_iPhone_7:          name = @"iPhone 7";          break;
        case SYName_iPhone_7_Plus:     name = @"iPhone 7 Plus";     break;
        case SYName_iPhone_8:          name = @"iPhone 8";          break;
        case SYName_iPhone_8_Plus:     name = @"iPhone 8 Plus";     break;
        case SYName_iPhone_X:          name = @"iPhone X";          break;
        case SYName_iPhone_XS:         name = @"iPhone XS";         break;
        case SYName_iPhone_XS_Max:     name = @"iPhone XS Max";     break;
        case SYName_iPhone_XR:         name = @"iPhone XR";         break;
        case SYName_iPhone_11:         name = @"iPhone 11";         break;
        case SYName_iPhone_11_Pro:     name = @"iPhone 11 Pro";     break;
        case SYName_iPhone_11_Pro_Max: name = @"iPhone 11 Pro Max"; break;
        case SYName_iPhone_SE_2:       name = @"iPhone SE 2";       break;
        case SYName_iPhone_12_mini:    name = @"iPhone 12 Mini";    break;
        case SYName_iPhone_12:         name = @"iPhone 12";         break;
        case SYName_iPhone_12_Pro:     name = @"iPhone 12 Pro";     break;
        case SYName_iPhone_12_Pro_Max: name = @"iPhone 12 Pro Max"; break;
        case SYName_iPhone_13_mini:    name = @"iPhone 13 Mini";    break;
        case SYName_iPhone_13:         name = @"iPhone 13";         break;
        case SYName_iPhone_13_Pro:     name = @"iPhone 13 Pro";     break;
        case SYName_iPhone_13_Pro_Max: name = @"iPhone 13 Pro Max"; break;
        case SYName_iPhone_SE_3:       name = @"iPhone SE 3";       break;
        case SYName_iPhone_14:         name = @"iPhone 14";         break;
        case SYName_iPhone_14_Plus:    name = @"iPhone 14 Plus";    break;
        case SYName_iPhone_14_Pro:     name = @"iPhone 14 Pro";     break;
        case SYName_iPhone_14_Pro_Max: name = @"iPhone 14 Pro Max"; break;
        // iPad
        case SYName_iPad:   name = @"iPad 1"; break;
        case SYName_iPad_2: name = @"iPad 2"; break;
        case SYName_iPad_3: name = @"iPad 3"; break;
        case SYName_iPad_4: name = @"iPad 4"; break;
        case SYName_iPad_5: name = @"iPad 5"; break;
        case SYName_iPad_6: name = @"iPad 6"; break;
        case SYName_iPad_7: name = @"iPad 7"; break;
        case SYName_iPad_8: name = @"iPad 8"; break;
        case SYName_iPad_9: name = @"iPad 9"; break;
        // iPad Air
        case SYName_iPad_Air:   name = @"iPad Air 1"; break;
        case SYName_iPad_Air_2: name = @"iPad Air 2"; break;
        case SYName_iPad_Air_3: name = @"iPad Air 3"; break;
        case SYName_iPad_Air_4: name = @"iPad Air 4"; break;
        case SYName_iPad_Air_5: name = @"iPad Air 5"; break;
        // iPad Mini
        case SYName_iPad_Mini:   name = @"iPad Mini 1"; break;
        case SYName_iPad_Mini_2: name = @"iPad Mini 2"; break;
        case SYName_iPad_Mini_3: name = @"iPad Mini 3"; break;
        case SYName_iPad_Mini_4: name = @"iPad Mini 4"; break;
        case SYName_iPad_Mini_5: name = @"iPad Mini 5"; break;
        case SYName_iPad_Mini_6: name = @"iPad Mini 5"; break;
        // iPad Pro
        case SYName_iPad_Pro_9_7:     name = @"iPad Pro (9.7-inch)";    break;
        case SYName_iPad_Pro_10_5:    name = @"iPad Pro (10.5-inch)";   break;
        case SYName_iPad_Pro_11__1:   name = @"iPad Pro (11-inch) 1";   break;
        case SYName_iPad_Pro_11__2:   name = @"iPad Pro (11-inch) 2";   break;
        case SYName_iPad_Pro_11__3:   name = @"iPad Pro (11-inch) 3";   break;
        case SYName_iPad_Pro_12_9:    name = @"iPad Pro (12.9-inch) 1"; break;
        case SYName_iPad_Pro_12_9__2: name = @"iPad Pro (12.9-inch) 2"; break;
        case SYName_iPad_Pro_12_9__3: name = @"iPad Pro (12.9-inch) 3"; break;
        case SYName_iPad_Pro_12_9__4: name = @"iPad Pro (12.9-inch) 4"; break;
        case SYName_iPad_Pro_12_9__5: name = @"iPad Pro (12.9-inch) 5"; break;
            
        default: break;
    }
    return name;
}

@end

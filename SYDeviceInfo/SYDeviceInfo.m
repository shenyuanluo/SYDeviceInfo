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
                              @"i386"       : [NSNumber numberWithUnsignedInteger:SYName_Simulator],
                              @"x86_64"     : [NSNumber numberWithUnsignedInteger:SYName_Simulator],
                              
                              // iPod
                              @"iPod1,1"    : [NSNumber numberWithUnsignedInteger:SYName_iPod],
                              @"iPod2,1"    : [NSNumber numberWithUnsignedInteger:SYName_iPod__2],
                              @"iPod3,1"    : [NSNumber numberWithUnsignedInteger:SYName_iPod__3],
                              @"iPod4,1"    : [NSNumber numberWithUnsignedInteger:SYName_iPod__4],
                              @"iPod5,1"    : [NSNumber numberWithUnsignedInteger:SYName_iPod__5],
                              @"iPod7,1"    : [NSNumber numberWithUnsignedInteger:SYName_iPod__6],
                              
                              // iPhone
                              @"iPhone1,1"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone],
                              @"iPhone1,2"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_3G],
                              @"iPhone2,1"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_3GS],
                              
                              @"iPhone3,1"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_4],
                              @"iPhone3,2"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_4],
                              @"iPhone3,3"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_4],
                              @"iPhone4,1"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_4S],
                              
                              @"iPhone5,1"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_5],
                              @"iPhone5,2"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_5],
                              @"iPhone5,3"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_5C],
                              @"iPhone5,4"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_5C],
                              @"iPhone6,1"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_5S],
                              @"iPhone6,2"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_5S],
                              
                              @"iPhone7,2"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_6],
                              @"iPhone7,1"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_6_Plus],
                              @"iPhone8,1"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_6S],
                              @"iPhone8,2"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_6S_Plus],
                              
                              @"iPhone8,4"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_SE],
                              
                              @"iPhone9,1"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_7],
                              @"iPhone9,3"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_7],
                              @"iphone9,2"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_7_Plus],
                              @"iphone9,4"  : [NSNumber numberWithUnsignedInteger:SYName_iPhone_7_Plus],
                              
                              @"iPhone10,1" : [NSNumber numberWithUnsignedInteger:SYName_iPhone_8],
                              @"iPhone10,4" : [NSNumber numberWithUnsignedInteger:SYName_iPhone_8],
                              @"iPhone10,2" : [NSNumber numberWithUnsignedInteger:SYName_iPhone_8_Plus],
                              @"iPhone10,5" : [NSNumber numberWithUnsignedInteger:SYName_iPhone_8_Plus],
                              
                              @"iPhone10,3" : [NSNumber numberWithUnsignedInteger:SYName_iPhone_X],
                              @"iPhone10,6" : [NSNumber numberWithUnsignedInteger:SYName_iPhone_X],
                              
                              // iPad
                              @"iPad1,1"    : [NSNumber numberWithUnsignedInteger:SYName_iPad],
                              @"iPad2,1"    : [NSNumber numberWithUnsignedInteger:SYName_iPad__2],
                              @"iPad2,2"    : [NSNumber numberWithUnsignedInteger:SYName_iPad__2],
                              @"iPad2,3"    : [NSNumber numberWithUnsignedInteger:SYName_iPad__2],
                              @"iPad2,4"    : [NSNumber numberWithUnsignedInteger:SYName_iPad__2],
                              
                              @"iPad3,1"    : [NSNumber numberWithUnsignedInteger:SYName_iPad__3],
                              @"iPad3,2"    : [NSNumber numberWithUnsignedInteger:SYName_iPad__3],
                              @"iPad3,3"    : [NSNumber numberWithUnsignedInteger:SYName_iPad__3],
                              
                              @"iPad3,4"    : [NSNumber numberWithUnsignedInteger:SYName_iPad__4],
                              @"iPad3,5"    : [NSNumber numberWithUnsignedInteger:SYName_iPad__4],
                              @"iPad3,6"    : [NSNumber numberWithUnsignedInteger:SYName_iPad__4],
                              
                              @"iPad6,11"   : [NSNumber numberWithUnsignedInteger:SYName_iPad__5],
                              @"iPad6,12"   : [NSNumber numberWithUnsignedInteger:SYName_iPad__5],
                              
                              // iPad Air
                              @"iPad4,1"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Air],
                              @"iPad4,2"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Air],
                              @"iPad4,3"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Air],
                              @"iPad5,3"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Air__2],
                              @"iPad5,4"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Air__2],
                              
                              // iPad mini
                              @"iPad2,5"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Mini],
                              @"iPad2,6"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Mini],
                              @"iPad2,7"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Mini],
                              
                              @"iPad4,4"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Mini__2],
                              @"iPad4,5"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Mini__2],
                              @"iPad4,6"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Mini__2],
                              
                              @"iPad4,7"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Mini__3],
                              @"iPad4,8"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Mini__3],
                              @"iPad4,9"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Mini__3],
                              
                              @"iPad5,1"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Mini__4],
                              @"iPad5,2"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Mini__4],
                              
                              // iPad Pro
                              @"iPad6,3"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Pro_9_7],
                              @"iPad6,4"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Pro_9_7],
                              
                              @"iPad7,3"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Pro_10_5],
                              @"iPad7,4"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Pro_10_5],
                              
                              @"iPad6,7"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Pro_12_9],
                              @"iPad6,8"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Pro_12_9],
                              
                              @"iPad7,1"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Pro_12_9__2],
                              @"iPad7,2"    : [NSNumber numberWithUnsignedInteger:SYName_iPad_Pro_12_9__2],
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
             || SYName_iPod__6 == nameType)
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
             || SYName_iPhone_X == nameType)
    {
        deviceType = SYType_iPhone;
    }
    else if (SYName_iPad == nameType
             || SYName_iPad__2 == nameType
             || SYName_iPad__3 == nameType
             || SYName_iPad__4 == nameType
             || SYName_iPad__5 == nameType
             || SYName_iPad_Air == nameType
             || SYName_iPad_Air__2 == nameType
             || SYName_iPad_Mini == nameType
             || SYName_iPad_Mini__2 == nameType
             || SYName_iPad_Mini__3 == nameType
             || SYName_iPad_Mini__4 == nameType
             || SYName_iPad_Pro_9_7 == nameType
             || SYName_iPad_Pro_10_5 == nameType
             || SYName_iPad_Pro_12_9 == nameType
             || SYName_iPad_Pro_12_9__2 == nameType)
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
        || SYName_iPad__2 == nameType
        || SYName_iPad__3 == nameType
        || SYName_iPad__4 == nameType)
    {
        screenSize = SYScreen_iPod_3_5;
    }
    else if (SYName_iPod__5 == nameType
             || SYName_iPod__6 == nameType)
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
    else if (SYName_iPhone_6_Plus == nameType
             || SYName_iPhone_6S_Plus == nameType
             || SYName_iPhone_7_Plus == nameType
             || SYName_iPhone_8_Plus == nameType)
    {
        screenSize = SYScreen_iPhone_5_5;
    }
    else if (SYName_iPhone_X == nameType)
    {
        screenSize = SYScreen_iPhone_5_8;
    }
    else if (SYName_iPad_Mini == nameType
             || SYName_iPad_Mini__2 == nameType
             || SYName_iPad_Mini__3 == nameType
             || SYName_iPad_Mini__4 == nameType)
    {
        screenSize = SYScreen_iPad_7_9;
    }
    else if (SYName_iPad == nameType
             || SYName_iPad__2 == nameType
             || SYName_iPad__3 == nameType
             || SYName_iPad__4 == nameType
             || SYName_iPad__5 == nameType
             || SYName_iPad_Air == nameType
             || SYName_iPad_Air__2 == nameType
             || SYName_iPad_Pro_9_7 == nameType)
    {
        screenSize = SYScreen_iPad_9_7;
    }
    else if (SYName_iPad_Pro_10_5 == nameType)
    {
        screenSize = SYScreen_iPad_10_5;
    }
    else if (SYName_iPad_Pro_12_9 == nameType
             || SYName_iPad_Pro_12_9__2 == nameType)
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
    NSArray *languageArray = [NSLocale preferredLanguages];
    return [languageArray objectAtIndex:0];
}


@end

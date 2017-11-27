//
//  ViewController.m
//  SYDeviceInfoExample
//
//  Created by shenyuanluo on 2017/9/26.
//  Copyright © 2017年 http://blog.shenyuanluo.com/ All rights reserved.
//

#import "ViewController.h"
#import "DevInfoTableViewCell.h"

#define KB_SIZE 1024

#define MB_SIZE 1048576     // 1024 * 1024

#define GB_SIZE 1073741842  // 1024 * 1024 * 1024


@interface ViewController () <
                                UITableViewDelegate,
                                UITableViewDataSource
                             >

@property (weak, nonatomic) IBOutlet UITableView *devInfoTableView;

@property (nonatomic, strong) NSMutableArray <DevInfoModel *>*devInfoArray;
@property (nonatomic, strong) NSMutableArray <NSString *>*keysArray;
@property (nonatomic, strong) NSMutableArray <NSString *>*valuesArray;


@property (nonatomic, copy) NSString *devName;
@property (nonatomic, copy) NSString *devUUID;
@property (nonatomic, copy) NSString *devType;
@property (nonatomic, copy) NSString *devInch;
@property (nonatomic, copy) NSString *devNickName;
@property (nonatomic, copy) NSString *devWidth;
@property (nonatomic, copy) NSString *devWHeight;
@property (nonatomic, copy) NSString *devBatteryLevel;
@property (nonatomic, copy) NSString *devBatteryState;
@property (nonatomic, copy) NSString *devSysName;
@property (nonatomic, copy) NSString *devSysVersion;
@property (nonatomic, copy) NSString *devIp;
@property (nonatomic, copy) NSString *devMac;
@property (nonatomic, copy) NSString *devTotalMemory;
@property (nonatomic, copy) NSString *devFreeMemory;
@property (nonatomic, copy) NSString *devTotalSpace;
@property (nonatomic, copy) NSString *devFreeSpace;
@property (nonatomic, copy) NSString *devLanguage;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configTableView];
    
    [self obtainDeviceInfo];
    
    [self.devInfoTableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)configTableView
{
    self.devInfoTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.devInfoTableView.rowHeight = 44.0f;
    self.devInfoTableView.showsVerticalScrollIndicator = NO;
}


- (void)obtainDeviceInfo
{
    for (int i = 0; i < self.keysArray.count; i++)
    {
        DevInfoModel *infoModel = [[DevInfoModel alloc] init];
        infoModel.keyStr   = self.keysArray[i];
        infoModel.valueStr = self.valuesArray[i];
        [self.devInfoArray addObject:infoModel];
    }
}


#pragma mark - 懒加载
- (NSMutableArray<DevInfoModel *> *)devInfoArray
{
    if (!_devInfoArray)
    {
        _devInfoArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _devInfoArray;
}


- (NSMutableArray<NSString *> *)keysArray
{
    if (!_keysArray)
    {
        NSArray *keyArray = @[@"名称",
                              @"昵称",
                              @"UUID",
                              @"类型",
                              @"大小",
                              @"宽度",
                              @"高度",
                              @"电池电量",
                              @"电池状态",
                              @"系统名称",
                              @"系统版本",
                              @"IP 地址",
                              @"MAC 地址",
                              @"总内存",
                              @"可用内存",
                              @"总存储空间",
                              @"可用存储空间",
                              @"语言"];
        _keysArray = [NSMutableArray arrayWithArray:keyArray];
    }
    return _keysArray;
}


- (NSMutableArray<NSString *> *)valuesArray
{
    if (!_valuesArray)
    {
        NSArray *valueArr = @[self.devName,
                              self.devNickName,
                              self.devUUID,
                              self.devType,
                              self.devInch,
                              self.devWidth,
                              self.devWHeight,
                              self.devBatteryLevel,
                              self.devBatteryState,
                              self.devSysName,
                              self.devSysVersion,
                              self.devIp,
                              self.devMac,
                              self.devTotalMemory,
                              self.devFreeMemory,
                              self.devTotalSpace,
                              self.devFreeSpace,
                              self.devLanguage];
        _valuesArray = [NSMutableArray arrayWithArray:valueArr];
    }
    return _valuesArray;
}


- (NSString *)devName
{
    if (!_devName)
    {
        SYNameType nameType = [SYDeviceInfo syDeviceName];
        _devName = [self deviceNameWithType:nameType];
    }
    return _devName;
}


- (NSString *)devUUID
{
    if (!_devUUID)
    {
        _devUUID = [SYDeviceInfo syUUID];
    }
    return _devUUID;
}


- (NSString *)devType
{
    if (!_devType)
    {
        SYDeviceType deviceType = [SYDeviceInfo syDeviceType];
        _devType = [self deviceType:deviceType];
    }
    return _devType;
}


- (NSString *)devInch
{
    if (!_devInch)
    {
        SYScreenType screenType = [SYDeviceInfo syScreenType];
        _devInch = [self deviceInchWithType:screenType];
    }
    return _devInch;
}


- (NSString *)devNickName
{
    if (!_devNickName)
    {
        _devNickName = [SYDeviceInfo syNickName];
    }
    return _devNickName;
}


- (NSString *)devWidth
{
    if (!_devWidth)
    {
        _devWidth = [NSString stringWithFormat:@"%d", (int)[SYDeviceInfo syDeviceWidth]];
    }
    return _devWidth;
}


- (NSString *)devWHeight
{
    if (!_devWHeight)
    {
        _devWHeight = [NSString stringWithFormat:@"%d", (int)[SYDeviceInfo syDeviceHeight]];
    }
    return _devWHeight;
}


- (NSString *)devBatteryLevel
{
    if (!_devBatteryLevel)
    {
        CGFloat batteryLevel = [SYDeviceInfo syBatteryLevel];
        if (0 > batteryLevel)
        {
            _devBatteryLevel = @"未知";
        }
        else
        {
            _devBatteryLevel = [NSString stringWithFormat:@"%d%@", (int)((float)[SYDeviceInfo syBatteryLevel] * 100), @"\%"];
        }
    }
    return _devBatteryLevel;
}


- (NSString *)devBatteryState
{
    if (!_devBatteryState)
    {
        SYBatteryState state = [SYDeviceInfo syBatteryState];
        switch (state)
        {
            case SYBattery_Unknow:
                _devBatteryState = @"未知";
                break;
                
            case SYBattery_Unplugged:
                _devBatteryState = @"未充电";
                break;
                
            case SYBattery_Charging:
                _devBatteryState = @"正在充电，未充满";
                break;
                
            case SYBattery_Full:
                _devBatteryState = @"正在充电，且已充满";
                break;
                
            default:
                _devBatteryState = @"未知";
                break;
        }
    }
    return _devBatteryState;
}


- (NSString *)devSysName
{
    if (!_devSysName)
    {
        _devSysName = [SYDeviceInfo sySystemName];
    }
    return _devSysName;
}


- (NSString *)devSysVersion
{
    if (!_devSysVersion)
    {
        _devSysVersion = [SYDeviceInfo sySystemVersion];
    }
    return _devSysVersion;
}


- (NSString *)devIp
{
    if (!_devIp)
    {
        _devIp = [SYDeviceInfo syDeviceIp];
    }
    return _devIp;
}


- (NSString *)devMac
{
    if (!_devMac)
    {
        _devMac = [SYDeviceInfo syDeviceMac];
    }
    return _devMac;
}


- (NSString *)devTotalMemory
{
    if (!_devTotalMemory)
    {
        _devTotalMemory = [self formatSize:[SYDeviceInfo syTotalMemory]];
    }
    return _devTotalMemory;
}


- (NSString *)devFreeMemory
{
    if (!_devFreeMemory)
    {
        
        _devFreeMemory = [self formatSize:[SYDeviceInfo syFreeMemory]];
    }
    return _devFreeMemory;
}


- (NSString *)devTotalSpace
{
    if (!_devTotalSpace)
    {
        _devTotalSpace = [self formatSize:[SYDeviceInfo syTotalSpace]];
    }
    return _devTotalSpace;
}


- (NSString *)devFreeSpace
{
    if (!_devFreeSpace)
    {
        
        _devFreeSpace = [self formatSize:[SYDeviceInfo syFreeSpace]];
    }
    return _devFreeSpace;
}


- (NSString *)devLanguage
{
    if (!_devLanguage)
    {
        _devLanguage = [SYDeviceInfo syLanguage];
    }
    return _devLanguage;
}


#pragma mark - 设备信息处理
#pragma mark -- 获取当前设备的'名称'
- (NSString *)deviceNameWithType:(SYNameType)nameType
{
    NSString *devNameStr = @"Unknow";
    switch (nameType)
    {
        case SYName_Unknow:
            devNameStr = @"Unknow";
            break;
            
        case SYName_Simulator:
            devNameStr = @"Simulator";
            break;
            
        case SYName_iPod:
            devNameStr = @"iPod";
            break;
            
        case SYName_iPod__2:
            devNameStr = @"iPod 2";
            break;
            
        case SYName_iPod__3:
            devNameStr = @"iPod 3";
            break;
            
        case SYName_iPod__4:
            devNameStr = @"iPod 4";
            break;
            
        case SYName_iPod__5:
            devNameStr = @"iPod 5";
            break;
            
        case SYName_iPod__6:
            devNameStr = @"iPod 6";
            break;
            
        case SYName_iPhone:
            devNameStr = @"iPhone";
            break;
            
        case SYName_iPhone_3G:
            devNameStr = @"iPhone 3G";
            break;
            
        case SYName_iPhone_3GS:
            devNameStr = @"iPhone 3GS";
            break;
            
        case SYName_iPhone_4:
            devNameStr = @"iPhone 4";
            break;
            
        case SYName_iPhone_4S:
            devNameStr = @"iPhone 4S";
            break;
            
        case SYName_iPhone_5:
            devNameStr = @"iPhone 5";
            break;
            
        case SYName_iPhone_5C:
            devNameStr = @"iPhone 5c";
            break;
            
        case SYName_iPhone_5S:
            devNameStr = @"iPhone 5S";
            break;
            
        case SYName_iPhone_6:
            devNameStr = @"iPhone 6";
            break;
            
        case SYName_iPhone_6_Plus:
            devNameStr = @"iPhone 6 Plus";
            break;
            
        case SYName_iPhone_6S:
            devNameStr = @"iPhone 6S";
            break;
            
        case SYName_iPhone_6S_Plus:
            devNameStr = @"iPhone 6S Plus";
            break;
            
        case SYName_iPhone_SE:
            devNameStr = @"iPhone SE";
            break;
            
        case SYName_iPhone_7:
            devNameStr = @"iPhone 7";
            break;
            
        case SYName_iPhone_7_Plus:
            devNameStr = @"iPhone 7 Plus";
            break;
            
        case SYName_iPhone_8:
            devNameStr = @"iPhone 8";
            break;
            
        case SYName_iPhone_8_Plus:
            devNameStr = @"iPhone 8 Plus";
            break;
            
        case SYName_iPhone_X:
            devNameStr = @"iPhone X";
            break;
            
        case SYName_iPad:
            devNameStr = @"iPad";
            break;
            
        case SYName_iPad__2:
            devNameStr = @"iPad 2";
            break;
            
        case SYName_iPad__3:
            devNameStr = @"iPad 3";
            break;
            
        case SYName_iPad__4:
            devNameStr = @"iPad 4";
            break;
            
        case SYName_iPad__5:
            devNameStr = @"iPad 5";
            break;
            
        case SYName_iPad_Air:
            devNameStr = @"Air";
            break;
            
        case SYName_iPad_Air__2:
            devNameStr = @"iPad Air 2";
            break;
            
        case SYName_iPad_Mini:
            devNameStr = @"iPad Mini";
            break;
            
        case SYName_iPad_Mini__2:
            devNameStr = @"iPad Mini 2";
            break;
            
        case SYName_iPad_Mini__3:
            devNameStr = @"iPad Mini 3";
            break;
            
        case SYName_iPad_Mini__4:
            devNameStr = @"iPad Mini 4";
            break;
            
        case SYName_iPad_Pro_9_7:
            devNameStr = @"iPad Pro(9.7-inch)";
            break;
            
        case SYName_iPad_Pro_10_5:
            devNameStr = @"iPad Pro(10.5-inch)";
            break;
            
        case SYName_iPad_Pro_12_9:
            devNameStr = @"iPad Pro(12.9-inch)";
            break;
            
        case SYName_iPad_Pro_12_9__2:
            devNameStr = @"iPad Pro(12.9-inch, 2nd generation)";
            break;
            
        default:
            devNameStr = @"Unknow";
            break;
    }
    
    return devNameStr;
}


#pragma mark -- 获取当前设备的‘类型’
- (NSString *)deviceType:(SYDeviceType)deviceType
{
    NSString *deviceTypeStr = @"Unknow";
    switch (deviceType)
    {
        case SYType_Unknow:
            deviceTypeStr = @"Unknow";
            break;
            
        case SYType_Simulator:
            deviceTypeStr = @"Simulator";
            break;
            
        case SYType_iPod:
            deviceTypeStr = @"iPod";
            break;
            
        case SYType_iPhone:
            deviceTypeStr = @"iPhone";
            break;
            
        case SYType_iPad:
            deviceTypeStr = @"iPad";
            break;
            
        default:
            deviceTypeStr = @"Unknow";
            break;
    }
    
    return deviceTypeStr;
}


#pragma mark -- 获取当前设备屏幕的‘大小’
- (NSString *)deviceInchWithType:(SYScreenType)screenType
{
    NSString *screenTypeStr = @"Unknow";
    switch (screenType)
    {
        case SYScreen_Unknow:
            screenTypeStr = @"Unknow";
            break;
            
        case SYScreen_iPod_3_5:
            screenTypeStr = @"iPod 3.5-inch";
            break;
            
        case SYScreen_iPod_4_0:
            screenTypeStr = @"iPod 4.0-inch";
            break;
            
        case SYScreen_iPhone_3_5:
            screenTypeStr = @"iPhone 3.5-inch";
            break;
            
        case SYScreen_iPhone_4_0:
            screenTypeStr = @"iPhone 4.0-inch";
            break;
            
        case SYScreen_iPhone_4_7:
            screenTypeStr = @"iPhone 4.7-inch";
            break;
            
        case SYScreen_iPhone_5_5:
            screenTypeStr = @"iPhone 5.5-inch";
            break;
            
        case SYScreen_iPhone_5_8:
            screenTypeStr = @"iPhone 5.8-inch";
            break;
            
        case SYScreen_iPad_7_9:
            screenTypeStr = @"iPad 7.9-inch";
            break;
            
        case SYScreen_iPad_10_5:
            screenTypeStr = @"iPad 10.5-inch";
            break;
            
        case SYScreen_iPad_12_9:
            screenTypeStr = @"iPad 12.9-inch";
            break;
            
        default:
            screenTypeStr = @"Unknow";
            break;
    }
    
    return screenTypeStr;
}


- (NSString *)formatSize:(unsigned long long)size
{
    NSString *sizeStr = nil;
    if (KB_SIZE > size)
    {
        sizeStr = [NSString stringWithFormat:@"%llu B", size];
    }
    else if (KB_SIZE < size && MB_SIZE > size)
    {
        float countKB = size / 1024.0f;
        sizeStr = [NSString stringWithFormat:@"%.02f KB", countKB];
    }
    else if (MB_SIZE < size && GB_SIZE > size)
    {
        float countMB = size / (1024.0f * 1024.0f);
        sizeStr = [NSString stringWithFormat:@"%.02f MB", countMB];
    }
    else if (GB_SIZE < size)
    {
        float countGB = size / (1024.0f * 1024.0f * 1024.0f);
        sizeStr = [NSString stringWithFormat:@"%.02f GB", countGB];
    }
    else
    {
        sizeStr = @"未知";
    }
    return sizeStr;
}


#pragma mark - TableVeiw Delegate && DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.devInfoArray)
    {
        return self.devInfoArray.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *devInfoCellId = @"DevInfoTableViewCellId";
    NSInteger rowIndex = indexPath.row;
    DevInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:devInfoCellId];
    if (!cell)
    {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"DevInfoTableViewCell"
                                                          owner:self
                                                        options:nil];
        cell = nibArray[0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (rowIndex < self.devInfoArray.count)
    {
        cell.devInfoData = [self.devInfoArray objectAtIndex:rowIndex];
    }
    
    return cell;
}

@end

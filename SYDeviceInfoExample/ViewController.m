//
//  ViewController.m
//  SYDeviceInfoExample
//
//  Created by shenyuanluo on 2017/9/26.
//  Copyright © 2017年 http://blog.shenyuanluo.com/ All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Current device name : 0x%04x", (unsigned int)g_currentDevName);
    NSLog(@"Current device type :0x%02x", (unsigned int)g_currentDevType);
    NSLog(@"Current device screen : 0x%02x", (unsigned int)g_currentScreenType);
    
    self.nameLabel.text = [NSString stringWithFormat:@"当前设备名称 : 0x%04x", (unsigned int)g_currentDevName];
    self.typeLabel.text = [NSString stringWithFormat:@"当前设备类型 : 0x%02x", (unsigned int)g_currentDevType];
    self.sizeLabel.text = [NSString stringWithFormat:@"当前设备大小 : 0x%02x", (unsigned int)g_currentScreenType];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

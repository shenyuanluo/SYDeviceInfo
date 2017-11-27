//
//  DevInfoTableViewCell.m
//  SYDeviceInfoExample
//
//  Created by shenyuanluo on 2017/11/27.
//  Copyright © 2017年 http://blog.shenyuanluo.com/ All rights reserved.
//

#import "DevInfoTableViewCell.h"


@interface DevInfoTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *keyLabel;

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;


@end

@implementation DevInfoTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


- (void)setDevInfoData:(DevInfoModel *)devInfoData
{
    if (!devInfoData)
    {
        return;
    }
    self.keyLabel.text   = devInfoData.keyStr;
    self.valueLabel.text = devInfoData.valueStr;
}

@end

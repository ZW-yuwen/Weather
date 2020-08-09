//
//  ManageTableViewCell.m
//  天气预报
//
//  Created by 仲雯 on 2020/8/4.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import "ManageTableViewCell.h"

@implementation ManageTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, 50, 260, 80)];
    [self.contentView addSubview:_cityLabel];
    
    _sunLabel = [[UILabel alloc]initWithFrame:CGRectMake(198, 120, 60, 20)];
    [self.contentView addSubview:_sunLabel];
    
    _tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(175, 160, 200, 80)];
    [self.contentView addSubview:_tempLabel];

    _dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 300, 80, 40)];
    [self.contentView addSubview:_dayLabel];

    _highTempLabel = [[UILabel alloc]initWithFrame:CGRectMake(330, 300, 80, 40)];
    [self.contentView addSubview:_highTempLabel];

    _lowTempLabel = [[UILabel alloc]initWithFrame:CGRectMake(370, 300, 80, 40)];
    [self.contentView addSubview:_lowTempLabel];
    
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 300, 80, 40)];
    [self.contentView addSubview:_dateLabel];
    
    return self;
}
-(void)layoutSubviews{
    _cityLabel.font = [UIFont systemFontOfSize:30];
    _cityLabel.textColor = [UIColor whiteColor];
    
    _sunLabel.font = [UIFont systemFontOfSize:20];
    _sunLabel.textColor = [UIColor whiteColor];
    
    _tempLabel.font = [UIFont systemFontOfSize:60];
    _tempLabel.textColor = [UIColor whiteColor];
    
    _dayLabel.font = [UIFont systemFontOfSize:20];
    _dayLabel.textColor = [UIColor whiteColor];
    
    _highTempLabel.font = [UIFont systemFontOfSize:20];
    _highTempLabel.textColor = [UIColor whiteColor];
    
    _lowTempLabel.font = [UIFont systemFontOfSize:20];
    _lowTempLabel.textColor = [UIColor whiteColor];
    
    _dateLabel.font = [UIFont systemFontOfSize:16];
    _dateLabel.textColor = [UIColor whiteColor];
    
}
@end

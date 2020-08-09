//
//  AllTableViewCell.m
//  天气预报
//
//  Created by 仲雯 on 2020/8/5.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import "AllTableViewCell.h"

@implementation AllTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, 400, 60)];
    [self.contentView addSubview:_cityLabel];
    
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 15, 200, 20)];
    [self.contentView addSubview:_timeLabel];
    
    _tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(310, 10, 100, 90)];
    [self.contentView addSubview:_tempLabel];
    
    return self;
}
-(void)layoutSubviews{
    _cityLabel.font = [UIFont systemFontOfSize:40];
    _cityLabel.textColor = [UIColor whiteColor];
    
    _tempLabel.textColor = [UIColor whiteColor];
    _tempLabel.font = [UIFont systemFontOfSize:40];
    
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.font = [UIFont systemFontOfSize:15];
}

@end

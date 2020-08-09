//
//  SevenDaysTableViewCell.m
//  天气预报
//
//  Created by 仲雯 on 2020/8/8.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import "SevenDaysTableViewCell.h"

@implementation SevenDaysTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    _weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 90, 20)];
    [self.contentView addSubview:_weekLabel];
    
    _highTemLabel = [[UILabel alloc]initWithFrame:CGRectMake(300, 15, 90, 20)];
    [self.contentView addSubview:_highTemLabel];
    
    _lowTemLabel = [[UILabel alloc]initWithFrame:CGRectMake(355, 15, 90, 20)];
    [self.contentView addSubview:_lowTemLabel];
    
    _icon = [[UIImageView alloc]initWithFrame:CGRectMake(170, 8, 40, 40)];
    [self.contentView addSubview:_icon];
    
    return self;
}
-(void)layoutSubviews{

    _weekLabel.font = [UIFont systemFontOfSize:18];
    _weekLabel.textColor = [UIColor whiteColor];
    
    _highTemLabel.font = [UIFont systemFontOfSize:18];
    _highTemLabel.textColor = [UIColor whiteColor];
    
    _lowTemLabel.font = [UIFont systemFontOfSize:18];
    _lowTemLabel.textColor = [UIColor whiteColor];
}
@end

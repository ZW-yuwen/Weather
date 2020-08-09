//
//  DataTableViewCell.m
//  天气预报
//
//  Created by 仲雯 on 2020/8/8.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import "DataTableViewCell.h"

@implementation DataTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _upFirstLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 90, 20)];
    [self.contentView addSubview:_upFirstLabel];
    
    _upSecondLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 10, 90, 20)];
    [self.contentView addSubview:_upSecondLabel];
    
    _downFirstLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 40, 120, 40)];
    [self.contentView addSubview:_downFirstLabel];

    _downSecondLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, 40, 100, 40)];
    [self.contentView addSubview:_downSecondLabel];

    
    return self;
}
-(void)layoutSubviews{
    _upFirstLabel.font = [UIFont systemFontOfSize:15];
    _upFirstLabel.textColor = [UIColor whiteColor];
    
    _upSecondLabel.font = [UIFont systemFontOfSize:15];
    _upSecondLabel.textColor = [UIColor whiteColor];
    
    _downFirstLabel.font = [UIFont systemFontOfSize:30];
    _downFirstLabel.textColor = [UIColor whiteColor];
    
    _downSecondLabel.font = [UIFont systemFontOfSize:30];
    _downSecondLabel.textColor = [UIColor whiteColor];

    
}

@end

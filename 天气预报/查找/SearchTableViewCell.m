//
//  SearchTableViewCell.m
//  天气预报
//
//  Created by 仲雯 on 2020/8/5.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    _cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, 300, 40)];
    [self.contentView addSubview:_cityLabel];
    
    return self;
}
-(void)layoutSubviews{
//    _cityLabel.font = [UIFont systemFontOfSize:23];
}
@end

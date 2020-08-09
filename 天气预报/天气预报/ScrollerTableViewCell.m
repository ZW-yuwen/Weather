//
//  ScrollerTableViewCell.m
//  天气预报
//
//  Created by 仲雯 on 2020/8/8.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import "ScrollerTableViewCell.h"

@implementation ScrollerTableViewCell

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    _scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 414, 120)];
    [self.contentView addSubview:_scroller];
    _scroller.pagingEnabled = NO;
    _scroller.contentSize = CGSizeMake(900, 120);
    _scroller.showsHorizontalScrollIndicator = NO;
    
//    _timeLabel = [[UILabel alloc]init];
//    [scroller addSubview:_timeLabel];
//
//    _iconImageView = [[UIImageView alloc]init];
//    [scroller addSubview:_iconImageView];
//
//    _temLabel = [[UILabel alloc]init];
//    [scroller addSubview:_temLabel];
    return self;
}
-(void)layoutSubviews{

//    _timeLabel.font = [UIFont systemFontOfSize:20];
//    _timeLabel.textColor = [UIColor whiteColor];
//
//    _temLabel.font = [UIFont systemFontOfSize:20];
//    _temLabel.textColor = [UIColor whiteColor];
    
}

@end

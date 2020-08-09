//
//  TipsTableViewCell.m
//  天气预报
//
//  Created by 仲雯 on 2020/8/8.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import "TipsTableViewCell.h"

@implementation TipsTableViewCell
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    _tipsLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_tipsLabel];
    return self;
}
-(void)layoutSubviews{

        _tipsLabel.font = [UIFont systemFontOfSize:18];
        _tipsLabel.textColor = [UIColor whiteColor];
}
@end

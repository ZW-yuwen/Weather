//
//  AllTableViewCell.h
//  天气预报
//
//  Created by 仲雯 on 2020/8/5.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AllTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel *timeLabel;
@property(nonatomic, strong)UILabel *cityLabel;
@property(nonatomic, strong)UILabel *tempLabel;

@end

NS_ASSUME_NONNULL_END

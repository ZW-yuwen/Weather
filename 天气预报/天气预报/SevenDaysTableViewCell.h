//
//  SevenDaysTableViewCell.h
//  天气预报
//
//  Created by 仲雯 on 2020/8/8.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SevenDaysTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *weekLabel;
@property (nonatomic, strong)UILabel *highTemLabel;
@property (nonatomic, strong)UILabel *lowTemLabel;
@property (nonatomic, strong)UIImageView *icon; 

@end

NS_ASSUME_NONNULL_END

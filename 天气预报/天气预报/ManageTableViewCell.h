//
//  ManageTableViewCell.h
//  天气预报
//
//  Created by 仲雯 on 2020/8/4.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ManageTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel *cityLabel;
@property(nonatomic, strong)UILabel *sunLabel;
@property(nonatomic, strong)UILabel *tempLabel;
@property(nonatomic, strong)UILabel *dateLabel;
@property(nonatomic, strong)UILabel *dayLabel;
@property(nonatomic, strong)UILabel *highTempLabel;
@property(nonatomic, strong)UILabel *lowTempLabel;

@end

NS_ASSUME_NONNULL_END

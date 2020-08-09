//
//  ScrollerTableViewCell.h
//  天气预报
//
//  Created by 仲雯 on 2020/8/8.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScrollerTableViewCell : UITableViewCell

//@property(nonatomic, strong) UILabel *timeLabel;
//@property(nonatomic, strong) UIImageView *iconImageView;
//@property(nonatomic, strong) UILabel *temLabel;


@property (nonatomic, strong) UIScrollView *scroller;
@end

NS_ASSUME_NONNULL_END

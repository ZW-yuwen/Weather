//
//  AllViewController.h
//  天气预报
//
//  Created by 仲雯 on 2020/8/5.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface AllViewController : UIViewController <SearchDelegate>

@property(nonatomic, strong)NSMutableArray *cityArray;
@property(nonatomic, strong)NSMutableArray *timeArray;
@property(nonatomic, strong)NSMutableArray *tempArray;
@property(nonatomic, strong)NSMutableArray *numArray;
@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *sunArray;
@property (nonatomic, strong) NSMutableArray *dayArray;
@property (nonatomic, strong) NSMutableArray *todayArray;
@property (nonatomic, strong) NSMutableArray *sevenArray;
@property (nonatomic, strong) NSMutableArray *hoursArray;
//@property (nonatomic, strong) NSMutableArray *lowTemArray;


-(void)cityCreatUrl;

@end

NS_ASSUME_NONNULL_END

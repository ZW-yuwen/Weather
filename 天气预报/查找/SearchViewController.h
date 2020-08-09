//
//  SearchViewController.h
//  天气预报
//
//  Created by 仲雯 on 2020/8/4.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SearchDelegate <NSObject>

-(void)search:(NSString *)name Location:(NSString *)number;

@end

@interface SearchViewController : UIViewController

@property(nonatomic, strong)UITextField *searchTextField;
@property(nonatomic, strong)NSMutableArray *cityArray;
@property(nonatomic, strong)NSMutableArray *showArray;
@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *numArray;
@property id <SearchDelegate>searchDelegate;

@end

NS_ASSUME_NONNULL_END

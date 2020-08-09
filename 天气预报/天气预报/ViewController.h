//
//  ViewController.h
//  天气预报
//
//  Created by 仲雯 on 2020/8/3.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllViewController.h"


@interface ViewController : UIViewController 


@property(nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) UILabel *lbLocation;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *numArray;
@property (nonatomic, strong) NSMutableArray *tempArray;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *sunArray;
@property (nonatomic, strong) NSMutableArray *todayArray;
@property (nonatomic, strong) NSMutableArray *sevenArray;
@property (nonatomic, strong) NSMutableArray *hourArray;
//@property (nonatomic, strong) NSMutableArray *highTemArray;
//@property (nonatomic, strong) NSMutableArray *lowTemArray;
@property  int start;




@end


//
//  ViewController.m
//  天气预报
//
//  Created by 仲雯 on 2020/8/3.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import "ViewController.h"
#import "AllViewController.h"
#import "ManageTableViewCell.h"
#import "Today.h"
#import "Weather7days.h"
#import "WeatherHour.h"
#import "DataTableViewCell.h"
#import "TipsTableViewCell.h"
#import "SevenDaysTableViewCell.h"
#import "ScrollerTableViewCell.h"

@interface ViewController ()
<NSURLSessionDataDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSMutableData *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _cityArray = [[NSMutableArray alloc] init];
//    [_cityArray addObject:@"西安"];
//    _numArray = [[NSMutableArray alloc]init];
//    [_numArray addObject:@"101110101"];
    
    UIImage *background = [UIImage imageNamed:@"背景.JPG"];
    self.view.layer.contents = (id)background.CGImage;
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, 414, 800)];
    [self.view addSubview:_scrollView];
    _scrollView.bounces = NO;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.contentSize = CGSizeMake(414 * _cityArray.count, 800);
    [_scrollView setContentOffset:CGPointMake(_start * 414, 0)];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(190, 860, 40, 10)];
    [self.view addSubview:_pageControl];
    _pageControl.numberOfPages = _cityArray.count;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    _pageControl.currentPage = _start;
    

    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"管理.png"] forState:UIControlStateNormal];
    addButton.frame = CGRectMake(380, 850, 20, 20);
    [self.view addSubview:addButton];
    [addButton addTarget:self action:@selector(pressAdd) forControlEvents:UIControlEventTouchUpInside];

    
//    _lbLocation = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, 400, 100)];
//    _lbLocation.textColor = [UIColor whiteColor];
//    [self.view addSubview:_lbLocation];
    for (int i = 0; i < _cityArray.count; i++) {
//        if (_cityArray.count != 0) {
            [self creatTableView: i];
   //     }
    }
    
}

-(void)creatTableView:(int) i{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(414 * i, 0, 414, 810) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_tableView];
//    NSLog(@"%d", 414*i);
    _tableView.dataSource = self;
    _tableView.tag = i;
    _tableView.delegate = self;
    [_tableView registerClass:[ManageTableViewCell class] forCellReuseIdentifier:@"101"];
    [_tableView registerClass:[DataTableViewCell class] forCellReuseIdentifier:@"data"];
    [_tableView registerClass:[TipsTableViewCell class] forCellReuseIdentifier:@"tips"];
    [_tableView registerClass:[SevenDaysTableViewCell class] forCellReuseIdentifier:@"week"];
    [_tableView registerClass:[ScrollerTableViewCell class] forCellReuseIdentifier:@"hour"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    for(int i = 0; i < _cityArray.count; i++){
        if(tableView.tag == i){
            if (indexPath.row == 0) {
                ManageTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"101"];
                if (cell == nil) {
                    cell = [_tableView dequeueReusableCellWithIdentifier:@"101" forIndexPath:indexPath];
                }
                Today *today = [[Today alloc] init];
                today = _todayArray[i];
                cell.cityLabel.text = _cityArray[i];
                NSString *str = [NSString stringWithFormat:@"%@°",_tempArray[i]];
                cell.tempLabel.text = str;
                cell.sunLabel.text = _sunArray[i];
                cell.dayLabel.text = today.dayStr;
                cell.highTempLabel.text = today.highTempStr;
                cell.lowTempLabel.text = today.lowTempStr;
                cell.dateLabel.text = @"今天";
//                NSLog(@"%@", today.highTempStr);
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            else if (indexPath.row == 1){
                ScrollerTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"hour"];
                if (cell == nil) {
                    cell = [_tableView dequeueReusableCellWithIdentifier:@"hour" forIndexPath:indexPath];
                }
                WeatherHour *hour = [[WeatherHour alloc]init];
                hour = _hourArray[i];
                NSMutableArray *timeArray = [[NSMutableArray alloc] init];
                [timeArray addObject:hour.timeNowStr];
                [timeArray addObject:hour.timeOneStr];
                [timeArray addObject:hour.timeTwoStr];
                [timeArray addObject:hour.timeThreeStr];
                [timeArray addObject:hour.timeFourStr];
                [timeArray addObject:hour.timeFiveStr];
                [timeArray addObject:hour.timeSixStr];
                [timeArray addObject:hour.timeSevenStr];
                [timeArray addObject:hour.timeEightStr];
                [timeArray addObject:hour.timeNineStr];
                
                NSMutableArray *temArray = [[NSMutableArray alloc] init];
                [temArray addObject:hour.temNowStr];
                [temArray addObject:hour.temOneStr];
                [temArray addObject:hour.temTwoStr];
                [temArray addObject:hour.temThreeStr];
                [temArray addObject:hour.temFourStr];
                [temArray addObject:hour.temFiveStr];
                [temArray addObject:hour.temSixStr];
                [temArray addObject:hour.temSevenStr];
                [temArray addObject:hour.temEightStr];
                [temArray addObject:hour.temNineStr];
                
                NSMutableArray *iconArray = [[NSMutableArray alloc]init];
                [iconArray addObject:hour.iconNowStr];
                [iconArray addObject:hour.iconOneStr];
                [iconArray addObject:hour.iconTwoStr];
                [iconArray addObject:hour.iconThreeStr];
                [iconArray addObject:hour.iconFourStr];
                [iconArray addObject:hour.iconFiveStr];
                [iconArray addObject:hour.iconSixStr];
                [iconArray addObject:hour.iconSevenStr];
                [iconArray addObject:hour.iconEightStr];
                [iconArray addObject:hour.iconNineStr];
            
                for (int j = 0; j < timeArray.count; j++) {
                    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(25 + 90 * j, 5, 90, 20)];
                    NSString *timeStr = timeArray[j];
                    timeLabel.font = [UIFont systemFontOfSize:20];
                    timeLabel.textColor = [UIColor whiteColor];
                    timeLabel.text = timeStr;
                    [cell.scroller addSubview:timeLabel];
                    
                    UILabel *temLabel = [[UILabel alloc]init];
                    NSString *temStr = [NSString stringWithFormat:@"%@°",temArray[j]];
                    temLabel.frame = CGRectMake(28 + 90 * j, 90, 90, 20);
                    temLabel.text = temStr;
                    temLabel.font = [UIFont systemFontOfSize:20];
                    temLabel.textColor = [UIColor whiteColor];
                    [cell.scroller addSubview:temLabel];
                    
                    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25 + 90 * j, 35, 40, 40)];
                    [cell.scroller addSubview:iconImageView];
                    [iconImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", iconArray[j]]]];
                }
                cell.backgroundColor = [UIColor clearColor];
                return cell;
            }
            else if(indexPath.row >= 2 && indexPath.row <= 7){
                SevenDaysTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"week"];
                if (cell == nil) {
                    cell = [_tableView dequeueReusableCellWithIdentifier:@"week" forIndexPath:indexPath];
                }
                Weather7days *sevenDays = [[Weather7days alloc]init];
                sevenDays = _sevenArray[i];
                if (indexPath.row == 2) {
                    cell.weekLabel.text = sevenDays.oneWeeksStr;
                    cell.highTemLabel.text = sevenDays.oneHighStr;
                    cell.lowTemLabel.text = sevenDays.oneLowStr;
                    [cell.icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", sevenDays.oneIconStr]]];
                }
                else if (indexPath.row == 3){
                    cell.weekLabel.text = sevenDays.twoWeeksStr;
                    cell.highTemLabel.text = sevenDays.twoHighStr;
                    cell.lowTemLabel.text = sevenDays.twoLowStr;
                    [cell.icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", sevenDays.twoIconStr]]];
                }
                else if (indexPath.row == 4) {
                    cell.weekLabel.text = sevenDays.threeWeeksStr;
                    cell.highTemLabel.text = sevenDays.threeHighStr;
                    cell.lowTemLabel.text = sevenDays.threeLowStr;
                    [cell.icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", sevenDays.threeIconStr]]];
                }
                else if (indexPath.row == 5) {
                    cell.weekLabel.text = sevenDays.fourWeeksStr;
                    cell.highTemLabel.text = sevenDays.fourHighStr;
                    cell.lowTemLabel.text = sevenDays.fourLowStr;
                    [cell.icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", sevenDays.fourIconStr]]];
                }
                else if (indexPath.row == 6) {
                    cell.weekLabel.text = sevenDays.fiveWeeksStr;
                    cell.highTemLabel.text = sevenDays.fiveHighStr;
                    cell.lowTemLabel.text = sevenDays.fiveLowStr;
                    [cell.icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", sevenDays.fiveIconStr]]];
                }
                else{
                    cell.weekLabel.text = sevenDays.sixWeeksStr;
                    cell.highTemLabel.text = sevenDays.sixHighStr;
                    cell.lowTemLabel.text = sevenDays.sixLowStr;
                    [cell.icon setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", sevenDays.sixIconStr]]];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
                return cell;
            }
            else if(indexPath.row == 8){
                TipsTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"tips"];
                if (cell == nil) {
                    cell = [_tableView dequeueReusableCellWithIdentifier:@"data" forIndexPath:indexPath];
                }
                Today *today = [[Today alloc] init];
                today = _todayArray[i];
                NSString *tipsStr =[NSString stringWithFormat:@"今天：目前%@。最高温度可达%@°，最低温度可达%@°。",_sunArray[i], today.highTempStr, today.lowTempStr];
                cell.tipsLabel.text = tipsStr;
                cell.tipsLabel.frame = CGRectMake(20, 15, 374, 60);
                cell.tipsLabel.lineBreakMode = UILineBreakModeWordWrap;
                cell.tipsLabel.numberOfLines = 0;
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            else{
                DataTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"data"];
                if (cell == nil) {
                    cell = [_tableView dequeueReusableCellWithIdentifier:@"data" forIndexPath:indexPath];
                }
                Today *today = [[Today alloc] init];
                today = _todayArray[i];
                if (indexPath.row == 9) {
                    cell.upFirstLabel.text = @"日出";
                    cell.downFirstLabel.text = @"6:07";
                    cell.upSecondLabel.text = @"日落";
                    cell.downSecondLabel.text = @"19:46";
                }
                else if(indexPath.row == 10){
                    cell.upFirstLabel.text = @"降雨概率";
                    cell.downFirstLabel.text = today.rainStr;
                    cell.upSecondLabel.text = @"湿度";
                    cell.downSecondLabel.text = today.wetStr;
                }
                else if(indexPath.row == 11){
                    cell.upFirstLabel.text = @"风";
                    cell.downFirstLabel.text = today.windStr;
                    cell.upSecondLabel.text = @"体感温度";
                    NSString *str = [NSString stringWithFormat:@"%@°",today.bodytemStr];
                    cell.downSecondLabel.text = str;
                }
                else if(indexPath.row == 12){
                    cell.upFirstLabel.text = @"降雨量";
                    cell.downFirstLabel.text = today.rainLenghtStr;
                    cell.upSecondLabel.text = @"气压";
                    cell.downSecondLabel.text = today.pressureStr;
                }
                else{
                    cell.upFirstLabel.text = @"能见度";
                    cell.downFirstLabel.text = today.seenStr;
                    cell.upSecondLabel.text = @"紫外线指数";
                    cell.downSecondLabel.text = today.purpleStr;
                }
                cell.backgroundColor = [UIColor clearColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
    }
    return nil;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"%ld", _cityArray.count);
    return 14;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        return 340;
    }
    else if (indexPath.row == 1){
        return 130;
    }
    else if(indexPath.row >= 2 && indexPath.row <= 7){
        return 50;
    }
    return 90;
}
- (void)pressAdd{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_start != 0) {
        int temp;
        temp = _scrollView.contentOffset.x / 414;
        if (temp != _pageControl.currentPage) {
            _pageControl.currentPage = temp;
        }
    }
}

@end

//
//  AllViewController.m
//  天气预报
//
//  Created by 仲雯 on 2020/8/5.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import "AllViewController.h"
#import "SearchViewController.h"
#import "AllTableViewCell.h"
#import "ViewController.h"
#import "Today.h"
#import "Weather7days.h"
#import "WeatherHour.h"

@interface AllViewController ()<UITableViewDelegate, UITableViewDataSource, NSURLSessionDataDelegate>
@property(nonatomic, strong)NSMutableData *data;

@property int i;

@end

@implementation AllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _i = 0;
    
    UIImage *background = [UIImage imageNamed:@"背景.JPG"];
    self.view.layer.contents = (id)background.CGImage;
    
    if(_timeArray == nil){
        _timeArray = [[NSMutableArray alloc] init];
    }
    if (_cityArray == nil) {
        _cityArray = [[NSMutableArray alloc] init];
    }
    if (_numArray == nil) {
        _numArray = [[NSMutableArray alloc] init];
    }
    if (_tempArray == nil) {
        _tempArray = [[NSMutableArray alloc] init];
    }
    if (_sunArray == nil) {
        _sunArray = [[NSMutableArray alloc] init];
    }
    if (_todayArray == nil) {
        _todayArray = [[NSMutableArray alloc] init];
    }
    if (_sevenArray == nil) {
        _sevenArray = [[NSMutableArray alloc] init];
    }
    if (_hoursArray == nil) {
        _hoursArray = [[NSMutableArray alloc] init];
    }
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:addButton];
    addButton.frame = CGRectMake(370, 850, 25, 25);
    [addButton setImage:[UIImage imageNamed:@"添加.png"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(pressAdd) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel* templabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 840, 100, 30)];
    templabel.font = [UIFont systemFontOfSize:18];
    templabel.text = @"°C/°F";
    templabel.textColor = [UIColor whiteColor];
    [self.view addSubview:templabel];
    
//    [self cityCreatUrl];
   
}

-(void)cityCreatUrl{
    dispatch_async(dispatch_get_main_queue(), ^{
        //设置请求地址
        NSString *str = [NSString stringWithFormat:@"https://tianqiapi.com/api?version=v6&appid=37494222&appsecret=Ck4Iy0z9&cityid=%@",self->_numArray[self->_i-1]];
        str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *url = [NSURL URLWithString:str];
            //封装一个请求类
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
            //创建Session
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error == nil){
            NSDictionary* oneDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if(oneDictionary){
                    NSString * str = oneDictionary[@"tem"];
                    NSString * str01 = oneDictionary[@"update_time"];
                    if(str && str01){
                        [self->_tempArray addObject:str];
                        [self->_timeArray addObject:str01];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (self->_tableView) {
//                        [self->_tableView reloadData];
//                    } else {
//                        [self creatTableView];
//                    }
                    [self todayCreatUrl];
                    [self senvenDaysCreatUrl];
                    [self hourCreatUrl];
                });
            }
        }];
        [dataTask resume];
    });
}

-(void)todayCreatUrl{
    dispatch_async(dispatch_queue_create("MY_queue", NULL), ^{
        //设置请求地址
        NSString *str = [NSString stringWithFormat:@"https://tianqiapi.com/api?version=v6&appid=37494222&appsecret=Ck4Iy0z9&cityid=%@",self->_numArray[self->_cityArray.count-1]];
        
        str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSLog(@"%@", str);
        NSURL *url = [NSURL URLWithString:str];
            //封装一个请求类
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
            //创建Session
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error == nil){
            NSDictionary* oneDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if(oneDictionary){
                    Today *today = [[Today alloc]init];
                    [self->_sunArray addObject:oneDictionary[@"wea"]];
                    today.dayStr = oneDictionary[@"week"];
                    today.highTempStr = oneDictionary[@"tem1"];
                    today.lowTempStr = oneDictionary[@"tem2"];
                    today.wetStr = oneDictionary[@"humidity"];
                    today.rainStr = @"10%";
                    today.windStr = oneDictionary[@"win"];
                    today.bodytemStr = oneDictionary[@"tem"];
                    today.rainLenghtStr = @"0公尺";
                    today.pressureStr = oneDictionary[@"pressure"];
                    today.seenStr = oneDictionary[@"visibility"];
                    today.purpleStr = @"6";
                    [self->_todayArray addObject:today];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                     if (self->_tableView) {
                        [self->_tableView reloadData];
                    } else {
                        [self creatTableView];
                    }
                });
            }
        }];
        [dataTask resume];
    });
}
-(void)senvenDaysCreatUrl{
    dispatch_async(dispatch_queue_create("MY_queue", NULL), ^{
        //设置请求地址
        NSString *str = [NSString stringWithFormat:@"https://tianqiapi.com/api?version=v1&appid=37494222&appsecret=Ck4Iy0z9&cityid=%@",self->_numArray[self->_cityArray.count-1]];
        
        str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSLog(@"%@", str);
        NSURL *url = [NSURL URLWithString:str];
            //封装一个请求类
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
            //创建Session
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error == nil){
            NSDictionary* oneDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if(oneDictionary){
                    Weather7days *sevenDays = [[Weather7days alloc]init];
                    sevenDays.oneWeeksStr = oneDictionary[@"data"][1][@"week"];
                    sevenDays.twoWeeksStr = oneDictionary[@"data"][2][@"week"];
                    sevenDays.threeWeeksStr = oneDictionary[@"data"][3][@"week"];
                    sevenDays.fourWeeksStr = oneDictionary[@"data"][4][@"week"];
                    sevenDays.fiveWeeksStr = oneDictionary[@"data"][5][@"week"];
                    sevenDays.sixWeeksStr = oneDictionary[@"data"][6][@"week"];
                    
                    sevenDays.oneHighStr = oneDictionary[@"data"][1][@"tem1"];
                    sevenDays.oneLowStr = oneDictionary[@"data"][1][@"tem2"];
                    sevenDays.twoHighStr = oneDictionary[@"data"][2][@"tem1"];
                    sevenDays.twoLowStr = oneDictionary[@"data"][2][@"tem2"];
                    sevenDays.threeHighStr = oneDictionary[@"data"][3][@"tem1"];
                    sevenDays.threeLowStr = oneDictionary[@"data"][3][@"tem2"];
                    sevenDays.fourHighStr = oneDictionary[@"data"][4][@"tem1"];
                    sevenDays.fourLowStr = oneDictionary[@"data"][4][@"tem2"];
                    sevenDays.fiveHighStr = oneDictionary[@"data"][5][@"tem1"];
                    sevenDays.fiveLowStr = oneDictionary[@"data"][5][@"tem2"];
                    sevenDays.sixHighStr = oneDictionary[@"data"][6][@"tem1"];
                    sevenDays.sixLowStr = oneDictionary[@"data"][6][@"tem2"];
                    
                    sevenDays.oneIconStr = oneDictionary[@"data"][1][@"wea_img"];
                    sevenDays.twoIconStr = oneDictionary[@"data"][2][@"wea_img"];
                    sevenDays.threeIconStr = oneDictionary[@"data"][3][@"wea_img"];
                    sevenDays.fourIconStr = oneDictionary[@"data"][4][@"wea_img"];
                    sevenDays.fiveIconStr = oneDictionary[@"data"][5][@"wea_img"];
                    sevenDays.sixIconStr = oneDictionary[@"data"][6][@"wea_img"];
                    
                    NSLog(@"%@", sevenDays.oneIconStr);

                    [self->_sevenArray addObject:sevenDays];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                     if (self->_tableView) {
                        [self->_tableView reloadData];
                    } else {
                        [self creatTableView];
                    }
                });
            }
        }];
        [dataTask resume];
    });
}
-(void)hourCreatUrl{
    dispatch_async(dispatch_queue_create("MY_queue", NULL), ^{
        //设置请求地址
        NSString *str = [NSString stringWithFormat:@"https://yiketianqi.com/api?version=v9&appid=37494222&appsecret=Ck4Iy0z9&cityid=%@",self->_numArray[self->_cityArray.count-1]];
        
        str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSLog(@"%@", str);
        NSURL *url = [NSURL URLWithString:str];
            //封装一个请求类
        NSURLRequest * request = [NSURLRequest requestWithURL:url];
            //创建Session
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error == nil){
            NSDictionary* oneDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                if(oneDictionary){
                    WeatherHour *hour = [[WeatherHour alloc]init];
                    hour.timeNowStr = oneDictionary[@"data"][0][@"hours"][0][@"hours"];
                    hour.timeOneStr = oneDictionary[@"data"][0][@"hours"][1][@"hours"];
                    hour.timeTwoStr = oneDictionary[@"data"][0][@"hours"][2][@"hours"];
                    hour.timeThreeStr = oneDictionary[@"data"][0][@"hours"][3][@"hours"];
                    hour.timeFourStr = oneDictionary[@"data"][0][@"hours"][4][@"hours"];
                    hour.timeFiveStr = oneDictionary[@"data"][0][@"hours"][5][@"hours"];
                    hour.timeSixStr = oneDictionary[@"data"][0][@"hours"][6][@"hours"];
                    hour.timeSevenStr = oneDictionary[@"data"][0][@"hours"][7][@"hours"];
                    hour.timeEightStr = oneDictionary[@"data"][0][@"hours"][8][@"hours"];
                    hour.timeNineStr = oneDictionary[@"data"][0][@"hours"][9][@"hours"];
                    
                    hour.temNowStr = oneDictionary[@"data"][0][@"hours"][0][@"tem"];
                    hour.temOneStr = oneDictionary[@"data"][0][@"hours"][1][@"tem"];
                    hour.temTwoStr = oneDictionary[@"data"][0][@"hours"][2][@"tem"];
                    hour.temThreeStr = oneDictionary[@"data"][0][@"hours"][3][@"tem"];
                    hour.temFourStr = oneDictionary[@"data"][0][@"hours"][4][@"tem"];
                    hour.temFiveStr = oneDictionary[@"data"][0][@"hours"][5][@"tem"];
                    hour.temSixStr = oneDictionary[@"data"][0][@"hours"][6][@"tem"];
                    hour.temSevenStr = oneDictionary[@"data"][0][@"hours"][7][@"tem"];
                    hour.temEightStr = oneDictionary[@"data"][0][@"hours"][8][@"tem"];
                    hour.temNineStr = oneDictionary[@"data"][0][@"hours"][9][@"tem"];
                    
                    hour.iconNowStr = oneDictionary[@"data"][0][@"hours"][0][@"wea_img"];
                    hour.iconOneStr = oneDictionary[@"data"][0][@"hours"][1][@"wea_img"];
                    hour.iconTwoStr = oneDictionary[@"data"][0][@"hours"][2][@"wea_img"];
                    hour.iconThreeStr = oneDictionary[@"data"][0][@"hours"][3][@"wea_img"];
                    hour.iconFourStr = oneDictionary[@"data"][0][@"hours"][4][@"wea_img"];
                    hour.iconFiveStr = oneDictionary[@"data"][0][@"hours"][5][@"wea_img"];
                    hour.iconSixStr = oneDictionary[@"data"][0][@"hours"][6][@"wea_img"];
                    hour.iconSevenStr = oneDictionary[@"data"][0][@"hours"][7][@"wea_img"];
                    hour.iconEightStr = oneDictionary[@"data"][0][@"hours"][8][@"wea_img"];
                    hour.iconNineStr = oneDictionary[@"data"][0][@"hours"][9][@"wea_img"];

                    
                    NSLog(@"%@", hour.iconNowStr);

                    [self->_hoursArray addObject:hour];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                     if (self->_tableView) {
                        [self->_tableView reloadData];
                    } else {
                        [self creatTableView];
                    }
                });
            }
        }];
        [dataTask resume];
    });
}

-(void)creatTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 414, 830) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[AllTableViewCell class] forCellReuseIdentifier:@"101"];
//    [self cityCreatUrl];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AllTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"101" forIndexPath:indexPath];
    cell.cityLabel.text = _cityArray[indexPath.row];
//    NSLog(@"%ld !!!", indexPath.row);
    NSString *str = [NSString stringWithFormat:@"%@°",_tempArray[indexPath.row] ];
    cell.tempLabel.text = str;
    cell.timeLabel.text = _timeArray[indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
 }
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"%lu",_cityArray);
    return _cityArray.count;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewController *oneVC = [[ViewController alloc] init];
    oneVC.cityArray = _cityArray;
    oneVC.tempArray = _tempArray;
    oneVC.sunArray = _sunArray;
    oneVC.todayArray = _todayArray;
    oneVC.sevenArray = _sevenArray;
    oneVC.hourArray = _hoursArray;
    oneVC.start = indexPath.row;
    oneVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:oneVC animated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(void)pressAdd{
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.showArray = _cityArray;
    searchVC.searchDelegate = self;
    searchVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:searchVC animated:YES completion:nil];

}
-(void)search:(NSString *)name Location:(NSString *)number{
    [_cityArray addObject:name];
    [_numArray addObject:number];
//    NSLog(@"%@",number);
    NSLog(@"%lu", _cityArray.count);
//    _count = _count + 1;
    _i++;
    NSLog(@"%d", _i);
    [self cityCreatUrl];
 //   [self todayCreatUrl];
//    [_tableView reloadData];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

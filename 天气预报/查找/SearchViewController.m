//
//  SearchViewController.m
//  天气预报
//
//  Created by 仲雯 on 2020/8/4.
//  Copyright © 2020 仲雯. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"

@interface SearchViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, NSURLSessionDataDelegate>
@property(nonatomic, strong)NSMutableData *data;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *background = [UIImage imageNamed:@"背景.JPG"];
    self.view.layer.contents = (id)background.CGImage;
    
    _searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(25, 50, 330, 40)];
    [self.view addSubview:_searchTextField];
    _searchTextField.placeholder = @"请输入城市信息";
    _searchTextField.delegate = self;
    [_searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
    _searchTextField.keyboardType = UIKeyboardTypeDefault;
    _searchTextField.backgroundColor = [UIColor clearColor];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(360, 60, 40, 20);
    [self.view addSubview:backButton];
    backButton.tintColor = [UIColor whiteColor];
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 20, 15)];
    leftImage.image = [UIImage imageNamed:@"搜索.png"];
    _searchTextField.leftView = leftImage;
    _searchTextField.leftViewMode = UITextFieldViewModeAlways;
    leftImage.contentMode = UIViewContentModeCenter;
    [self.view addSubview:_searchTextField];
    
    if (_cityArray == nil) {
        _cityArray = [[NSMutableArray alloc] init];
    }
    if(_numArray == nil){
        _numArray = [[NSMutableArray alloc] init];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 100, 380, 394) style:UITableViewStylePlain];
     [self.view addSubview:_tableView];
     _tableView.delegate = self;
     _tableView.dataSource = self;
     [_tableView registerClass:[SearchTableViewCell class] forCellReuseIdentifier:@"111"];
     _tableView.backgroundColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"111" forIndexPath:indexPath];
    cell.cityLabel.text = _cityArray[indexPath.row];
    cell.cityLabel.textColor = [UIColor whiteColor];
    cell.cityLabel.font = [UIFont systemFontOfSize:20];
//    cell.cityLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cityArray.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _searchTextField.text = _cityArray[indexPath.row];
    int flag = 1;
    NSLog(@"%lu",_showArray.count);
    for (int i = 0; i < _showArray.count; i++) {
        if ([_showArray[i] isEqualToString:_searchTextField.text]) {
            flag = 0;
            break;
        }
    }
    if (flag == 1) {
        if ([_searchDelegate respondsToSelector:@selector(search:Location:)]) {
            [_searchDelegate search:_searchTextField.text Location:_numArray[indexPath.row]];
        }
        [self dismissViewControllerAnimated:NO completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经有该城市！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:sureAction];
        [self presentViewController:alert animated:NO completion:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSLog(@"%@111", textField.text);
    if(string != nil && _searchTextField.text != NULL){
        NSString * str = [_searchTextField.text stringByAppendingString:string];
        [self creatUrl:str];
        
 //       NSLog(@"%@",str);
    }
    _cityArray = [[NSMutableArray alloc] init];
    _numArray = [[NSMutableArray alloc] init];
    return YES;
}

-(void)creatUrl:(NSString *)str{
    NSString *strName = [NSString stringWithFormat:@"https://geoapi.heweather.net/v2/city/lookup?location=%@&key=fbd7d8d089284f159aeeec08fd63985f", str];
    //中文空格字符编码/解码
    strName = [strName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:strName];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    
    [dataTask resume];
        
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler{
//    NSLog(@"didReceiveResponse");
 
    if(self.data == nil){
        self.data = [[NSMutableData alloc] init];
    } else {
        self.data.length = 0;
    }
    //允许接收数据
    completionHandler(NSURLSessionResponseAllow);
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
  //  NSLog(@"didReceiveData");
    [self.data appendData:data];
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (error == nil) {
   //     NSLog(@"didCompleteWithError");
        NSDictionary *secondDictionary = [NSJSONSerialization JSONObjectWithData:self.data options:kNilOptions error:nil];
        _cityArray = [[NSMutableArray alloc]init];
        _numArray = [[NSMutableArray alloc]init];
        NSArray *timeArray = [[NSArray alloc]init];
        timeArray = secondDictionary[@"location"];
        for (int i = 0; i < timeArray.count; i++) {
            NSString * str = secondDictionary[@"location"][i][@"name"];
            NSString * numberStr = secondDictionary[@"location"][i][@"id"];
//            NSLog(@"%@",str);
//            NSLog(@"%@",numberStr);
            if(str && numberStr){
                [_cityArray addObject:str];
                [_numArray addObject:numberStr];
            }
        }
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self->_tableView reloadData];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_searchTextField endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return YES;
}
- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
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

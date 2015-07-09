//
//  HAMaintenanceCityViewController.m
//  安心汽车
//
//  Created by kongw on 15/4/15.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAMaintenanceCityViewController.h"

@interface HAMaintenanceCityViewController (){
    NSMutableArray *cityArrList;
}

@end

@implementation HAMaintenanceCityViewController
@synthesize carBrand;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择城市";
    self.view.backgroundColor = [UIColor whiteColor];
    cityArrList = [[NSMutableArray alloc] init];
    //http://file.ywsoftware.com:9090/T100040/appointment/showSupportCity
    NSString *downName = @"/T100040/appointment/showSupportCity";
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:nil httpMethod:@"GET" ssl:NO];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
        if ([[cityInfo objectForKey:@"resultCode"]integerValue] == 1) {
            cityArrList = [[NSMutableArray alloc] initWithArray:[cityInfo objectForKey:@"supportCity"]];
            NSDictionary *insert = [[NSDictionary alloc] init];
            for (int i = 0; i < cityArrList.count; i++) {
                NSDictionary *dic = [cityArrList objectAtIndex:i];
                NSString *cityName = [[NSUserDefaults standardUserDefaults] objectForKey:dwCityName];
                if ([cityName isEqualToString:[dic objectForKey:@"cityName"]]) {
                    [cityArrList removeObjectAtIndex:i];
                    insert = dic;
                    [cityArrList insertObject:insert atIndex:0];
                }
            }
            [mcityTableView reloadData];
        }else{
            [MBProgressHUD showError:@"网络超时"];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"失败");
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
    
    mcityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-TABBAR_TAP_BUTTON_WIDTH)];
    mcityTableView.backgroundColor = [UIColor clearColor];
    mcityTableView.delegate = self;
    mcityTableView.dataSource = self;
    [self.view addSubview:mcityTableView];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
}

-(void)backAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return cityArrList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        NSDictionary *dic = [cityArrList objectAtIndex:indexPath.row];
        //NSLog(@"dic == %@",dic);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [dic objectForKey:@"cityName"];
        cell.accessibilityHint = [dic objectForKey:@"cityId"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    HAMtenaCityListViewController *cityListVc = [[HAMtenaCityListViewController alloc] init];
    cityListVc.cityID = cell.accessibilityHint;
    cityListVc.carBrand_new = carBrand;
    [self.navigationController pushViewController:cityListVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

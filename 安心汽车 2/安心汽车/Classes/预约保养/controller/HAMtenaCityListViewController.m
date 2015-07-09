//
//  HAMtenaCityListViewController.m
//  安心汽车
//
//  Created by kongw on 15/4/15.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAMtenaCityListViewController.h"

@interface HAMtenaCityListViewController ()

@end

@implementation HAMtenaCityListViewController
@synthesize cityID;
@synthesize carBrand_new;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择4S店";
    self.view.backgroundColor = [UIColor whiteColor];
    mtenCityListArr = [[NSArray alloc] init];
    mtenaCityListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-TABBAR_TAP_BUTTON_WIDTH)];
    mtenaCityListTableView.backgroundColor = [UIColor clearColor];
    mtenaCityListTableView.delegate = self;
    mtenaCityListTableView.dataSource = self;
    [self.view addSubview:mtenaCityListTableView];
    
    //http://file.ywsoftware.com:9090/T100040/appointment/showPartnerCompany?cityId=%@&carBrand=%@
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:cityID forKey:@"cityId"];
    [data setObject:carBrand_new forKey:@"carBrand"];
    //http://file.ywsoftware.com:9090/T100040/appointment/showPartnerCompany?cityId=330100&carBrand=宝马
    NSString *downName = @"/T100040/appointment/showPartnerCompany";
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:data httpMethod:@"GET" ssl:NO];
    NSLog(@"sdfsf == %@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *dic = [completedOperation.responseString objectFromJSONString];
        if ([[dic objectForKey:@"resultCode"]integerValue]==1) {
            mtenCityListArr= [dic objectForKey:@"companys"];
            [mtenaCityListTableView reloadData];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"失败");
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
}

-(void)backAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mtenCityListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        NSDictionary *cityListDic = [mtenCityListArr objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [cityListDic objectForKey:@"partnerName"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   // NSLog(@"1111 == %@",[mtenCityListArr objectAtIndex:indexPath.row]);
    [[NSNotificationCenter defaultCenter] postNotificationName:MainTenanceCarNameChoice object:[mtenCityListArr objectAtIndex:indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:^{
        //NSLog(@"返回的数据 ＝＝ %@",[mtenCityListArr objectAtIndex:indexPath.row]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

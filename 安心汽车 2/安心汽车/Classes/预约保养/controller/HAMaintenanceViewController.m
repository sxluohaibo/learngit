//
//  HAMaintenanceViewController.m
//  安心汽车
//
//  Created by kongw on 15/4/15.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAMaintenanceViewController.h"

@interface HAMaintenanceViewController (){
    NSArray *titleArr;
    HAMaintenanceView *maintenanceView;
}

@end

@implementation HAMaintenanceViewController
@synthesize matenanceType;
@synthesize detailModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sub_bg.jpg"]];
    self.navigationItem.title = @"预约保养";
    
    NSString *downName = [NSString stringWithFormat:@"/T100040/appointment/showCarInfo?phoneNo=%@",[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserPhonenumer]];
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:nil httpMethod:@"GET" ssl:NO];
    NSLog(@"url %@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
        //NSLog(@"预约保养  cityInfo%@",cityInfo);
        maintenanceView = [[HAMaintenanceView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) andUserDic:[cityInfo objectForKey:@"carInfo"] andSumitType:matenanceType andDetailModel:detailModel];
        [self.view addSubview:maintenanceView];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"失败");
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    //self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
}

//返回的按钮
- (void)backAction:(UIButton *)sender{
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

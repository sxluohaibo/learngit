//
//  HAMatenanceDetailViewController.m
//  安心汽车
//
//  Created by kongw on 15/4/16.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAMatenanceDetailViewController.h"

@interface HAMatenanceDetailViewController ()

@end

@implementation HAMatenanceDetailViewController
@synthesize detailDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *deteleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deteleButton setTitle:@"取消预约" forState:UIControlStateNormal];
    deteleButton.backgroundColor = [UIColor blackColor];
    [deteleButton addTarget:self action:@selector(deteleAction) forControlEvents:UIControlEventTouchUpInside];
    [deteleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deteleButton.frame = CGRectMake(0, 0, 100, 30);
    [self.view addSubview:deteleButton];
    
    
    UIButton *changeOrder = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeOrder setTitle:@"修改预约" forState:UIControlStateNormal];
    changeOrder.backgroundColor = [UIColor blackColor];
    [changeOrder addTarget:self action:@selector(changeOrder) forControlEvents:UIControlEventTouchUpInside];
    [changeOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    changeOrder.frame = CGRectMake(200, 0, 100, 30);
    [self.view addSubview:changeOrder];
}

- (void)changeOrder{
    NSLog(@"修改预约");
    HAMaintenanceViewController *changeMantence = [[HAMaintenanceViewController alloc] init];
    changeMantence.matenanceType = 2;
    [self.navigationController pushViewController:changeMantence animated:YES];
}

- (void)deteleAction{
    [MBProgressHUD showMessage:@"正在取消预约"];
    //http://file.ywsoftware.com:9090/T100040/appointment/deleteAppointment
    NSString *tempID = [[detailDic objectForKey:@"appointment"] objectForKey:@"id"];
    NSString *downName = [NSString stringWithFormat:@"/T100040/appointment/deleteAppointment?appointId=%@",tempID];
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:nil httpMethod:@"GET" ssl:NO];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [MBProgressHUD hideHUD];
        NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
        if ([[cityInfo objectForKey:@"resultCode"]integerValue]==1) {
            [MBProgressHUD showSuccess:@"取消成功"];
        }else{
            [MBProgressHUD showError:@"取消失败"];
        }
    }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"失败");
        [MBProgressHUD hideHUD];
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

//
//  HANewAppointDetailViewController.m
//  安心汽车
//
//  Created by kongw on 15/4/21.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HANewAppointDetailViewController.h"

@interface HANewAppointDetailViewController ()

@end

@implementation HANewAppointDetailViewController
@synthesize detailInfoDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sub_bg.jpg"]];
    self.navigationItem.title = @"预约成功";
//    self.navigationItem.title = @"最新的预约";
    
    #define AppointTime @"预约时间"
    #define carNo @"车牌号"
    #define phoneNo @"预约电话"
    #define carBuyDate @"购买时间"
    #define mileage @"里程数"
    #define appointStatus @"预约状态"
    #define partnerName @"预约的4S店"
    #define remarks @"备注"
    
    NSDictionary *tempDic = [detailInfoDic objectForKey:@"appointment"];
    //NSArray *listArr = [[NSArray alloc] initWithObjects:AppointTime,carNo,phoneNo,carBuyDate,mileage,appointStatus,partnerName,remarks, nil];
    NSMutableDictionary *sendData = [[NSMutableDictionary alloc] init];
    [sendData setObject:[tempDic objectForKey:@"appointTime"] forKey:AppointTime];
    [sendData setObject:[tempDic objectForKey:@"carNo"] forKey:carNo];
    [sendData setObject:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserPhonenumer] forKey:phoneNo];
    [sendData setObject:[tempDic objectForKey:@"carBuyDate"] forKey:carBuyDate];
    [sendData setObject:[tempDic objectForKey:@"mileage"] forKey:mileage];
    if ([[tempDic objectForKey:@"appointStatus"] integerValue] == 0) {
        [sendData setObject:@"待处理" forKey:appointStatus];
    }
    if ([[tempDic objectForKey:@"appointStatus"] integerValue] == 1) {
        [sendData setObject:@"预约成功" forKey:appointStatus];
    }
    if ([[tempDic objectForKey:@"appointStatus"] integerValue] == 2) {
        [sendData setObject:@"预约失败" forKey:appointStatus];
    }
    [sendData setObject:[tempDic objectForKey:@"partnerName"] forKey:partnerName];
    [sendData setObject:[tempDic objectForKey:@"remarks"] forKey:remarks];
//    for (int i = 0; i < listArr.count; i++) {
//        UIImageView *tempView = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*45, ScreenWidth, 40)];
//        tempView.backgroundColor = [UIColor grayColor];
//        [self.view addSubview:tempView];
//        
//        UILabel *titleName = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 30)];
//        titleName.font = [UIFont systemFontOfSize:14.0f];
//        titleName.backgroundColor = [UIColor redColor];
//        titleName.text = [listArr objectAtIndex:i];
//        [tempView addSubview:titleName];
//        
//        UILabel *textName = [[UILabel alloc] initWithFrame:CGRectMake(95, 0, ScreenWidth-110, 40)];
//        textName.font = [UIFont systemFontOfSize:14.0f];
//        textName.numberOfLines = 0;
//        textName.text = [sendData objectForKey:[listArr objectAtIndex:i]];
//        textName.backgroundColor = [UIColor redColor];
//        [tempView addSubview:textName];
//    }
//    //取消订单
//    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
//    cancel.backgroundColor = [UIColor grayColor];
//    cancel.frame = CGRectMake(0, ScreenHeight- 100, 100, 30);
//    [cancel addTarget:self action:@selector(cancelAppointmentBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [cancel setTitle:@"取消预约" forState:UIControlStateNormal];
//    [self.view addSubview:cancel];
//    
//    UIButton *appointmentList = [UIButton buttonWithType:UIButtonTypeCustom];
//    appointmentList.backgroundColor = [UIColor grayColor];
//    appointmentList.frame = CGRectMake(200, ScreenHeight- 100, 100, 30);
//    [appointmentList addTarget:self action:@selector(appointmentListAciton:) forControlEvents:UIControlEventTouchUpInside];
//    [appointmentList setTitle:@"预约列表" forState:UIControlStateNormal];
//    [self.view addSubview:appointmentList];
//    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    UIImageView *bkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bkImageView.image = [UIImage imageNamed:@"yuyue_suc_bg"];
    [self.view addSubview:bkImageView];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(107, 87, 105, 95)];
    iconImageView.image = [UIImage imageNamed:@"yuyue_suc_icon"];
    [self.view addSubview:iconImageView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 204, ScreenWidth, 14)];
    label1.font = [UIFont systemFontOfSize:14.0f];
    label1.text = @"恭喜！！！";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = HAColor(0, 76, 135);
    [self.view addSubview:label1];
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 226, ScreenWidth, 14)];
    label2.font = [UIFont systemFontOfSize:14.0f];
    label2.text = [NSString stringWithFormat:@"您的车牌为%@的车辆",[sendData objectForKey:carNo]];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor = HAColor(0, 76, 135);
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 249, ScreenWidth-20, 28+10)];
    label3.font = [UIFont systemFontOfSize:14.0f];
    label3.numberOfLines = 0;
    NSArray *tempArr = [[sendData objectForKey:AppointTime] componentsSeparatedByString:@" "];
    label3.text = [NSString stringWithFormat:@"于%@在%@的预约保养申请已经提交",[tempArr objectAtIndex:0],[sendData objectForKey:partnerName]];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = HAColor(0, 76, 135);
    [self.view addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 271+14, ScreenWidth, 14)];
    label4.font = [UIFont systemFontOfSize:14.0f];
    label4.text = @"敬请等候4S店人员与您回电确认";
    label4.textAlignment = NSTextAlignmentCenter;
    label4.textColor = HAColor(0, 76, 135);
    [self.view addSubview:label4];
}

//返回到主界面
- (void)backAction:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//预约列表
- (void)appointmentListAciton:(UIButton *)sender{
    HAAppointmentListViewController *pointVc = [[HAAppointmentListViewController alloc] init];
    [self.navigationController pushViewController:pointVc animated:YES];
}

//取消预约
- (void)cancelAppointmentBtn:(id)sender {
    [MBProgressHUD showMessage:@"正在取消预约"];
    //http://file.ywsoftware.com:9090/T100040/appointment/deleteAppointment
    NSString *downName = [NSString stringWithFormat:@"/T100040/appointment/deleteAppointment?appointId=%@",[[detailInfoDic objectForKey:@"appointment"] objectForKey:@"id"]];
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

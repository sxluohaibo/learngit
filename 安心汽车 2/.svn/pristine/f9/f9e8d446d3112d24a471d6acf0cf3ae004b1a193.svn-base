//
//  HAClaimsViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/13.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAClaimsViewController.h"
#import "MBProgressHUD+MJ.h"

@interface HAClaimsViewController ()

//保险报案
- (IBAction)callInsuranceCompany:(id)sender;
//现场勘察
- (IBAction)reconnaissance:(id)sender;

//申请赔偿
- (IBAction)peiChang:(id)sender;
//理赔审核
- (IBAction)lipeishenghe:(id)sender;
//理赔决定
- (IBAction)lipeijueding:(id)sender;

@end

@implementation HAClaimsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"理赔流程";
}


- (IBAction)callInsuranceCompany:(id)sender {
    NSString * message = @"发生保险事故以后，请您拨打保险公司客服电话，保险公司客服人员会告诉您理赔所需要的单证，并进行相应的理赔引导。";
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"1.出险报案" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

- (IBAction)reconnaissance:(id)sender {
    
    NSString * message = @"保险公司理赔服务人员接到报案电话后，会立即赶到事故现场，进行事故勘察处理，和事故主定损失额度和维修方式。同时初步收集理赔相关的证据材料，并提醒您保存理赔所需要的单证。若事主因伤在医院治疗，理赔人员将去医院于你沟通协商。";
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"2.现场勘察" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

- (IBAction)peiChang:(id)sender {
 
    NSString * message = @"准备好理赔所需要的单证后，可在当地保险公司柜台申请办理理赔。对于当地没有理赔网点或者到柜台申请不方便的用户，部分公司支持将理赔申请材料邮寄至保险公司进行理赔。";
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"3.申请赔偿" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

- (IBAction)lipeishenghe:(id)sender {
   
    NSString * message = @"保险公司接受理赔材料后，进行理赔调查及审核";
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"4.理赔审核" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}

- (IBAction)lipeijueding:(id)sender {
    
    NSString * message = @"审核过后，保险公司会及时做出理赔决定。决定赔付的，将发送赔付通知，并通过银行转帐或现金等方式支付保险。决定不予赔偿的，将发送拒赔通知，并退还相应的申请材料。";
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"5.理赔决定" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}
@end

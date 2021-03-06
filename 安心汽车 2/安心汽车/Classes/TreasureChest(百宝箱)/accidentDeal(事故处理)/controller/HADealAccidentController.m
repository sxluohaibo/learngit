//
//  HADealAccidentController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/16.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  事故处理流程

#import "HADealAccidentController.h"
#import "HAProtectSceneController.h"
#import "HADutyViewController.h"
#import "AFNetworking.h"
@interface HADealAccidentController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>



- (IBAction)paizhao:(id)sender;
- (IBAction)baohuxianchang:(id)sender;
- (IBAction)zeren:(id)sender;
- (IBAction)jiuyuan:(id)sender;
- (IBAction)baoxian:(id)sender;

@end

@implementation HADealAccidentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赔付流程";

}



- (IBAction)paizhao:(id)sender {//相机
    
    UIImagePickerController * pc = [[UIImagePickerController alloc] init];
    pc.sourceType=UIImagePickerControllerSourceTypeCamera;
    pc.delegate = self;
    [self presentViewController:pc animated:YES completion:nil];
}




- (IBAction)baohuxianchang:(id)sender {//保护现场
    
    HAProtectSceneController * protectVc = [[HAProtectSceneController alloc] init];
    [self.navigationController pushViewController:protectVc animated:YES];
    
}

- (IBAction)zeren:(id)sender {
    
    HADutyViewController *controller=[[HADutyViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)jiuyuan:(id)sender {//救援
    
    
    HAProtectSceneController * protectVc = [[HAProtectSceneController alloc] init];
    [self.navigationController pushViewController:protectVc animated:YES];
}

- (IBAction)baoxian:(id)sender {//保险公司电话
    
    HANumberViewController *controller=[[HANumberViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end

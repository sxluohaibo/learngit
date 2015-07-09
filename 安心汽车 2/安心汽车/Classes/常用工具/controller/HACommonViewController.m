//
//  HACommonViewController.m
//  安心汽车
//
//  Created by kongw on 15/4/30.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACommonViewController.h"
#import "HAAnXinLiuChengViewController.h"

@interface HACommonViewController ()

@end

@implementation HACommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"常用工具";
    NSArray *iconArr = [[NSArray alloc] initWithObjects:@"wz_icon&违章查询",@"ax_icon&安心流程",@"lp_icon&理赔流程",@"kf_icon&扣分表", nil];
    self.view.userInteractionEnabled = YES;
    UIImageView *bkImage = [[UIImageView alloc] initWithFrame:CGRectMake(16, 21, ScreenWidth-16*2, ScreenHeight)];
    bkImage.userInteractionEnabled = YES;
    bkImage.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bkImage];
    
    for (int i = 0; i < iconArr.count; i++) {
        int x = i%2;
        int y = i/2;
        NSArray *tempArr = [[iconArr objectAtIndex:i] componentsSeparatedByString:@"&"];
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(x * (134+20), y * (55 +21), 134, 69)];
        iconImage.backgroundColor = HAColor(98, 120, 146);
        iconImage.userInteractionEnabled = YES;
        iconImage.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [iconImage addGestureRecognizer:tap];
        [bkImage addSubview:iconImage];
        
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake((134-30)/2, 9, 30, 33)];
        icon.image = [UIImage imageNamed:[tempArr objectAtIndex:0]];
        icon.backgroundColor = [UIColor clearColor];
        [iconImage addSubview:icon];
        
        UILabel *titleName = [[UILabel alloc] initWithFrame:CGRectMake(0, 47, 134, 20)];
        titleName.textAlignment = NSTextAlignmentCenter;
        titleName.textColor = [UIColor whiteColor];
        titleName.text = [tempArr objectAtIndex:1];
        titleName.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        titleName.backgroundColor = [UIColor clearColor];
        [iconImage addSubview:titleName];
    }
}

- (void)tapView:(UITapGestureRecognizer *)tap{
    if (tap.view.tag == 0) {//违章查询
        ApplicationDelegate.loginType = 1;//表明是违章登录
        if ([[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo] == nil) {
            HALoginViewController *loginVc = [[HALoginViewController alloc] init];
            [self.navigationController pushViewController:loginVc animated:YES];
        }else{
            HAViolationViewController *violationVc = [[HAViolationViewController alloc] init];
            [self.navigationController pushViewController:violationVc animated:YES];
        }
    }else if (tap.view.tag == 1){//安心流程
        HAAnXinLiuChengViewController *anXin = [[HAAnXinLiuChengViewController alloc] init];
        [self.navigationController pushViewController:anXin animated:YES];
    }else if (tap.view.tag == 2){//理赔流程
        HAClaimsViewController *claimVc = [[HAClaimsViewController alloc] init];
        [self.navigationController pushViewController:claimVc animated:YES];
    }else if (tap.view.tag == 3){//扣分表
        HAPenaltyPointsViewController *kfVc = [[HAPenaltyPointsViewController alloc] init];
        [self.navigationController pushViewController:kfVc animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end

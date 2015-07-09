//
//  HABottomView.m
//  安心汽车
//
//  Created by kongw on 15/3/19.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HABottomView.h"

@implementation HABottomView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = YES;
    if (self) {
        NSArray *titleArr = [[NSArray alloc] initWithObjects:@"预约保养",@"咨询服务",@"车辆救援",@"常用工具", nil];
        NSArray *imageArr = [[NSArray alloc] initWithObjects:@"yuyue_icon",@"zixun_icon",@"jiuyuan_icon",@"tools_icon", nil];
        //NSLog(@"ScreenWidth == %f",ScreenWidth);
        //NSLog(@"ScreenHeight == %f",ScreenHeight);
        
        for (int i = 0; i<4; i++) {
            UIImageView *bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(13+78*i, 0, 60, 80)];
            bottomView.userInteractionEnabled = YES;
            bottomView.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewAction:)];
            [bottomView addGestureRecognizer:tap];
            bottomView.backgroundColor = [UIColor clearColor];
            [self addSubview:bottomView];
            
            UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 54)];
            self.backgroundColor = [UIColor clearColor];
            [iconImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[imageArr objectAtIndex:i]]]];
            [bottomView addSubview:iconImage];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, 60, 25)];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = [UIColor whiteColor];
            label.text = [titleArr objectAtIndex:i];
            label.font = [UIFont systemFontOfSize:12.0f];
            label.backgroundColor = [UIColor clearColor];
            [bottomView addSubview:label];
        }
    }
    return self;
}

- (void)tapViewAction:(UIGestureRecognizer *)tap{
    if (tap.view.tag == 0) {
        //判断是否登陆
        ApplicationDelegate.loginType = 3;//预约保养的登录
        NSLog(@"登录的标记 == %@",[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]);
        if ([[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]) {
            HAMaintenanceViewController *maintenanceVc = [[HAMaintenanceViewController alloc] init];
            maintenanceVc.matenanceType=1;
            [[self viewController].navigationController pushViewController:maintenanceVc animated:YES];
        }else{
            HALoginViewController *loginVc = [[HALoginViewController alloc] init];
            [[self viewController].navigationController pushViewController:loginVc animated:YES];
        }
    }else if (tap.view.tag == 3){
        HACommonViewController *commonVc = [[HACommonViewController alloc] init];
        [[self viewController].navigationController pushViewController:commonVc animated:YES];
    }else if (tap.view.tag == 2){
        HACarHelpViewController *carHelpVc = [[HACarHelpViewController alloc] init];
        [[self viewController].navigationController pushViewController:carHelpVc animated:YES];
    }else if(tap.view.tag==1){
        ApplicationDelegate.loginType = 2;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]) {
            QuestionListViewController *questionListVc = [[QuestionListViewController alloc] init];
            [[self viewController].navigationController pushViewController:questionListVc animated:YES];
        }else{
            HALoginViewController *loginVc = [[HALoginViewController alloc] init];
            [[self viewController].navigationController pushViewController:loginVc animated:YES];
        }
    }
}

@end

//
//  HAMainViewController.h
//  安心汽车
//
//  Created by kongw on 15/4/23.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAWindowViewController.h"
#import "GprsGetCity.h"
#import "HATopView.h"

@interface HAMainViewController : HAWindowViewController<UIScrollViewDelegate,CityNameDelegate,HATopViewDelegate>{
    UILabel *carTypeNumber;
    NSString *appointTime;
}

@property(nonatomic,strong)UIButton *cityNameButton;//显示城市名称的按钮

- (void)refreshtheInterface;

@end

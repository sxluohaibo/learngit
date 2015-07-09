//
//  HATreasureChestViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/22.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HATreasureChestViewController.h"
#import "HAPenaltyPointsViewController.h"
#import "HAClaimsViewController.h"

#import "HADealAccidentController.h"
#define AppCount  3
#define AppMargin  5
#define percentage  0.7
@interface HATreasureChestViewController ()


@property(nonatomic,strong) NSArray * iconName;
@end

@implementation HATreasureChestViewController

- (NSArray *)iconName
{
    if (_iconName == nil) {
        
        _iconName = [NSArray array];
        _iconName = @[@"扣分表",@"理赔流程",@"事故处理"];
    }
    
    return _iconName;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"百宝箱";
    CGFloat appViewHW = (ScreenWidth - (AppCount + 1) * AppMargin) / AppCount;
    
    for (int index = 0; index < AppCount; index++) {
        
        
        CGFloat appViewX = (AppMargin + appViewHW) * index + AppMargin;
        CGFloat appViewY = AppMargin;
        UIView * appView = [[UIView alloc] init];
        
        appView.frame = CGRectMake(appViewX, appViewY, appViewHW, appViewHW);
//        appView.backgroundColor = [UIColor redColor];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(viewClick:)];
        [appView addGestureRecognizer:tap];
        appView.tag = index+1;
        
        UILabel * appLable = [[UILabel alloc] init];
        appLable.frame = CGRectMake(0, appViewHW * percentage, appViewHW, appViewHW*(1-percentage));
        appLable.text = self.iconName[index];
        appLable.textAlignment = NSTextAlignmentCenter;
        [appView addSubview:appLable];
        
        
        UIImageView * iconView = [[UIImageView alloc] init];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
        iconView.frame = CGRectMake(0, 0, appViewHW, appViewHW*percentage);
        iconView.image = [UIImage imageNamed:@"kou.png"];
        [appView addSubview:iconView];
        [self.view addSubview:appView];
    }
}

- (void)viewClick:(UITapGestureRecognizer*)tap
{
    if (tap.view.tag == 1) {
        
        HAPenaltyPointsViewController * vc = [[HAPenaltyPointsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (tap.view.tag == 2) {
        
        HAClaimsViewController * vc = [[HAClaimsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (tap.view.tag == 3) {
        
        HADealAccidentController * vc = [[HADealAccidentController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}



@end

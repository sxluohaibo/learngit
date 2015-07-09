//
//  HAVioDetailController.m
//  安心汽车
//
//  Created by kongw on 15/5/4.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAVioDetailController.h"
#import "HAVioDetailView.h"

@interface HAVioDetailController ()

@end

@implementation HAVioDetailController
@synthesize detailDic;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"违章查询";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sub_bg.jpg"]];
    HAVioDetailView *vioDetailView=[[HAVioDetailView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [vioDetailView setDetailDic:detailDic];
    [self.view addSubview:vioDetailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

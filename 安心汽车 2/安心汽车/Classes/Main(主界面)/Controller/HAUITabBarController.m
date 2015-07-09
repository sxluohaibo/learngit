//
//  HAUITabBarController.m
//  安心汽车
//
//  Created by tusm on 15-3-3.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAUITabBarController.h"
#import "HANavigationController.h"

@interface HAUITabBarController ()

@end

@implementation HAUITabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 1.初始化子控制器
    //主视图
//    HAMainViewController *business = [[HAMainViewController alloc] init];
//    [self addChildVc:business title:@"首页" image:@"home.png" selectedImage:@""];
//    
//    //分类
//    HAClassifyViewController *classify = [[HAClassifyViewController alloc] init];
//    [self addChildVc:classify title:@"分类" image:@"classify.png" selectedImage:@""];
//    
//    //收藏
//    HACollectViewController *collect = [[HACollectViewController alloc] init];
//    [self addChildVc:collect title:@"收藏" image:@"collect.png" selectedImage:@""];
//    
//    //我的
//    HAMineViewController *mine = [[HAMineViewController alloc] init];
//    [self addChildVc:mine title:@"我的" image:@"mine.png" selectedImage:@""];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    //childVc.tabBarItem.title = @"安心汽车"; // 设置tabbar的文字
    childVc.navigationItem.title = @"安心汽车"; // 设置navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //textAttrs[NSForegroundColorAttributeName] = HAColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    //childVc.view.backgroundColor = HARandomColor;
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    HANavigationController *nav = [[HANavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}


@end

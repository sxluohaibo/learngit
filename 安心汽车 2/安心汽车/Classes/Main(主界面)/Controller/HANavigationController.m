//
//  HANavigationController.m
//  安心汽车
//
//  Created by tusm on 15-3-3.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HANavigationController.h"
#import "HALoveCarViewController.h"

@interface HANavigationController ()

@end

@implementation HANavigationController

+ (void)initialize{
    // 设置整个项目所有item的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 设置普通状态
    // key：NS****AttributeName
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    // 设置不可用状态
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.7];
    
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

/**
 *  重写这个方法目的：能够拦截所有push进来的控制器
 *
 *  @param viewController 即将push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //NSLog(@"viewController == %@",viewController);
    //if (self.viewControllers.count > 0) { // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        /* 自动显示和隐藏tabbar */
        viewController.hidesBottomBarWhenPushed = YES;
        /* 设置导航栏上面的内容 */
        // 设置左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
        // 设置右边的更多按钮
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"user" highImage:@"user"];
//        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more" highImage:@"navigationbar_more_highlighted"];
   // }else{
        //viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(leftAction) image:@"menu" highImage:@"menu"];
        //viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightAction) image:@"user" highImage:@"user"];
        //NSLog(@"sdfsfd == %@",viewController.navigationItem.rightBarButtonItem);
    //}
    //[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forBarMetrics:UIBarMetricsDefault];
    [super pushViewController:viewController animated:animated];
}

//向左测滑
- (void)leftAction{
    [self.viewDeckController toggleLeftView];
}

//向右侧滑
- (void)rightAction{
    [self.viewDeckController toggleRightView];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}


- (void)more{
    //[self popToRootViewControllerAnimated:YES];
    [self.viewDeckController toggleRightView];
}

@end

//
//  MyNavWithoutPanController.m
//  qcsuqianribao
//
//  Created by heartjoy on 14-2-17.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "MyNavWithoutPanController.h"

@interface MyNavWithoutPanController ()

@end

@implementation MyNavWithoutPanController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

//#pragma mark 一个类只会调用一次
//+ (void)initialize
//{
//    // 1.取出设置主题的对象
//    UINavigationBar *navBar = [UINavigationBar appearance];
//    
//    // 2.设置导航栏的背景图片
//    NSString *navBarBg = nil;
//    if (IsIos7) { // iOS7
//        navBarBg = @"navBg_ios7";
//        navBar.tintColor = [UIColor blackColor];
//    } else { // 非iOS7
//        navBarBg = @"navBg";
//        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
//    }
//    [navBar setBackgroundImage:[UIImage imageNamed:navBarBg] forBarMetrics:UIBarMetricsDefault];
//    
//    // 3.标题
//    [navBar setTitleTextAttributes:@{
//                                     UITextAttributeTextColor : [UIColor blackColor]
//                                     }];
//}
//
//#pragma mark 控制状态栏的样式
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleBlackOpaque;
//}
//
//- (BOOL)prefersStatusBarHidden
//{
//    return NO;
//}

//update by ccq  先设置整个应用支持横竖屏（不然的话播放视频会横屏不了），然后对其他页面设置不能横屏
- (BOOL)shouldAutorotate{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return NO;//YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait; //UIInterfaceOrientationMaskAll
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  HAWindowViewController.m
//  安心汽车
//
//  Created by kongw on 15/4/23.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAWindowViewController.h"

@interface HAWindowViewController ()

@end

@implementation HAWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sub_bg.jpg"]];
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if (IsIos7) {
        self.view.userInteractionEnabled = YES;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

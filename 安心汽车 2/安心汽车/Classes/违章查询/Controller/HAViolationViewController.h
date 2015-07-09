//
//  HAViolationViewController.h
//  安心汽车
//
//  Created by kongw on 15/3/20.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HAAddCarViewController.h"

@interface HAViolationViewController : HAWindowViewController<UITableViewDataSource,UITableViewDelegate,HAAddCarViewControllerDelegate>{
    UITableView *violationTableView;
    NSArray *userInputInfoArr;//用户输入的信息
    NSArray *vioInfoArr;//违章汽车的信息
}

@end

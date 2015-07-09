//
//  HAUserSettingViewController.h
//  安心汽车
//
//  Created by un2lock on 15/5/13.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HAUserSettingViewController : HAWindowViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableview;
@end

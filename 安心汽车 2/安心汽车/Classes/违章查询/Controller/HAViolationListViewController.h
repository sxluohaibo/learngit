//
//  HAViolationListViewController.h
//  安心汽车
//
//  Created by kongw on 15/3/25.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullingRefreshTableView.h"

@interface HAViolationListViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *vioInfoListArr;
}

@property (nonatomic, strong) NSString *carType;//车牌
@property (nonatomic, strong) NSString *vioArea;//违章区域
@end

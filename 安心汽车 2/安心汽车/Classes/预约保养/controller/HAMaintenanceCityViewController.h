//
//  HAMaintenanceCityViewController.h
//  安心汽车
//
//  Created by kongw on 15/4/15.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HAMaintenanceCityViewController : HAWindowViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *mcityTableView;
}
@property (nonatomic, strong)NSString *carBrand;//车的品牌
@end

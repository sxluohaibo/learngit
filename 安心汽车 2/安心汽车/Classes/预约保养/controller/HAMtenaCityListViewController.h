//
//  HAMtenaCityListViewController.h
//  安心汽车
//
//  Created by kongw on 15/4/15.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HAMtenaCityListViewController : HAWindowViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *mtenaCityListTableView;
    NSArray *mtenCityListArr;
}

@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) NSString *carBrand_new;//车的品牌
@end

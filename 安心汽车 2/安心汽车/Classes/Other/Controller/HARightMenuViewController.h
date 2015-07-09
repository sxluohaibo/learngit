//
//  HARightMenuViewController.h
//  安心汽车
//
//  Created by 孔伟 on 15/4/19.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HARightMenuViewController : HAWindowViewController<UITableViewDelegate,UITableViewDataSource>{
    UITableView *rightTableView;
    NSArray *rightArr;
    UIImageView *rightBk;//右边的背景图
}

@end

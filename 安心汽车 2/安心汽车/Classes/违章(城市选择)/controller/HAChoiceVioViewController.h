//
//  HAChoiceVioViewController.h
//  安心汽车
//
//  Created by kongw on 15/3/24.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HAChoiceVioViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    UITableView *choiceViolationTableView;
    NSArray *proviceAndCitys;
}

@property (nonatomic ,strong) NSArray *choiceListArr;

@end

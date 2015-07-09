//
//  HA4STableViewCell.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/28.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HA4sFrame;

@interface HA4STableViewCell : UITableViewCell


@property(nonatomic,strong)HA4sFrame * item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

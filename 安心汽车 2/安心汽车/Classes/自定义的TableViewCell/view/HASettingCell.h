//
//  HASettingCell.h
//  华奥移动
//
//  Created by tusm on 15-3-4.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HASettingItem;
@interface HASettingCell : UITableViewCell
@property (nonatomic, strong) HASettingItem *item;

+ (id)settingCellWithTableView:(UITableView *)tableView;
@end

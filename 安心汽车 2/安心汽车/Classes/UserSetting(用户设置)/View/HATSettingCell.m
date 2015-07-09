//
//  HATSettingCell.m
//  安心汽车
//
//  Created by un2lock on 15/5/14.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HATSettingCell.h"

@implementation HATSettingCell
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView setFrame:CGRectMake(10, 10,20, 20)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}


@end

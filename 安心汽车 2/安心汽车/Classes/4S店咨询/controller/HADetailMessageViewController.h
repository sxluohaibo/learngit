//
//  HADetailMessageViewController.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/29.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  咨询详情界面

#import <UIKit/UIKit.h>

@interface HADetailMessageViewController : HAWindowViewController

@property(nonatomic,assign) NSInteger newId;

+ (HADetailMessageViewController *) Message:(NSInteger)newId;

@end

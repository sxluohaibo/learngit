//
//  HADuty.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/17.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HADuty : NSObject


@property(nonatomic,copy)NSString * title;

@property(nonatomic,copy)NSString * icon;



+(instancetype)dutyWithTitle:(NSString *)title iconName:(NSString *) iconName;

- (instancetype)initWithTitle:(NSString *)title iconName:(NSString *) iconName;

@end

//
//  HADuty.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/17.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HADuty.h"

@implementation HADuty



+(instancetype)dutyWithTitle:(NSString *)title iconName:(NSString *) iconName
{
    
    HADuty * duty = [[HADuty alloc] init];
    duty.title = title;
    duty.icon = iconName;
    
    return duty;

}

- (instancetype)initWithTitle:(NSString *)title iconName:(NSString *) iconName
{
    
    
    return [HADuty dutyWithTitle:title iconName:iconName];
    
}
@end

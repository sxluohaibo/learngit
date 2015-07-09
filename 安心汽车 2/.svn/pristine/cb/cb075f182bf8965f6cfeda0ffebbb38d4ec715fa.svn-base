//
//  HAUserDefaultTool.m
//  安心汽车
//
//  Created by un2lock on 15/4/13.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAUserDefaultTool.h"

@implementation HAUserDefaultTool
+(void)saveValueWith:(NSString *)key Andvalue:(NSString *) value{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:value forKey:key];
    [ud synchronize];
}
+(NSString *) getValueWithKey:(NSString *) key{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *value=[ud objectForKey:key];
    return value;
}
@end

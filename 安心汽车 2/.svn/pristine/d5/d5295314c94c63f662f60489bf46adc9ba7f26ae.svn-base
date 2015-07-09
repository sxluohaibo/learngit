//
//  HAUserDefalutTool.m
//  安心汽车
//
//  Created by un2lock on 15/3/22.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAUserDefalutTool.h"

@implementation HAUserDefalutTool
+(void) saveWithkey:(NSString *) key andValue:(NSString *) value{
    NSUserDefaults *defalut=[NSUserDefaults standardUserDefaults];
    [defalut setObject:value forKey:key];
    [defalut synchronize];
}
+(NSString *) objectForKey:(NSString *) key{
    NSUserDefaults *defalut=[NSUserDefaults standardUserDefaults];
    NSString *value=[defalut objectForKey:key];
    if(value!=nil && value.length>0){
        return value;
    }
    return nil;
}
@end

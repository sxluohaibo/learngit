
//
//  HACarClass.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/15.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACarClass.h"

@implementation HACarClass



+ (instancetype)carClassYeadWithDict:(NSDictionary *)dict
{
    HACarClass * carclass = [[self alloc] init];
    carclass.yearId = [dict[@"yearId"] integerValue];
    carclass.specialName = dict[@"specialName"];
    carclass.yearId = [dict[@"yearsId"] integerValue];
    carclass.month = dict[@"month"];
    return carclass;
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    return [HACarClass carClassYeadWithDict:dict];
    
    
}

+ (NSMutableArray*)carClassYeadWithDictArray:(NSArray *)dictArray
{
    NSMutableArray * array = [NSMutableArray array];
    [dictArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [array addObject:[self carClassYeadWithDict:obj]];
    }];
    
    return array;
}

@end

//
//  HACarYear.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/15.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  车辆年份

#import "HACarYear.h"

@implementation HACarYear




+ (instancetype)carYeadWithDict:(NSDictionary *)dict
{
    HACarYear * year = [[self alloc] init];
    year.yearId = [dict[@"yearId"] integerValue];
    year.seriesId = [dict[@"seriesId"] integerValue];
    year.year = dict[@"year"];
    
    return year;
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
   return [HACarYear carYeadWithDict:dict];
    

}

+ (NSMutableArray*)carYeadWithDictArray:(NSArray *)dictArray
{
    NSMutableArray * array = [NSMutableArray array];
    [dictArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        [array addObject:[self carYeadWithDict:obj]];
    }];
    
    return array;
}


//- (NSMutableArray *)initWithDictArray:(NSArray *)dictArray
//{
//    return [HACarYear carYeadWithDictArray:dictArray];
//}

@end

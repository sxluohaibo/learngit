//
//  HAViolationProvicePrameResult.m
//  安心汽车
//
//  Created by 罗海波 on 15/3/24.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAViolationProvicePrameResult.h"
#import "HAViolationCitysParameResult.h"

@implementation HAViolationProvicePrameResult


-(NSDictionary*)objectClassInArray{
    return @{@"citys" : [HAViolationCitysParameResult class]};
}

@end

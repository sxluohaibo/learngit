//
//  HACarBrandGroup.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/14.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACarBrandGroup.h"
#import "HACarBrand.h"
@implementation HACarBrandGroup
@synthesize carBrands;

- (id)init{
    self = [super init];
    if (self) {
        carBrands = [[NSMutableArray alloc] init];
    }
    return self;
}
- (NSDictionary *)objectClassInArray
{
    return @{@"carBrands":[HACarBrand class]};
}


@end

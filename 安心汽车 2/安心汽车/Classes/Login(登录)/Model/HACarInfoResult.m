//
//  HACarInfoResult.m
//  安心汽车
//
//  Created by kongw on 15/4/21.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACarInfoResult.h"

@implementation HACarInfoResult
@synthesize carResult;

-(NSDictionary *)objectClassInArray{
    return @{@"carInfo":[HACarResult class]};
}

@end

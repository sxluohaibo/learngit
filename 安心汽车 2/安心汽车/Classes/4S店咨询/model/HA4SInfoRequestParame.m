//
//  HA4SInfoRequestParame.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/27.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HA4SInfoRequestParame.h"

@implementation HA4SInfoRequestParame



+ (instancetype)InfoRequestParameWithpartnerCode:(NSString *)partnerCode andStartIndex:(NSNumber*)startIndex andPageSize:(NSNumber*)pageSize{
    HA4SInfoRequestParame * parame =  [[self alloc] init];
    parame.partnerCode = [partnerCode copy];
    parame.startIndex = startIndex;
    parame.pageSize = pageSize;
    return parame;
}

- (instancetype)initWithPartnerCode:(NSString *)partnerCode andStartIndex:(NSNumber*)startIndex andPageSize:(NSNumber*)pageSize{
   return  [HA4SInfoRequestParame InfoRequestParameWithpartnerCode:partnerCode andStartIndex:startIndex andPageSize:pageSize];
}

@end

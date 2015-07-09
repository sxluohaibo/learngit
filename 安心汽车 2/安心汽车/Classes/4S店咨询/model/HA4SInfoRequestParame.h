//
//  HA4SInfoRequestParame.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/27.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HA4SInfoRequestParame : NSObject

/**合作商编号*/
@property(nonatomic,copy) NSString* partnerCode;

/**设置结果集的起始查询位置*/
@property(nonatomic,strong) NSNumber* startIndex;

/**newsId-该资讯最后编辑时间*/
@property(nonatomic,strong) NSNumber* pageSize;



+ (instancetype)InfoRequestParameWithpartnerCode:(NSString *)partnerCode andStartIndex:(NSNumber*)startIndex andPageSize:(NSNumber*)pageSize;

- (instancetype)initWithPartnerCode:(NSString *)partnerCode andStartIndex:(NSNumber*)startIndex andPageSize:(NSNumber*)pageSize;

@end

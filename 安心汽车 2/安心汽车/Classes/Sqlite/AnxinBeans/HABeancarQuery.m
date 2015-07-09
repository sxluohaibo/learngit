//
//  HABeancarQuery.m
//  安心汽车
//
//  Created by kongw on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HABeancarQuery.h"
static HABeancarQuery *shareCarQuery = nil;
@implementation HABeancarQuery

+ (HABeancarQuery *)shareCarQuery{
    if (!shareCarQuery) {
        shareCarQuery = [[HABeancarQuery alloc] init];
    }
    return shareCarQuery;
}

//插入数据
- (HAViolationProvicePrameResult *)addProvinceData:(HAViolationProvicePrameResult *)provinceData{
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO %@ (province) VALUES ('%@')",province_DB ,provinceData.province];
    LOG(@"sql %@",sql);
    if([self openDatabase]){
        [db beginTransaction];
        [db executeUpdate:sql];
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }else{
            //NSLog(@"插入成功!");
        }
        [db commit];
        [self closeDatabase];
    }
    return provinceData;
}
@end

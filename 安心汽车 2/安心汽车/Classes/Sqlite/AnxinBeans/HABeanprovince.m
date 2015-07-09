//
//  HABeanprovince.m
//  安心汽车
//
//  Created by kongw on 15/4/2.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HABeanprovince.h"
static HABeanprovince *shareProvince = nil;

@implementation HABeanprovince

+ (HABeanprovince *)shareBeanProvince{
    if (!shareProvince) {
        shareProvince = [[HABeanprovince alloc] init];
    }
    return shareProvince;
}

- (NSMutableArray *)getProvinceArr{
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM %@",province_DB];
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    if([self openDatabase]){
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            HAViolationProvicePrameResult *provinceModel = [[HAViolationProvicePrameResult alloc] init];
            provinceModel.province = [rs stringForColumn:@"province"];
            provinceModel.province_code = [rs stringForColumn:@"province_code"];
            [result addObject:provinceModel];
        }
        [rs close];
        [self closeDatabase];
    }
    LOG(@"result count %d",[result count]);
    return result;
}

//插入数据
- (HAViolationProvicePrameResult *)addProvinceData:(HAViolationProvicePrameResult *)provinceData{
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO %@ (province,province_code) VALUES ('%@','%@')",province_DB ,provinceData.province,provinceData.province_code];
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

- (void)removeVioDB{
    NSString * sql = [NSString stringWithFormat:@"DELETE FROM %@", province_DB];
    if([self openDatabase]){
        [db beginTransaction];
        [db executeUpdate:sql];
        if ([db hadError]) {
            LOG(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }else{
            NSLog(@"删除成功!");
        }
        [db commit];
        [self closeDatabase];
    }
}

- (BOOL)isProViceArr{
    NSArray *proviceArr = [self getProvinceArr];
    if (proviceArr != nil && ![proviceArr isKindOfClass:[NSNull class]] && proviceArr.count != 0) {
        return YES;
    }
    return NO;
}
@end

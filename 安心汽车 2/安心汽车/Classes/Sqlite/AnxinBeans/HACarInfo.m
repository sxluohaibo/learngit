//
//  HACarInfo.m
//  安心汽车
//
//  Created by un2lock on 15/4/16.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACarInfo.h"
#import "HACarResult.h"
static HACarInfo *shareInfo = nil;
@implementation HACarInfo

//单列
+ (HACarInfo *)shareCarInfo{
    if (!shareInfo) {
        shareInfo = [[HACarInfo alloc] init];
    }
    return shareInfo;
}

//返回延保用户车的数据模型
- (HACarInfoResult *)checkOneUserNO:(NSString *)userNO{
    NSString * sql = [NSString stringWithFormat:@"select * from yxbaoyang_DB where userNO = \"%@\"",userNO];
    HACarResult *carModel = [[HACarResult alloc] init];
    HACarInfoResult *info = [[HACarInfoResult alloc] init];
    if([self openDatabase]){
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            carModel.carNo = [rs stringForColumn:@"carNo"];
            carModel.carbuyDate = [rs stringForColumn:@"carbuyDate"];
            carModel.partnerID = [rs stringForColumn:@"partnerID"];
            carModel.partnerName = [rs stringForColumn:@"partnerName"];
            carModel.address = [rs stringForColumn:@"address"];
            carModel.partnerLocation = [rs stringForColumn:@"partnerLocation"];
            carModel.carBand = [rs stringForColumn:@"carBand"];
        }
        [rs close];
        [self closeDatabase];
    }
    LOG(@"result count %d",[result count]);
    info.carResult = carModel;
    return info;
}

//插入数据
- (void)addCarInfoData:(HACarInfoResult *)carInfo andUserNo:(NSString *)userNo{
    HACarInfoResult *carInfoReult = carInfo;
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO %@ (userNO, carNo,carbuyDate,partnerID,partnerName,address,partnerLocation,carBand) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@')",yxbaoyang_DB ,userNo,carInfoReult.carResult.carNo,carInfoReult.carResult.carbuyDate,carInfoReult.carResult.partnerID,carInfoReult.carResult.partnerName,carInfoReult.carResult.address,carInfoReult.carResult.partnerLocation,carInfoReult.carResult.carBand];
    LOG(@"sql %@",sql);
    if([self openDatabase]){
        [db beginTransaction];
        [db executeUpdate:sql];
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }else{
            NSLog(@"当前数据-----插入成功!");
        }
        [db commit];
        [self closeDatabase];
    }
}
/**
 *  删除数据
 */
- (void)removeDB{
    NSString * sql = [NSString stringWithFormat:@"DROP TABLE %@", yxbaoyang_DB];
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

@end

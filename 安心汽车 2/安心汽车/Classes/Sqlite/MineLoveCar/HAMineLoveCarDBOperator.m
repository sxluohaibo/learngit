//
//  HAMineLoveCarDBOperator.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/27.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  我的爱车数据库分装

#import "HAMineLoveCarDBOperator.h"
#import "FMDB.h"
#import "HALoveCarModel.h"



//数据库实力对象
static FMDatabaseQueue * _dbqueue;;

@implementation HAMineLoveCarDBOperator

+ (void)initialize
{
    //获取沙河路径
    NSString * fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:AnXinQiCheDB];
   
    //创建数据库实力对象
    _dbqueue = [FMDatabaseQueue databaseQueueWithPath:fileName];
    
    [_dbqueue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"create table if not exists t_carport (id integer primary key autoincrement,LoginUserNo text,ServerTime text,city text,carType text,carInfo text,carmileage text,DateText text,carNumber text,carframe text,engineNumber text,isCooperation BOOL);"];
        
    }];
}

/**
 * 建表
 */
+ (BOOL)CreateTableFMDBWithSql:(NSString *)sqlStr
{
    __block BOOL result = NO;
    [_dbqueue inDatabase:^(FMDatabase *db) {
        
        result = [db executeUpdate:(sqlStr?sqlStr:@"create table if not exists t_carport (id integer primary key autoincrement,LoginUserNo text,ServerTime text,city text,carType text,carInfo text,carmileage text,DateText text,carNumber text,carframe text,engineNumber text,isCooperation BOOL);")];
        
    }];
    return result;
}

/**
 * 插入数据库
 */
+ (BOOL)insertIntoFMDBWithSql:(NSString *)sqlStr{
    __block BOOL result = NO;
    [_dbqueue inDatabase:^(FMDatabase *db) {
        
        result = [db executeUpdate:sqlStr];
        
    }];
    return result;
}

/**
 * 修改数据库
 */
+ (BOOL)updateFMDBWithSql:(NSString *)sqlStr
{
    __block BOOL result = NO;
    [_dbqueue inDatabase:^(FMDatabase *db) {
        
        result = [db executeUpdate:sqlStr];
        
    }];
    return result;
}

/**
 * 删除数据库
 */
+ (BOOL)deleteFMDBWithSql:(NSString *)sqlStr
{
    __block BOOL result = NO;
    [_dbqueue inDatabase:^(FMDatabase *db) {
        
        result = [db executeUpdate:sqlStr];
    }];
    return result;
}

/**
 * 查询某个车牌是否存在
 */
+ (BOOL)exqueryFMDBWithCondition:(NSString *)loginno andCarNumber:(NSString *)carNumber{
    NSString * sqlStr = [NSString stringWithFormat:@"select * from t_carport where LoginUserNo = '%@' and carNumber = '%@';",loginno,carNumber];
    __block BOOL have = NO;
  
    [_dbqueue inDatabase:^(FMDatabase *db) {
       FMResultSet * rs =  [db executeQuery:sqlStr];
        if ([rs next]) {
            have = YES;
        }
        [rs close];
    }];
    return have;
}


/**
 * 查询数据数据库
 */
+ (NSArray *)exqueryFMDBWithSql:(NSString *)loginno{
    __block NSArray * resultArray = [NSArray array];
//    NSString * userNO = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo];
    NSString * sqlSql = nil;
    if (loginno) {
        sqlSql = [[NSString stringWithFormat:@"select * from  t_carport where LoginUserNo = '%@' order by id desc",loginno] copy];
        NSLog(@"dadasdasdasdasdasd%@",sqlSql);
    }else{
        sqlSql = @"select * from  t_carport order by id desc";
    }
     NSMutableArray * loveCarArray = [NSMutableArray array];
    
    [_dbqueue inDatabase:^(FMDatabase *db) {
        
        FMResultSet * rs = [db executeQuery:sqlSql];
        if (rs) {
            while (rs.next) {
                HALoveCarModel * loveCar = [[HALoveCarModel alloc] init];
                loveCar.Did = [rs intForColumn:@"id"];
                loveCar.city = [[rs stringForColumn:@"city"] copy];
                loveCar.carType = [[rs stringForColumn:@"carType"] copy];
                loveCar.carinfo = [[rs stringForColumn:@"carInfo"] copy];
                loveCar.mileageText = [[rs stringForColumn:@"carmileage"] copy];
                loveCar.DateText = [[rs stringForColumn:@"DateText"] copy];
                loveCar.carNumber = [[rs stringForColumn:@"carNumber"] copy];
                loveCar.carframe = [[rs stringForColumn:@"carframe"] copy];
                loveCar.engineNumber = [[rs stringForColumn:@"engineNumber"] copy];
                loveCar.serverTime =  [[rs stringForColumn:@"ServerTime"] copy];
                loveCar.isVip =  [rs boolForColumn:@"isCooperation"];
                [loveCarArray addObject:loveCar];
            }
        }
       [rs close];
    }];
    
    if (loveCarArray.count) {
        
        resultArray = loveCarArray;
        return resultArray;
    }
    return nil;
}



/**
 * 是否是延保用户的车辆
 */
+ (NSArray *)getLoveCarModel:(BOOL)isCooperation{
    __block NSArray * resultArray = [NSArray array];
    NSString * sqlSql = nil;
    sqlSql = [[NSString stringWithFormat:@"select * from  t_carport where isCooperation = '%d' order by id desc",isCooperation] copy];
    NSLog(@"是否是延保用户的车辆 == %@",sqlSql);
    NSMutableArray * loveCarArray = [NSMutableArray array];
    [_dbqueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:sqlSql];
        if (rs) {
            while (rs.next) {
                HALoveCarModel * loveCar = [[HALoveCarModel alloc] init];
                loveCar.Did = [rs intForColumn:@"id"];
                loveCar.city = [[rs stringForColumn:@"city"] copy];
                loveCar.carType = [[rs stringForColumn:@"carType"] copy];
                loveCar.carinfo = [[rs stringForColumn:@"carInfo"] copy];
                loveCar.mileageText = [[rs stringForColumn:@"carmileage"] copy];
                loveCar.DateText = [[rs stringForColumn:@"DateText"] copy];
                loveCar.carNumber = [[rs stringForColumn:@"carNumber"] copy];
                loveCar.carframe = [[rs stringForColumn:@"carframe"] copy];
                loveCar.engineNumber = [[rs stringForColumn:@"engineNumber"] copy];
                loveCar.serverTime =  [[rs stringForColumn:@"ServerTime"] copy];
                loveCar.isVip =  [rs boolForColumn:@"isCooperation"];
                [loveCarArray addObject:loveCar];
            }
        }
        [rs close];
    }];
    if (loveCarArray.count) {
        resultArray = loveCarArray;
        return resultArray;
    }
    return nil;
}


+ (void)closeDMDB
{
    [_dbqueue inDatabase:^(FMDatabase *db) {
        [db close];
    }];
}
@end

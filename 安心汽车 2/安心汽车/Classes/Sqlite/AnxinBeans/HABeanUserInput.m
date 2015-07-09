//
//  HABeanUserInput.m
//  安心汽车
//
//  Created by kongw on 15/4/21.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HABeanUserInput.h"
#import "HAMineLoveCarDBOperator.h"

static HABeanUserInput *shareInput = nil;
@implementation HABeanUserInput

+ (HABeanUserInput *)shareUserInput{
    if (!shareInput) {
        shareInput = [[HABeanUserInput alloc] init];
    }
    return shareInput;
}


- (NSMutableArray *)getUserInputArr:(NSString *)userNO{
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM %@ where userNO = '%@'",Vio_UserInputData,userNO];
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    if([self openDatabase]){
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            HAUserInputModel *input = [[HAUserInputModel alloc] init];
            input.vioArea = [rs stringForColumn:@"vioArea"];
            input.carTypeNumber = [rs stringForColumn:@"carTypeNumber"];
            input.classNumber = [rs stringForColumn:@"classNumber"];
            input.engineNumber = [rs stringForColumn:@"engineNumber"];
            input.registNumber = [rs stringForColumn:@"registNumber"];
            input.remarkNumber = [rs stringForColumn:@"remarkNumber"];
            input.carTypeShort = [rs stringForColumn:@"carTypeShort"];
            input.userNO = [rs stringForColumn:@"userNO"];
            [result addObject:input];
        }
        [rs close];
        [self closeDatabase];
    }
    LOG(@"result count %d",[result count]);
    return result;
}


- (HAUserInputModel *)addUserInfoData:(HAUserInputModel *)userInfo{
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO %@ (vioArea,carTypeNumber,carTypeShort,classNumber,engineNumber,registNumber,remarkNumber,userNO) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@')",Vio_UserInputData,userInfo.vioArea,userInfo.carTypeNumber,userInfo.carTypeShort,userInfo.classNumber,userInfo.engineNumber,userInfo.registNumber,userInfo.remarkNumber,userInfo.userNO];
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
    return userInfo;
}

//根据车牌取数据
- (HAUserInputModel *)getUserInfoData:(NSString *)carType{
    NSString * sql = [NSString stringWithFormat:@"select * from Vio_UserInputData where carTypeNumber = \"%@\"",carType];
    HAUserInputModel *infoData = [[HAUserInputModel alloc] init];
    if([self openDatabase]){
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            infoData.vioArea = [rs stringForColumn:@"vioArea"];
            infoData.carTypeNumber = [rs stringForColumn:@"carTypeNumber"];
            infoData.carTypeShort = [rs stringForColumn:@"carTypeShort"];
            infoData.classNumber = [rs stringForColumn:@"classNumber"];
            infoData.engineNumber = [rs stringForColumn:@"engineNumber"];
            infoData.registNumber = [rs stringForColumn:@"registNumber"];
            infoData.remarkNumber = [rs stringForColumn:@"remarkNumber"];
            infoData.userNO = [rs stringForColumn:@"userNO"];
        }
        [rs close];
        [self closeDatabase];
    }
    LOG(@"result count %d",[result count]);
    return infoData;
}

//根据车牌更新数据
- (void)upDataUserInfoData:(HAUserInputModel *)inputModel{
    NSString *sql = [NSString stringWithFormat:@"UPDATE Vio_UserInputData set vioArea = '%@' ,carTypeNumber = '%@' ,carTypeShort = '%@',classNumber ='%@', engineNumber= '%@', registNumber='%@',remarkNumber='%@',userNO='%@' where carTypeNumber = '%@';",inputModel.vioArea,inputModel.carTypeNumber,inputModel.carTypeShort,inputModel.classNumber,inputModel.engineNumber,inputModel.registNumber,inputModel.remarkNumber,inputModel.carTypeNumber,inputModel.userNO];
    NSLog(@"sql == %@",sql);
    if([self openDatabase]){
        [db beginTransaction];
        [db executeUpdate:sql];
        if ([db hadError]) {
            NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }else{
            NSLog(@"插入成功!");
        }
        [db commit];
        [self closeDatabase];
    }
}

- (void)removeDB{
    NSString * sql = [NSString stringWithFormat:@"DELETE FROM %@", Vio_UserInputData];
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

//根据车牌删除数据
- (BOOL)deleteInputDB:(NSString *)carType{
    NSString * sql = [NSString stringWithFormat:@"delete from Vio_UserInputData where carTypeNumber = '%@'",carType];
    db.logsErrors =YES;
    if([self openDatabase]){
        [db executeUpdate:sql];
        if ([db hadError]) {
            LOG(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }else{
            [ApplicationDelegate.store deleteObjectById:carType fromTable:VioResultDB];//删掉信息
            NSLog(@"删除成功!");
            return YES;
        }
        [self closeDatabase];
    }
    return YES;
}

- (BOOL)whetherUserCarType:(NSString *)carType{
    NSString * sql = [NSString stringWithFormat:@"select * from Vio_UserInputData where carTypeNumber = '%@'",carType];
    BOOL type;
    if([self openDatabase]){
        FMResultSet *rs = [db executeQuery:sql];
        NSLog(@"rs == %d",[rs next]);
        type = [rs next];
    }
    [self closeDatabase];
    return type;
}
@end

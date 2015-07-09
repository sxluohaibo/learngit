//
//  HABeancity.m
//  安心汽车
//
//  Created by kongw on 15/4/2.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HABeancity.h"
static HABeancity *shareCity = nil;
@implementation HABeancity

+ (HABeancity *)shareBeanCity{
    if (!shareCity) {
        shareCity = [[HABeancity alloc] init];
    }
    return shareCity;
}

- (NSMutableArray *)getCityArr{
    NSString * sql = [NSString stringWithFormat:@"SELECT * FROM %@",city_DB];
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    if([self openDatabase]){
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            HAViolationCitysParameResult *cityModel = [[HAViolationCitysParameResult alloc] init];
            cityModel.city_name = [rs stringForColumn:@"city_name"];
            cityModel.city_code = [rs stringForColumn:@"city_code"];
            
            NSString *code = [rs stringForColumn:@"city_code"];
            NSString *provice_code = nil;
            if ([HAManger HAReplaceString:code excuseString:@"_"]) {
                NSArray *codeArr = [code componentsSeparatedByString:@"-"];
                provice_code = [codeArr objectAtIndex:0];
            }else{
                provice_code = code;
            }
            cityModel.province_code = provice_code;
            cityModel.abbr = [rs stringForColumn:@"abbr"];
            cityModel.engine = [rs boolForColumn:@"engine"];
            cityModel.engineno = [[rs stringForColumn:@"engineno"] integerValue];
            cityModel.classa = [rs boolForColumn:@"classa"];
            cityModel.classno = [[rs stringForColumn:@"classno"] integerValue];
            cityModel.regist = [rs boolForColumn:@"regist"];
            cityModel.registno = [[rs stringForColumn:@"registno"] integerValue];
            [result addObject:cityModel];
        }
        [rs close];
        [self closeDatabase];
    }
    LOG(@"result count %d",[result count]);
    return result;
}

-(NSMutableArray *)readCityfrom:(NSString *)pcode{
    NSString * sql = [NSString stringWithFormat:@"select city_DB.city_name from province_DB ,city_DB where province_DB.province_code = city_DB.province_code and province_DB.province_code=%@;",pcode];
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:0];
    if([self openDatabase]){
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            NSString *name = [rs stringForColumn:@"city_name"];
            [result addObject:name];
        }
        [rs close];
        [self closeDatabase];
    }
    LOG(@"result count %d",[result count]);
    return result;
}

- (HAViolationCitysParameResult *)addCityData:(HAViolationCitysParameResult *)provinceData{
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO %@ (city_name,city_code,province_code,abbr,engine,engineno,classa,classno,regist,registno) VALUES ('%@','%@','%@','%@','%d','%ld','%d','%ld','%d','%ld')",city_DB ,provinceData.city_name,provinceData.city_code,provinceData.province_code,provinceData.abbr,provinceData.engine,(long)provinceData.engineno,provinceData.classa,(long)provinceData.classno,provinceData.regist,(long)provinceData.registno];
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
    NSString * sql = [NSString stringWithFormat:@"DELETE FROM %@",city_DB];
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

//返回某一天的数据模型
- (HAViolationCitysParameResult *)checkOneCityData:(NSString *)cityName{
    NSString *city_name = [NSString stringWithFormat:@"select * from city_DB where city_name = \"%@\"",cityName];
    NSString * sql = city_name;
    HAViolationCitysParameResult *cityModel = [[HAViolationCitysParameResult alloc] init];
    if([self openDatabase]){
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            cityModel.city_name = [rs stringForColumn:@"city_name"];
            cityModel.city_code = [rs stringForColumn:@"city_code"];
            
            NSString *code = [rs stringForColumn:@"city_code"];
            NSString *provice_code = nil;
            if ([HAManger HAReplaceString:code excuseString:@"_"]) {
                NSArray *codeArr = [code componentsSeparatedByString:@"-"];
                provice_code = [codeArr objectAtIndex:0];
            }else{
                provice_code = code;
            }
            cityModel.province_code = provice_code;
            cityModel.abbr = [rs stringForColumn:@"abbr"];
            cityModel.engine = [rs boolForColumn:@"engine"];
            cityModel.engineno = [[rs stringForColumn:@"engineno"] integerValue];
            cityModel.classa = [rs boolForColumn:@"classa"];
            cityModel.classno = [[rs stringForColumn:@"classno"] integerValue];
            cityModel.regist = [rs boolForColumn:@"regist"];
            cityModel.registno = [[rs stringForColumn:@"registno"] integerValue];
        }
        [rs close];
        [self closeDatabase];
    }
    LOG(@"result count %d",[result count]);
    return cityModel;
    
}
@end

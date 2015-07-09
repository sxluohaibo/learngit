//
//  HASaveInfoByFMDB.m
//  安心汽车
//
//  Created by 罗海波 on 15/3/30.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HASaveInfoByFMDB.h"
#import "FMDB.h"

@implementation HASaveInfoByFMDB


static FMDatabaseQueue * _queue;
+(void)initialize{
    _queue = [FMDatabaseQueue databaseQueueWithPath:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"db"]];

}

+ (NSMutableArray *)readProvincefrom{
    __block NSMutableArray *proviceArr = [[NSMutableArray alloc] init];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:@"select * from province;"];
        while (rs.next) {
            __block HAProvinceModel *province = [[HAProvinceModel alloc] init];
            NSString *name = [[NSString alloc] initWithCString:(const char*)[rs UTF8StringForColumnName:@"name"] encoding:-2147482062];
            NSString *code = [rs stringForColumn:@"code"];
            province.name = name;
            province.code = code;
            if ([province.name isEqualToString:@"香港"] || [province.name isEqualToString:@"澳门"] || [province.name isEqualToString:@"上海市"]) {
                
            }else{
                [proviceArr addObject:province];
            }
        }
    }];
    return proviceArr;
}

+ (NSMutableArray *)readCityfrom:(NSString *)pcode{
    __block NSMutableArray *proviceArr = [[NSMutableArray alloc] init];
    [_queue inDatabase:^(FMDatabase *db) {
        proviceArr = [NSMutableArray array];
        FMResultSet * rs = [db executeQuery:@"select city.name from city ,province where province.code = city.pcode and province.code=?;",pcode];
        while (rs.next) {
            NSString *name = [[NSString alloc] initWithCString:(const char*)[rs UTF8StringForColumnName:@"name"] encoding:-2147482062];
            [proviceArr addObject:name];
        }
    }];
    return proviceArr;
}
@end

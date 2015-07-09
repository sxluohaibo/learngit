//
//  HABaseAnxin.m
//  安心汽车
//
//  Created by kongw on 15/3/30.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HABaseAnxin.h"

@implementation HABaseAnxin
@synthesize db;

+ (void)initialize{
    
}

- (id)init{
    self = [super init];
    if (self) {
        BOOL success;
        NSFileManager *fm = [NSFileManager defaultManager];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *SQDbPath = @"";
        SQDbPath =  ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        NSString *writableDBPath = [SQDbPath stringByAppendingPathComponent:@"AnXinQiChe.db"];
        //NSString *writableDBPath = [NSString stringWithFormat:@"/Users/kongw/desktop/%@",@"AnXinQiChe.db"];
        NSLog(@"writableDBPath %@",writableDBPath);
        success = [fm fileExistsAtPath:writableDBPath];
        //NSLog(@"success == %d",success);
        if(!success){
            NSLog(@"open db file error ");
            [fm createFileAtPath:writableDBPath contents:nil attributes:nil];
            /*
             NSString *vioLoaction;          //违章区域
             NSString *carType;              //车牌号
             NSString *carengine;            //发动机号
             NSString *carclass;             //机架号
             NSString *carregister;            //注册号
             NSString *cardescription;          //备注
             */
            NSString *proviceDB = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer primary key autoincrement,province TEXT,province_code TEXT) ", province_DB];
            NSString *cityDb = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer primary key autoincrement,city_name TEXT,city_code TEXT,province_code TEXT,abbr TEXT, engine integer,engineno TEXT,classa integer,classno TEXT,regist integer,registno TEXT) ", city_DB];

            NSString *carQueryDB = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer primary key autoincrement,province TEXT) ", car_Query_DB];
            
            NSString *yxbaoyangDB = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer primary key autoincrement,userNo TEXT,carNo TEXT,carbuyDate TEXT,partnerID TEXT,partnerName TEXT,address TEXT,partnerLocation TEXT,carBand TEXT) ", yxbaoyang_DB];  //预约车辆
            //userAccount,userName,phoneCode,isLogin
            NSString *LoginUserDB = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer primary key autoincrement,userNo TEXT,userName TEXT,userPassWord TEXT) ", LoginUser_DB];  //用户信息
            
           NSString *vioInputDB = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer primary key autoincrement,vioArea TEXT,carTypeNumber TEXT,carTypeShort TEXT,classNumber TEXT,engineNumber TEXT,registNumber TEXT,remarkNumber TEXT,userNO TEXT) ",Vio_UserInputData];  //用户信息
            
            db = [FMDatabase databaseWithPath:writableDBPath];
            // integer primary key autoincrement
            if([self openDatabase] == YES){
                [db executeUpdate:proviceDB];//省
                [db executeUpdate:cityDb];//城市表
                [db executeUpdate:yxbaoyangDB];//预约车辆
                [db executeUpdate:LoginUserDB];
                [db executeUpdate:carQueryDB];//车辆查询表
                [db executeUpdate:vioInputDB];//用户输入车辆查询的数据
                if ([db hadError]) {
                    LOG(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
                }
                [self closeDatabase];
            }
        }
        else
            db = [FMDatabase databaseWithPath:writableDBPath];
        if ([db hadError]) {
            LOG(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
        }
        [self closeDatabase];
    }
    return self;
}

-(BOOL)openDatabase{
    if(db!=nil && [db open] ==YES){
        [db setShouldCacheStatements:YES];
        return YES;
    }else{
        LOG(@"Could not open db.");
        return	NO;
    }
}

-(void)closeDatabase{
    if(db!=nil)
        [db close];
}
@end

//
//  HACarInfo.h
//  安心汽车
//
//  Created by un2lock on 15/4/16.
//  Copyright (c) 2015年 ywkj. All rights reserved.
// 登录时车辆信息

#import "HABaseAnxin.h"
#import "HACarInfoResult.h"

@class HACarResult;

@interface HACarInfo:HABaseAnxin

+ (HACarInfo *)shareCarInfo;
- (void)addCarInfoData:(HACarInfoResult *)carInfo andUserNo:(NSString *)userNo;
- (HACarInfoResult *)checkOneUserNO:(NSString *)userNO;//得到其中的某一条数据
- (void)removeDB;

@end

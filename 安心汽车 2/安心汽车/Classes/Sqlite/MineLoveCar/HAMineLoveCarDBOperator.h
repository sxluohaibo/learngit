//
//  HAMineLoveCarDBOperator.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/27.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HALoveCarModel.h"

@interface HAMineLoveCarDBOperator : NSObject



/**
 * 插入数据库
 */
+ (BOOL)insertIntoFMDBWithSql:(NSString *)sqlStr;


/**
 * 修改数据库
 */
+ (BOOL)updateFMDBWithSql:(NSString *)sqlStr;



/**
 * 删除数据库
 */
+ (BOOL)deleteFMDBWithSql:(NSString *)sqlStr;


/**
 * 根据用户标号查车辆
 */
+ (NSArray *)exqueryFMDBWithSql:(NSString *)sqlStr;


/**
 * 是否是延保用户的车辆
 */
+ (NSArray *)getLoveCarModel:(BOOL)isCooperation;


/**
 * 关闭数据数据库
 */
+ (void)closeDMDB;


/**
 * 查询某个车牌是否存在
 */
+ (BOOL)exqueryFMDBWithCondition:(NSString *)loginno andCarNumber:(NSString *)carNumber;
@end

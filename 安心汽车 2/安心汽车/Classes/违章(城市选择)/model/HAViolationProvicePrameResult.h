//
//  HAViolationProvicePrameResult.h
//  安心汽车
//
//  Created by 罗海波 on 15/3/24.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  支持查寻

#import <Foundation/Foundation.h>

@interface HAViolationProvicePrameResult : NSObject


/**省份*/
@property(nonatomic,copy)NSString * province;

/**省份代码*/
@property(nonatomic,copy)NSString * province_code;

/**支持的城市*/
@property(nonatomic,strong)NSArray * citys;

@end

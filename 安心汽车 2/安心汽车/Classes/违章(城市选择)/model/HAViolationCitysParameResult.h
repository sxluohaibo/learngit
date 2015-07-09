//
//  HAViolationCitysParameResult.h
//  安心汽车
//
//  Created by 罗海波 on 15/3/24.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAViolationCitysParameResult : NSObject


/**城市名称*/
@property(nonatomic,copy)NSString * city_name;

/**城市代码*/
@property(nonatomic,copy)NSString * city_code;

/**省份代码*/
@property(nonatomic,copy)NSString * province_code;

/**城市简称*/
@property(nonatomic,copy)NSString * abbr;

/**是否需要发动机号0,不需要 1,需要*/
@property(nonatomic,assign)BOOL engine;

/**需要几位发动机号0,全部 1-9 ,需要发动机号后N位*/
@property(nonatomic,assign)NSInteger engineno;

/**是否需要车架号0,不需要 1,需要*/
@property(nonatomic,assign)BOOL classa;

/**需要几位车架号0,全部 1-9 需要车架号后N位*/
@property(nonatomic,assign)NSInteger classno;

/**是否需要登记证书号0,不需要 1,需要*/
@property(nonatomic,assign)BOOL regist;

/**需要几位登记证书0,全部 1-9 需要登记证书后N位*/
@property(nonatomic,assign)NSInteger registno;

@end

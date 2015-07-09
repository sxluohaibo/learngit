//
//  HALoveCarModel.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  爱车登记信息界面

#import <Foundation/Foundation.h>

@interface HALoveCarModel : NSObject



/**数据库索引*/
@property(nonatomic,assign) int Did;


/**城市*/
@property(nonatomic,copy)NSString * city;

/**车详细信息*/
@property(nonatomic,copy)NSString * carinfo;

/**车类型*/
@property(nonatomic,copy)NSString * carType;


/**车图标*/
@property(nonatomic,copy)NSString * iconViewUrl;


/**里程*/
@property(nonatomic,copy)NSString * mileageText;


/**购买时间*/
@property(nonatomic,copy)NSString * DateText;


/**车牌号*/
@property(nonatomic,copy)NSString * carNumber;

/**车架号*/
@property(nonatomic,copy)NSString * carframe;

/**发动机号*/
@property(nonatomic,copy)NSString * engineNumber;

/**上次维修时间*/
@property(nonatomic,copy)NSString * serverTime;

/**是否是延保用户*/
@property(nonatomic,assign)BOOL  isVip;

+ (instancetype) loveCarModel:(NSString *)city carType:(NSString *)carType carinfo:(NSString *)carinfo  mileageText:(NSString *)mileageText DateText:(NSString *)DateText  carNumber:(NSString *)carNumber carframe:(NSString *)carframe engineNumber:(NSString *)engineNumber serverTime:(NSString *)serverTime;

@end

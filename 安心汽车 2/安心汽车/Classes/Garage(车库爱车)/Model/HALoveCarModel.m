//
//  HALoveCarModel.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  爱车登记信息界面

#import "HALoveCarModel.h"

@implementation HALoveCarModel



+ (instancetype) loveCarModel:(NSString *)city carType:(NSString *)carType carinfo:(NSString *)carinfo  mileageText:(NSString *)mileageText DateText:(NSString *)DateText  carNumber:(NSString *)carNumber carframe:(NSString *)carframe engineNumber:(NSString *)engineNumber serverTime:(NSString *)serverTime
{
    HALoveCarModel * obj = [[self alloc] init];
    obj.city = city;
    obj.carType = carType;
    obj.carinfo = carinfo;
    obj.mileageText = mileageText;
    obj.DateText = DateText;
    obj.carNumber = carNumber;
    obj.carframe = carframe;
    obj.engineNumber = engineNumber;
    obj.serverTime = serverTime;
    return obj;
}
@end

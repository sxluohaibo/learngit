//
//  HACarBrand.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/14.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  车辆品牌

#import <Foundation/Foundation.h>

@interface HACarBrand : NSObject


/**品牌ID*/
@property(nonatomic,assign)NSInteger brandId;


/**品牌name*/
@property(nonatomic,copy)NSString * brandName;


/**品牌首字母*/
@property(nonatomic,copy)NSString * firstLetter;



@end

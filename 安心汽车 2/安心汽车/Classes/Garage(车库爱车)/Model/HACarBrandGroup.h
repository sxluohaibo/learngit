//
//  HACarBrandGroup.h
//  安心汽车
//
//  Created by 罗海波 on 15/4/14.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HACarBrandGroup : NSObject

/**头部标题*/
@property(nonatomic,copy)NSString * firstLetter;


/**每组品牌数组*/
@property(nonatomic,strong)NSMutableArray * carBrands;


@end

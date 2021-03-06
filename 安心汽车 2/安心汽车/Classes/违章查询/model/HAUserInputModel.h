//
//  HAUserInputModel.h
//  安心汽车
//
//  Created by kongw on 15/4/21.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>
//用户输入的信息
@interface HAUserInputModel : NSObject

@property(nonatomic, strong)NSString *vioArea;//违章区域
@property(nonatomic, strong)NSString *carTypeNumber;//车牌号
@property(nonatomic, strong)NSString *carTypeShort;//车牌简称
@property(nonatomic, strong)NSString *classNumber;//机架号
@property(nonatomic, strong)NSString *engineNumber;//发动机号
@property(nonatomic, strong)NSString *registNumber;//注册号
@property(nonatomic, strong)NSString *remarkNumber;//备注号
@property(nonatomic, strong)NSString *userNO;//用户的编号

@end

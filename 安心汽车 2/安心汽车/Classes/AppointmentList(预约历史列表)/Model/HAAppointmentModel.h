//
//  HAAppointmentModel.h
//  安心汽车
//
//  Created by un2lock on 15/4/16.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HAAppointmentModel : NSObject
/**预约号 "appointId":2*/
@property(nonatomic,assign) NSInteger appointId;
/*4s店 "partnerName":"杭州保时捷4S店"*/
@property(nonatomic,copy) NSString *partnerName;
/*预约状态  0:待处理  1:预约成功  2:预约失败 */
@property(nonatomic,assign) NSNumber *appointStatus;
/*预约时间 "appointTime":"2016-08-20 21:18:00"*/
@property(nonatomic,copy) NSString *appointTime;
/*车牌号*/
@property(nonatomic,copy) NSString *carNo;
/*订单生成时间 "appointTime":"2016-08-20 21:18:00"*/
@property(nonatomic,copy) NSString *createTime;
@end

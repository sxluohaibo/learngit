//
//  HAAppointmentDetailsViewController.h
//  安心汽车
//
//  Created by un2lock on 15/4/17.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HAAppointmentModel.h"

@interface HAAppointmentDetailsViewController : HAWindowViewController

//点击cell传入一个模型
@property(nonatomic,strong)HAAppointmentModel *appointmentModel;

@end

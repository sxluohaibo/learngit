//
//  HAMaintenanceViewController.h
//  安心汽车
//
//  Created by kongw on 15/4/15.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HAAppointmentDetailModel.h"


@interface HAMaintenanceViewController : HAWindowViewController{
    
}
@property(nonatomic,strong)HAAppointmentDetailModel *detailModel;
@property(assign) int matenanceType;//状态
@end

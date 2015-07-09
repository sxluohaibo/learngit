//
//  HAAppointmentCell.h
//  安心汽车
//
//  Created by un2lock on 15/4/16.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HAAppointmentListResult;
@class  HAAppointmentModel;
@interface HAAppointmentCell : UITableViewCell
@property (nonatomic, strong) HAAppointmentModel *deal;
@property (weak, nonatomic) IBOutlet UILabel *appointTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *partnerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;

@end

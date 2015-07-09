//
//  HAAppointmentCell.m
//  安心汽车
//
//  Created by un2lock on 15/4/16.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAAppointmentCell.h"
#import "HAAppointmentListResult.h"
#import "HAAppointmentModel.h"

@interface HAAppointmentCell()
//@property (weak, nonatomic) IBOutlet UILabel *appointTimeLabel;
//@property (weak, nonatomic) IBOutlet UILabel *carNoLabel;
//@property (weak, nonatomic) IBOutlet UILabel *appointStatusLabel;
//@property (weak, nonatomic) IBOutlet UILabel *partnerNameLabel;


@end

@implementation HAAppointmentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        return [[[NSBundle mainBundle] loadNibNamed:@"HAAppointmentCell" owner:nil options:nil] lastObject];
    }
    return self;
}

@end

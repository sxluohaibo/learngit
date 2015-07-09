//
//  HAQuestionCell.h
//  提问列表demo1
//
//  Created by un2lock on 15/4/24.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@class QuestionModelFrame;
@interface HAQuestionCell : UITableViewCell
@property(nonatomic,strong) QuestionModelFrame *questionModelFrame;

+(instancetype) cellWithTableView:(UITableView *)tableview;
@end

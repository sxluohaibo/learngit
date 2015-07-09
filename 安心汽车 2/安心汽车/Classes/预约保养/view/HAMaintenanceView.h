//
//  HAMaintenanceView.h
//  安心汽车
//
//  Created by kongw on 15/4/15.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HAAppointmentDetailModel.h"
#import "HACarChoiceView.h"

@interface HAMaintenanceView : UIScrollView<UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,carTypeChoiceDelegate,UIScrollViewDelegate>{
    NSDictionary *choiceBackData;//用户选择后返回的数据
    NSDictionary *newData;//用户不选择返回的数据
    int submitType;//提交的类型 1 保存 2修改
    
    HAAppointmentDetailModel *reulstDetailModel;//详细界面的数据
    
    //资讯下面的列表
    UITableView *messageTableView;
    NSArray *messageArr;
    
    //选择
    NSString *partnerID;//显示咨询的ID
}

- (id)initWithFrame:(CGRect)frame andUserDic:(NSDictionary *)userDic andSumitType:(int)type andDetailModel:(HAAppointmentDetailModel *)detailModel;
@end

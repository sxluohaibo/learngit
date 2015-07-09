//
//  HAMaintenanceView.m
//  安心汽车
//
//  Created by kongw on 15/4/15.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAMaintenanceView.h"
#import "HAMineLoveCarDBOperator.h"
#import "HA4sFrame.h"

@implementation HAMaintenanceView{
    UILabel *carTypeLabel;//车牌号
    UILabel *changeOrdertimeLabel;//选择预约时间按钮
    UILabel *changeStore4sLabel;//选择4S店
    UITextView *remarkTextView;//备注的选择
    UILabel *detail_4sLabel;//4s店的详细位置
    UIImageView *loctionImage;//定位的图标
    UILabel *carType;//车型
    UIImageView *arrowImage;//箭头
    
    UIImageView *messageImageView;//显示预约列表
    UIButton *loadMore;//加载更多
}

- (id)initWithFrame:(CGRect)frame andUserDic:(NSDictionary *)userDic andSumitType:(int)type andDetailModel:(HAAppointmentDetailModel *)detailModel{
    self = [super initWithFrame:frame];
    self.delegate = self;
    self.userInteractionEnabled = YES;
    if (self) {//高度52（cell）
        newData = userDic;
        reulstDetailModel = detailModel;
        submitType = type;
        #define orderTime @"预约时间:"
        #define stores_4s @"4S店:"
        #define car_plate @"车牌号:"
        #define remark @"备注:"
        //车牌号
        UIButton *changeCarTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        changeCarTypeButton.backgroundColor = [UIColor clearColor];
        changeCarTypeButton.frame = CGRectMake(10, 18, 142, 18);
        [changeCarTypeButton setTitleColor:HAColor(78, 109, 151) forState:UIControlStateNormal];
        [changeCarTypeButton addTarget:self action:@selector(changeCarTypeAction:) forControlEvents:UIControlEventTouchUpInside];
        changeCarTypeButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        changeCarTypeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:changeCarTypeButton];
        
        
        NSArray *noYanBaoArr = [HAMineLoveCarDBOperator getLoveCarModel:NO];//不是延保用户的数据
        //车牌
        carTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 85, 18)];
        carTypeLabel.textColor = HAColor(47, 92, 143);
        carTypeLabel.textAlignment = NSTextAlignmentLeft;
        carTypeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
        if (userDic) {
            carTypeLabel.text = [userDic objectForKey:@"carNo"];
        }else if (noYanBaoArr.count>0){
            HALoveCarModel *loveModel = [noYanBaoArr objectAtIndex:0];
            carTypeLabel.text = loveModel.carNumber;
        }else{
            carTypeLabel.text = @"选择车牌号";
        }
        [changeCarTypeButton addSubview:carTypeLabel];
        
        //车的类型
        carType = [[UILabel alloc] init];
        carType.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0f];
        carType.textColor = RGBA(114, 135, 160, 1);
        if (userDic) {
            carType.text = [userDic objectForKey:@"carBand"];;
        }else if (noYanBaoArr.count>0){
            HALoveCarModel *loveModel = [noYanBaoArr objectAtIndex:0];
            if (loveModel.carType) {
                NSArray *tempArr = [loveModel.carType componentsSeparatedByString:@" "];
                carType.text = [tempArr objectAtIndex:0];
            }else{
                carType.text = @"";
            }
        }else{
            carType.text = @"车型";
        }
        carType.textAlignment = NSTextAlignmentCenter;
        carType.backgroundColor = [UIColor clearColor];
        [changeCarTypeButton addSubview:carType];
        
        CGSize detailSize = [carType.text sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        carType.frame = CGRectMake(80, 0, detailSize.width, 18);
        
        //往下的箭头表示可以点击
        arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(80+detailSize.width+3, 6, 9, 6)];
        arrowImage.image = [UIImage imageNamed:@"down_icon"];
        [changeCarTypeButton addSubview:arrowImage];
        
        //中间的虚线
        for (int i = 1; i < 5; i++) {
            UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 52*i, ScreenWidth, 1)];
            lineImageView.image = [UIImage imageNamed:@"dots_divider.png"];
            [self addSubview:lineImageView];
        }
        
        //预约时间
        UILabel *orderTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 66, 150, 20)];
        orderTimeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        orderTimeLabel.text = @"选择预约时间";
        orderTimeLabel.textAlignment = NSTextAlignmentLeft;
        orderTimeLabel.textColor = HAColor(47, 92, 143);
        [self addSubview:orderTimeLabel];
        
        //背景button
        UIButton *changeOrdertimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        changeOrdertimeButton.backgroundColor = RGBA(187, 201, 211, 1);
        changeOrdertimeButton.frame = CGRectMake(171, 66, 133, 22);
        [changeOrdertimeButton addTarget:self action:@selector(changeOrdertimeAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:changeOrdertimeButton];
        
        changeOrdertimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 22)];
        changeOrdertimeLabel.backgroundColor = [UIColor clearColor];
        changeOrdertimeLabel.textAlignment = NSTextAlignmentCenter;
        changeOrdertimeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        changeOrdertimeLabel.textColor = HAColor(47, 92, 143);
        changeOrdertimeLabel.text = @"请您选择预约时间";
        [changeOrdertimeButton addSubview:changeOrdertimeLabel];
        
        //选择时间的箭头
        UIImageView *orderTimeArrow = [[UIImageView alloc] initWithFrame:CGRectMake(120, 8, 9, 6)];
        orderTimeArrow.image = [UIImage imageNamed:@"down_icon"];
        [changeOrdertimeButton addSubview:orderTimeArrow];
        

        //选择4S店
        UILabel *store4SLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 117, 100, 20)];
        store4SLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        store4SLabel.text = @"选择4S店";
        store4SLabel.textAlignment = NSTextAlignmentLeft;
        store4SLabel.textColor = HAColor(47, 92, 143);
        [self addSubview:store4SLabel];
        
        UIButton *changeStore4sButton = [UIButton buttonWithType:UIButtonTypeCustom];
        changeStore4sButton.backgroundColor = RGBA(187, 201, 211, 1);
        changeStore4sButton.frame = CGRectMake(171, 117, 133, 22);
        [changeStore4sButton addTarget:self action:@selector(changeStore4SAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:changeStore4sButton];
        
        
        //NSLog(@"userDic == %@",userDic);
        changeStore4sLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 22)];
        changeStore4sLabel.backgroundColor = [UIColor clearColor];
        changeStore4sLabel.textAlignment = NSTextAlignmentCenter;
        changeStore4sLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        changeStore4sLabel.textColor = HAColor(47, 92, 143);
        if (userDic) {
            changeStore4sLabel.text = [userDic objectForKey:@"partnerName"];
        }else{
            changeStore4sLabel.text = @"请您填写4S店";
        }
        [changeStore4sButton addSubview:changeStore4sLabel];
        
        //4S箭头
        UIImageView *store4sArrow = [[UIImageView alloc] initWithFrame:CGRectMake(120, 8, 9, 6)];
        store4sArrow.image = [UIImage imageNamed:@"down_icon"];
        [changeStore4sButton addSubview:store4sArrow];
        
        //选择位置的按钮
        loctionImage = [[UIImageView alloc] initWithFrame:CGRectMake(142, 126, 13, 19)];
        loctionImage.image = [UIImage imageNamed:@"map_icon"];
        loctionImage.userInteractionEnabled = YES;
        if (userDic) {
            loctionImage.accessibilityHint = [userDic objectForKey:@"partnerLocation"];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [loctionImage addGestureRecognizer:tap];
        [self addSubview:loctionImage];
        
        //4s店的详细
        detail_4sLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 138, 126, 12)];
        if (userDic) {
            detail_4sLabel.text = [userDic objectForKey:@"address"];
        }else{
            detail_4sLabel.text = @"";
        }
        detail_4sLabel.textColor = RGBA(114, 135, 160, 1);
        detail_4sLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:10.0f];
        [self addSubview:detail_4sLabel];
        
        //备注
        UILabel *remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 169, 100, 30)];
        remarkLabel.backgroundColor = [UIColor clearColor];
        remarkLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16.0f];
        remarkLabel.text = @"车况备注";
        remarkLabel.textAlignment = NSTextAlignmentLeft;
        remarkLabel.textColor = HAColor(78, 109, 151);
        [self addSubview:remarkLabel];
        
        remarkTextView = [[UITextView alloc] init];
        remarkTextView.backgroundColor = RGBA(187, 201, 211, 1);
        remarkTextView.frame = CGRectMake(ScreenWidth-200, 157, 190, 50);
        remarkTextView.delegate = self;
        remarkTextView.text = @"请您输入备注信息,例如(我是张三)";
        remarkTextView.font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
        remarkTextView.textColor = HAColor(47, 92, 143);
        [self addSubview:remarkTextView];

        //增加预约
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake((ScreenWidth-291)/2, 221, 291, 39);
        sureButton.backgroundColor = HAColor(47, 92, 143);
        sureButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:22.0f];
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [sureButton setTitle:@"确认" forState:UIControlStateNormal];
        [self addSubview:sureButton];
        
        //加载资讯列表
        messageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 275, ScreenWidth, 24+74*messageArr.count+40)];
        messageImageView.userInteractionEnabled = YES;
        messageImageView.hidden = YES;
        messageImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:messageImageView];
        
        //预约列表的标题
        UIImageView *messageImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 24)];
        messageImage.backgroundColor = RGBA(187, 201, 211, 1);
        [messageImageView addSubview:messageImage];
        
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 150, 18)];
        messageLabel.text = @"4S店资讯";
        messageLabel.textColor = HAColor(47, 92, 143);
        messageLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
        [messageImage addSubview:messageLabel];
        
        messageTableView = [[UITableView alloc] init];
        messageTableView.backgroundColor = [UIColor clearColor];
        messageTableView.scrollEnabled = NO;
        messageTableView.delegate = self;
        messageTableView.dataSource = self;
        [messageImageView addSubview:messageTableView];
        
        //加载更多
        loadMore = [UIButton buttonWithType:UIButtonTypeCustom];
        loadMore.frame = CGRectMake(0, 24+74*messageArr.count, ScreenWidth, 40);
        loadMore.backgroundColor = HAColor(47, 92, 143);
        [loadMore addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
        [loadMore setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loadMore setTitle:@"查看更多" forState:UIControlStateNormal];
        [messageImageView addSubview:loadMore];
        
        partnerID = [userDic objectForKey:@"partnerID"];
        [self loadNewsList:partnerID];//加载预约列表
    }
    return self;
}

//加载预约列表的数据
- (void)loadNewsList:(NSString *)partnerCode{
    //加载列表的数据
    NSString *downName = [NSString stringWithFormat:@"/T100040/news/showNewsInfoList?partnerCode=%@&startIndex=%@&pageSize=%@",partnerCode,@"1",@"5"];
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:nil httpMethod:@"GET" ssl:NO];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
        //NSLog(@"预约历史列表  cityInfo == %@",cityInfo);
        if ([[cityInfo objectForKey:@"resultCode"] integerValue] == 1) {
            messageArr = [cityInfo objectForKey:@"newsList"];
            if (messageArr.count > 0) {
                self.contentSize = CGSizeMake(ScreenWidth, 298+74*messageArr.count+64+40);
                messageImageView.frame = CGRectMake(0, 275, ScreenWidth, 24+74*messageArr.count+40);
                messageTableView.frame = CGRectMake(0, 24, ScreenWidth, 74*messageArr.count);
                loadMore.frame = CGRectMake(0, 24+74*messageArr.count, ScreenWidth, 40);
                messageImageView.hidden = NO;
                [messageTableView reloadData];
            }else{
                messageImageView.hidden = YES;
            }
        }else{
            messageImageView.hidden = YES;
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"失败");
        messageImageView.hidden = YES;
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
}

-(void)layoutSubviews{
    self.contentSize = CGSizeMake(ScreenWidth, 298+74*messageArr.count+64+40);
}

//预约列表
- (void)appointmentListAciton:(UIButton *)sender{
    HAAppointmentListViewController *pointVc = [[HAAppointmentListViewController alloc] init];
    [[self viewController].navigationController pushViewController:pointVc animated:YES];
}

//提交预约按钮
- (void)sureButtonAction:(UIButton *)sender{
    NSMutableDictionary *userInputData = [[NSMutableDictionary alloc] init];
    //添加车牌号
    if ([carTypeLabel.text isEqualToString:@""]||[carTypeLabel.text isKindOfClass:[NSNull class]] || carTypeLabel.text == nil || [carTypeLabel.text isEqualToString:@"选择车牌号"]) {
        [MBProgressHUD showError:@"车牌号不能为空"];
        return;
    }else{
        [userInputData setObject:carTypeLabel.text forKey:car_plate];
    }
    
    //添加预约时间
    if ([changeOrdertimeLabel.text isEqualToString:@""]||[changeOrdertimeLabel.text isKindOfClass:[NSNull class]] || changeOrdertimeLabel.text == nil || [changeOrdertimeLabel.text isEqualToString:@"请您选择预约时间"]) {
        [MBProgressHUD showError:@"预约的时间不能为空"];
        return;
    }else{
        NSDate *changeDate = [HAManger dateFromString:changeOrdertimeLabel.text];
        NSTimeInterval changeTime = [changeDate timeIntervalSince1970];
        NSLog(@"现在选的时间戳 == %f",changeTime);
        NSString *changeStr = [NSString stringWithFormat:@"%f",changeTime];
        if ([HAManger HAbackTime:changeStr]) {
            [userInputData setValue:changeOrdertimeLabel.text forKey:orderTime];
        }else{
            [MBProgressHUD showError:@"请您预约24小时之后的时间"];
            return;
        }
    }
    
    //添加4S店
    if ([changeStore4sLabel.text isEqualToString:@""]||[changeStore4sLabel.text isKindOfClass:[NSNull class]] || changeStore4sLabel.text == nil || [changeStore4sLabel.text isEqualToString:@"请您填写4S店"]) {
        [MBProgressHUD showError:@"4S店名不能为空"];
        return;
    }else{
        [userInputData setValue:changeStore4sLabel.text forKey:stores_4s];
    }
    
    //添加备注信息
    if ([remarkTextView.text isEqualToString:@""] || [remarkTextView.text isKindOfClass:[NSNull class]] || remarkTextView.text == nil) {
        [userInputData setValue:@"" forKey:remark];
    }else{
        if (remarkTextView.text.length > 25) {
            [MBProgressHUD showError:@"输入的字符长度不能超过25个汉字"];
        }else{
           [userInputData setValue:remarkTextView.text forKey:remark];
        }
    }
    NSLog(@"userInputData == %@",userInputData);
    //发送数据
    [self senderData:userInputData];
}

- (void)senderData:(NSMutableDictionary *)sendData{
    if (submitType == 1) {//保存
        [MBProgressHUD showMessage:@"正在增加一条预约"];
        NSString *downName = [NSString stringWithFormat:@"/T100040/appointment/addAppointment"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setObject:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserPhonenumer] forKey:@"phoneNo"];//手机号
        [data setObject:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo] forKey:@"userNo"];
        [data setObject:[sendData objectForKey:car_plate] forKey:@"carNo"];//车牌号
        
        NSString *tempStr = [NSString stringWithFormat:@"20%@ 00:00",[sendData objectForKey:orderTime]];
        [data setObject:tempStr forKey:@"appointTime"];//预约时间
        [data setObject:@"2013-12-12" forKey:@"carBuyDate"];//车辆购买登记时间
        [data setObject:@"888" forKey:@"mileage"];//车辆行驶里程
        [data setObject:@"A-奥迪" forKey:@"carBrand"];//车辆具体型号
        if (choiceBackData) {
            [data setObject:[choiceBackData objectForKey:@"partnerCode"] forKey:@"partnerCode"];//预约4S店编号
            [data setObject:[choiceBackData objectForKey:@"partnerLocation"] forKey:@"partnerLocation"];//预约4S店经纬度
        }else{
            if (newData) {
                [data setObject:[newData objectForKey:@"partnerID"] forKey:@"partnerCode"];//预约4S店编号
            }else{
                [data setObject:@"" forKey:@"partnerCode"];//预约4S店编号
            }
            [data setObject:@"" forKey:@"partnerLocation"];//预约4S店经纬度
        }
        [data setObject:[sendData objectForKey:stores_4s] forKey:@"partnerName"];//预约4S店名称
        [data setObject:[sendData objectForKey:remark] forKey:@"remarks"];//用户备注

        MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:data httpMethod:@"POST" ssl:NO];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            [MBProgressHUD hideHUD];
            NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
            NSLog(@"%@",completedOperation.responseString);
            if ([[cityInfo objectForKey:@"resultCode"]integerValue]==1) {
                [self skipNewInterFace];//跳转到最新预约的界面
            }else{
                [MBProgressHUD showError:@"预约失败"];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"失败");
            [MBProgressHUD hideHUD];
        }];
        [ApplicationDelegate.engine enqueueOperation:op];
    }
    if (submitType == 2) {//修改
        [MBProgressHUD showMessage:@"正在保存预约"];
        NSString *downName = [NSString stringWithFormat:@"/T100040/appointment/updateAppointment"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
        [data setObject:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserPhonenumer] forKey:@"phoneNo"];//手机号
        NSLog(@"修改的ID ＝ %@",reulstDetailModel.idstr);
        [data setObject:reulstDetailModel.idstr forKey:@"appointId"];
        [data setObject:[sendData objectForKey:car_plate] forKey:@"carNo"];//车牌号
        NSString *tempStr = [NSString stringWithFormat:@"20%@ 00:00",[sendData objectForKey:orderTime]];
        [data setObject:tempStr forKey:@"appointTime"];//预约时间
        [data setObject:@"2013-12-12" forKey:@"carBuyDate"];//车辆购买登记时间
        [data setObject:@"888" forKey:@"mileage"];//车辆行驶里程
        [data setObject:@"A-奥迪" forKey:@"carBrand"];//车辆具体型号
        if (choiceBackData) {
            [data setObject:[choiceBackData objectForKey:@"partnerCode"] forKey:@"partnerCode"];//预约4S店编号
            [data setObject:[choiceBackData objectForKey:@"partnerLocation"] forKey:@"partnerLocation"];//预约4S店经纬度
        }else{
            [data setObject:[newData objectForKey:@"partnerID"] forKey:@"partnerCode"];//预约4S店编号
            [data setObject:@"" forKey:@"partnerLocation"];//预约4S店经纬度
        }
        [data setObject:[sendData objectForKey:stores_4s] forKey:@"partnerName"];//预约4S店名称
        [data setObject:[sendData objectForKey:remark] forKey:@"remarks"];//用户备注
        MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:data httpMethod:@"GET" ssl:NO];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            [MBProgressHUD hideHUD];
            NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
            NSLog(@"%@",completedOperation.responseString);
            if ([[cityInfo objectForKey:@"resultCode"]integerValue]==1) {
                [MBProgressHUD showSuccess:@"修改成功"];
                [[self viewController].navigationController popViewControllerAnimated:YES];
            }else{
                [MBProgressHUD showSuccess:@"修改失败"];
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"失败");
            [MBProgressHUD hideHUD];
        }];
        [ApplicationDelegate.engine enqueueOperation:op];
    }
}

//跳转到最新的预约
- (void)skipNewInterFace{
    NSString *downName = [NSString stringWithFormat:@"/T100040/appointment/showLatestAppoint?userNo=%@",[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]];
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:nil httpMethod:@"GET" ssl:NO];
    NSLog(@"op.url == %@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
        NSLog(@"两个界面 %@",cityInfo);
        if ([[cityInfo objectForKey:@"resultCode"] integerValue] == 1) {//有预约 详情列表
            HANewAppointDetailViewController *newDetailVc = [[HANewAppointDetailViewController alloc] init];
            newDetailVc.detailInfoDic = cityInfo;
            [[self viewController].navigationController pushViewController:newDetailVc animated:YES];
        }else{//添加预约界面
            [MBProgressHUD showError:@"还没有预约详情"];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"失败");
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 500) {
        if (buttonIndex == 0) {
            HAAppointmentListViewController *pointVc = [[HAAppointmentListViewController alloc] init];
            [[self viewController].navigationController pushViewController:pointVc animated:YES];
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    if (textView.tag == 106) {
        textView.text = @"";
        [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.frame = CGRectMake(0, -120, ScreenWidth, ScreenHeight);
        } completion:nil];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 104) {
        [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.frame = CGRectMake(0, -70, ScreenWidth, ScreenHeight);
        } completion:nil];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    NSLog(@"touch.view == %@",touch.view);
    
    if ([touch.view isKindOfClass:[HACarChoiceView class]]) {
        return;
    }
    for (UIImageView *tempView in self.subviews) {
        if (tempView.tag == 999) {
            [tempView removeFromSuperview];
        }
    }
    UIDatePicker *picker = (UIDatePicker *)[self viewWithTag:200];
    [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    } completion:nil];
    if (picker) {
        [picker removeFromSuperview];
    }
    [self endEditing:YES];
}


#define kMaxLength 7
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField.accessibilityIdentifier isEqualToString:car_plate]) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > kMaxLength && range.length!=1){
            textField.text = [toBeString substringToIndex:kMaxLength];
            return NO;
        }
        return YES;
    }
    return YES;
}

- (void)addMoreCar{
    for (UIImageView *tempView in self.subviews) {
        if (tempView.tag == 999) {
            [tempView removeFromSuperview];
        }
    }
    HALoveCarViewController *loveVc = [[HALoveCarViewController alloc] init];
    HANavigationController *navigationVC=[[HANavigationController alloc] initWithRootViewController:loveVc];
    [[self viewController] presentViewController:navigationVC animated:YES completion:^{
        
    }];
}

//选择车牌号的列表
- (void)changeCarTypeAction:(UIButton *)sender{
    NSLog(@"选择列表");
    UIImageView *tempView = (UIImageView *)[self viewWithTag:999];
    if (tempView) {
        [tempView removeFromSuperview];
    }else{
        NSArray *tempArr = [HAMineLoveCarDBOperator exqueryFMDBWithSql:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]];
        NSLog(@"获取爱车里面的车辆 == %@",tempArr);
        HACarChoiceView *choiceView = [[HACarChoiceView alloc] initWithFrame:CGRectMake(0, 50, sender.frame.size.width, tempArr.count*44+44) andCarArr:tempArr];
        choiceView.tag = 999;
        choiceView.delegate = self;
        choiceView.userInteractionEnabled = YES;
        choiceView.backgroundColor = [UIColor grayColor];
        [self addSubview:choiceView];
    }
}

//代理方法
- (void)getLoveCarType:(NSString *)carName andCarType:(NSString *)tempCarType{
    //NSLog(@"dsfsdfs %@",carName);
    for (UIImageView *tempView in self.subviews) {
        if (tempView.tag == 999) {
            [tempView removeFromSuperview];
        }
    }
    carTypeLabel.text = carName;
    //carType.text = tempCarType;
    NSArray *tempArr = [tempCarType componentsSeparatedByString:@" "];
    carType.text = [tempArr objectAtIndex:0];
    CGSize detailSize = [carType.text sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    carType.frame = CGRectMake(80, 0, detailSize.width, 18);
    arrowImage.frame = CGRectMake(80+detailSize.width+3, 6, 9, 6);
}

- (void)changeOrdertimeAction:(UIButton *)sender{
    UIDatePicker *tempDatePicker = (UIDatePicker *)[self viewWithTag:200];
    if (tempDatePicker) {
        [tempDatePicker removeFromSuperview];
    }
    NSLog(@"预约时间");
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 110, ScreenWidth, 320)];
    datePicker.backgroundColor = [UIColor whiteColor];
    [datePicker addTarget:self action:@selector(dateValueChanged:) forControlEvents:UIControlEventValueChanged];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.tag = 200;
    datePicker.date = [NSDate date];
    datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [self addSubview:datePicker];
}

//预约时间
- (void)dateValueChanged:(UIButton *)sender{
    UIDatePicker *picker = (UIDatePicker *)[self viewWithTag:200];
    NSDate *selected = [picker date];
    NSLog(@"date: %@", selected);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:selected];
    changeOrdertimeLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0f];
    changeOrdertimeLabel.text = strDate;
}

//选择4S店
- (void)changeStore4SAction:(UIButton *)sender{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshinterFace:) name:MainTenanceCarNameChoice object:nil];
    HAMaintenanceCityViewController *mCityVc = [[HAMaintenanceCityViewController alloc] init];
    mCityVc.carBrand = carType.text;
    UINavigationController *navigationVC=[[UINavigationController alloc] initWithRootViewController:mCityVc];
    [[self viewController].navigationController  presentViewController:navigationVC animated:YES completion:nil];
}

//4s店的选择
- (void)refreshinterFace:(NSNotification *)notication{
    NSLog(@"notication.object == %@",notication.object);
    choiceBackData = notication.object;
    changeStore4sLabel.text = [choiceBackData objectForKey:@"partnerName"];
    detail_4sLabel.text = [choiceBackData objectForKey:@"address"];
    loctionImage.accessibilityHint = [choiceBackData objectForKey:@"partnerLocation"];
    [self loadNewsList:[choiceBackData objectForKey:@"partnerCode"]];
    partnerID = [choiceBackData objectForKey:@"partnerCode"];
}

//点击显示详细的地图
- (void)tapView:(UITapGestureRecognizer *)tap{
    NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] init];
    if (![tap.view.accessibilityHint isEqualToString:@""] && ![tap.view.accessibilityHint isKindOfClass:[NSNull class]] && tap.view.accessibilityHint != nil) {
        NSArray *tempArr = [[NSArray alloc] init];
        tempArr = [tap.view.accessibilityHint componentsSeparatedByString:@","];
        if ([[tempArr objectAtIndex:0] floatValue] > 0 && [[tempArr objectAtIndex:0] floatValue] < 90) {
            [tempDic setObject:[tempArr objectAtIndex:0] forKey:@"latitude"];
        }else{
            [tempDic setObject:@"0" forKey:@"latitude"];
        }
        if ([[tempArr objectAtIndex:0] floatValue] > 0 && [[tempArr objectAtIndex:0] floatValue] < 180) {
            [tempDic setObject:[tempArr objectAtIndex:1] forKey:@"longitude"];
        }else{
            [tempDic setObject:@"0" forKey:@"longitude"];
        }
    }
    HAMapViewController *mapVc = [[HAMapViewController alloc] init];
    mapVc.mapDic = tempDic;
    [[self viewController].navigationController pushViewController:mapVc animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return messageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dic = [messageArr objectAtIndex:indexPath.row];
        
        
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(14, 12, 56, 50)];
        iconImage.backgroundColor = HAColor(47, 92, 143);
        [cell addSubview:iconImage];
        
        UILabel *titleName = [[UILabel alloc] initWithFrame:CGRectMake(80, 13, 225, 12)];
        titleName.textColor = HAColor(47, 92, 143);
        titleName.text = [dic objectForKey:@"title"];
        titleName.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        [cell addSubview:titleName];
        
        UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 28, 225, 36)];
        descriptionLabel.textColor = RGBA(114, 135, 160, 1);
        descriptionLabel.text = [dic objectForKey:@"summary"];
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.font = [UIFont systemFontOfSize:10.0f];
        [cell addSubview:descriptionLabel];
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 74, ScreenWidth, 1)];
        lineImageView.image = [UIImage imageNamed:@"dots_divider.png"];
        [cell addSubview:lineImageView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic = [messageArr objectAtIndex:indexPath.row];
    HADetailMessageViewController * vc = [HADetailMessageViewController Message:[[dic objectForKey:@"newsId"] integerValue]];
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

//查看更多
- (void)loadMore:(UIButton *)sender{
    HA4SShopConsultingViewController *shopVc = [[HA4SShopConsultingViewController alloc] init];
    shopVc.proCode = partnerID;
    [[self viewController].navigationController pushViewController:shopVc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollView == %@",scrollView);
}


@end

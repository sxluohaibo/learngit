//
//  HAAddCarViewController.m
//  安心汽车
//
//  Created by kongw on 15/3/20.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAAddCarViewController.h"

@interface HAAddCarViewController (){
    
}
@end

@implementation HAAddCarViewController
@synthesize delegate;
@synthesize userInput;
@synthesize totalArr;
@synthesize type;

- (void)viewDidLoad {
    [super viewDidLoad];
    if (type == 1) {
        self.navigationItem.title = @"增加车辆";
    }else if (type == 0){
        self.navigationItem.title = @"修改车辆";
    }
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sub_bg.jpg"]];
    HAAddCarImageView *addCarImageView = [[HAAddCarImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)andAddCarInfoArr:totalArr andEditor:userInput andType:type];
    addCarImageView.tag = 100;
    addCarImageView.delegate = self;
    [self.view addSubview:addCarImageView];
}

- (void)deteleButtonAction:(UIButton *)sender{
    NSLog(@"删除车辆");
    if ([[HABeanUserInput shareUserInput] deleteInputDB:userInput.carTypeNumber]) {
        [MBProgressHUD showSuccess:@"删除成功"];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(backAction) userInfo:nil repeats:NO];
    }
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

//增加车辆信息的方法
- (void)addButtonAction:(UIButton *)sender{
    //保存的字典
    NSMutableDictionary *userInputDic = [[NSMutableDictionary alloc] init];
    NSString *carTypeShort = nil;
    HAAddCarImageView *tempView = (HAAddCarImageView *)[self.view viewWithTag:100];
    
    NSMutableArray *listArr = [[NSMutableArray alloc] initWithArray:tempView.subviews];
    for (UIImageView *imageView in listArr) {
        if ([imageView.accessibilityIdentifier isEqualToString:violationArea]) {
            UILabel *label = (UILabel *)[imageView viewWithTag:10];
            if ([label.text isEqualToString:@"选择城市"]) {
                [MBProgressHUD showError:@"请您先选择城市"];
                return;
            }
        }else if ([imageView.accessibilityIdentifier isEqualToString:carTypeNO]) {
            UITextField *textField = (UITextField *)[imageView viewWithTag:20];
            UILabel *labelTitle = (UILabel *)[imageView viewWithTag:10];
            UIButton *button = (UIButton *)[imageView viewWithTag:99];
            UILabel *buttonLabel = button.titleLabel;
            NSString *value = [buttonLabel.text stringByAppendingString:textField.text];
            carTypeShort = textField.text;
            
            if ([textField.text isEqualToString:@""]||[textField.text isKindOfClass:[NSNull class]] || textField.text == nil) {
                [MBProgressHUD showError:@"车牌号不能为空"];
                return;
            }else{
                if (value.length == 7) {
                    [userInputDic setValue:value forKey:labelTitle.text];
                }else{
                    [MBProgressHUD showError:@"车牌号必须7位"];
                    return;
                }
            }
        }else if ([imageView.accessibilityIdentifier isEqualToString:classNO]){
            UILabel *label = (UILabel *)[imageView viewWithTag:10];
            UITextField *textField = (UITextField *)[imageView viewWithTag:20];
            if ([textField.text isEqualToString:@""]||[textField.text isKindOfClass:[NSNull class]] || textField.text == nil) {
                [MBProgressHUD showError:@"车架号不能为空"];
                return;
            }else{
                [userInputDic setValue:textField.text forKey:label.text];
            }
        }else if ([imageView.accessibilityIdentifier isEqualToString:engineNo]){
            UILabel *label = (UILabel *)[imageView viewWithTag:10];
            UITextField *textField = (UITextField *)[imageView viewWithTag:20];
            if ([textField.text isEqualToString:@""]||[textField.text isKindOfClass:[NSNull class]] || textField.text == nil) {
                [MBProgressHUD showError:@"发动机号不能为空"];
                return;
            }else{
                [userInputDic setValue:textField.text forKey:label.text];
            }
        }else if ([imageView.accessibilityIdentifier isEqualToString:registerNO]){
            UILabel *label = (UILabel *)[imageView viewWithTag:10];
            UITextField *textField = (UITextField *)[imageView viewWithTag:20];
            if ([textField.text isEqualToString:@""]||[textField.text isKindOfClass:[NSNull class]] || textField.text == nil) {
                [MBProgressHUD showError:@"注册号不能为空"];
                return;
            }else{
                [userInputDic setValue:textField.text forKey:label.text];
            }
        }
        else if ([imageView.accessibilityIdentifier isEqualToString:remarkNO]){
            UILabel *label = (UILabel *)[imageView viewWithTag:10];
            UITextField *textField = (UITextField *)[imageView viewWithTag:20];
            if ([textField.text isEqualToString:@""]||[textField.text isKindOfClass:[NSNull class]] || textField.text == nil) {
                [userInputDic setObject:@"" forKey:label.text];
            }else{
                [userInputDic setValue:textField.text forKey:label.text];
            }
        }
    }
    titleValue = @"";
    for (int i = 0; i < totalArr.count; i++) {
        HAViolationCitysParameResult *cityModel = [totalArr objectAtIndex:i];
        if ([titleValue isEqualToString:@""]) {
            titleValue = cityModel.city_name;
        }else{
            titleValue = [titleValue stringByAppendingFormat:@"-%@",cityModel.city_name];
        }
    }
    
    //判断用户有没有选择城市
    if ([titleValue isEqualToString:@""]||[titleValue isKindOfClass:[NSNull class]] || titleValue == nil) {
        [MBProgressHUD showError:@"请您先选择城市"];
        return;
    }
    [userInputDic setObject:carTypeShort forKey:carTYShort];//去掉前面的简称
    [userInputDic setObject:titleValue forKey:violationArea];//违章区域
    [userInputDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo] forKey:LoginUserNo];
    NSLog(@"userInputDic == %@",userInputDic);
    
    //添加之前先查询数据库里面有没有这辆车
    HAUserInputModel *inputModel = [[HABeanUserInput shareUserInput] getUserInfoData:[userInputDic objectForKey:@"车牌号"]];
    if ([inputModel.carTypeNumber isEqualToString:[userInputDic objectForKey:@"车牌号"]]) {
        [MBProgressHUD showError:@"该车辆已经存在"];
        return;
    }else{
        [self skipCheckInfoView:userInputDic];//传入用户输入的信息//跳转
    }
}

//跳转的方法
- (void)skipCheckInfoView:(NSMutableDictionary *)userInfoDic{
    [MBProgressHUD showMessage:@"正在查询违章信息"];
    HAViolationCitysParameResult *cityModel = [totalArr objectAtIndex:0];
    NSString *cityName = cityModel.city_code;//城市名称
    [userInfoDic setObject:cityModel.city_code forKey:@"城市编号"];
    NSString *carCard = [userInfoDic objectForKey:@"车牌号"];//车牌号
    NSString *engineno = @"";
    if ([userInfoDic objectForKey:@"发动机号"]) {
        engineno = [userInfoDic objectForKey:@"发动机号"];//发动机号
    }else{
        engineno = @"";
    }
    NSString *classno = @"";
    if ([userInfoDic objectForKey:@"车架号"]) {
        classno = [userInfoDic objectForKey:@"车架号"];//发动机号
    }else{
        classno = @"";
    }
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params setObject:cityName forKey:@"city"];
    [params setObject:carCard forKey:@"hphm"];
    [params setObject:engineno forKey:@"engineno"];
    [params setObject:classno forKey:@"classno"];
    NSLog(@"111 == %@ %@ %@ %@",cityName,carCard,engineno,classno);
    NSString *downName = @"T100040/wz/query";
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:params httpMethod:@"GET" ssl:NO];
    NSLog(@"op.url == %@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
        //NSLog(@"cityInfo == %@",cityInfo);
        [MBProgressHUD hideHUD];
        if ([[cityInfo objectForKey:@"resultcode"] integerValue] == 200) {
            [MBProgressHUD showSuccess:@"查询成功"];
            //数据库插入数据
            HAUserInputModel *carModel = [[HABeanUserInput shareUserInput] getUserInfoData:carCard];
            //BOOL type =  [[HABeanUserInput shareUserInput] whetherUserCarType:carCard];
            if ([carModel.carTypeNumber isEqualToString:carCard]) {
                [[HABeanUserInput shareUserInput] upDataUserInfoData:[HAManger parseUserInput:userInfoDic]];
            }else{
                [[HABeanUserInput shareUserInput] addUserInfoData:[HAManger parseUserInput:userInfoDic]];
            }
            //保存数据
            [ApplicationDelegate.store putObject:cityInfo withId:carCard intoTable:VioResultDB];
            
            //跳转
            HAViolationListViewController *listVC = [[HAViolationListViewController alloc] init];
            listVC.carType = carCard;
            [self.navigationController pushViewController:listVC animated:YES];
            if ([self.delegate respondsToSelector:@selector(addCarMessageToMemmary)]) {
                [self.delegate addCarMessageToMemmary];
            }//传数据
        }else{
            [MBProgressHUD showError:@"保存的信息有误"];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"失败");
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
}

//跳转加入通知
- (void)getNotifaCation{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getViolationName:) name:ClickViolationName object:nil];
    HAChoiceVioViewController *cityView=[[HAChoiceVioViewController alloc] init];
    cityView.choiceListArr = totalArr;
    UINavigationController *navigationVC=[[UINavigationController alloc] initWithRootViewController:cityView];
    [self  presentViewController:navigationVC animated:YES completion:nil];
}

//移除通知
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//通知返回 并移除
- (void)getViolationName:(NSNotification *)notifocation{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ClickViolationName object:nil];
    HAViolationCitysParameResult *cityModel = [[HABeancity shareBeanCity] checkOneCityData:notifocation.object];
    totalArr = [[NSMutableArray alloc] initWithCapacity:1];
    [totalArr addObject:cityModel];
    
    NSLog(@"totalArr == %@",totalArr);
    //移除View在重绘
    HAAddCarImageView *tempView = (HAAddCarImageView *)[self.view viewWithTag:100];
    if (tempView) {
        [tempView removeFromSuperview];
    }
    HAAddCarImageView *addCarImageView = [[HAAddCarImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) andAddCarInfoArr:totalArr andEditor:userInput andType:type];
    addCarImageView.tag = 100;
    addCarImageView.delegate = self;
    [self.view addSubview:addCarImageView];
}

//删除按钮后 重新绘制界面
- (void)deleteButtonAgainView:(UIButton *)sender{
    UILabel *label = sender.titleLabel;
    for (int i = 0; i < totalArr.count; i++) {
        HAViolationCitysParameResult *cityModel = [totalArr objectAtIndex:i];
        if ([cityModel.city_name isEqualToString:label.text]) {
            [totalArr removeObject:[totalArr objectAtIndex:i]];
        }
        
    }
    //移除View在重绘
    HAAddCarImageView *tempView = (HAAddCarImageView *)[self.view viewWithTag:100];
    if (tempView) {
        [tempView removeFromSuperview];
    }
    HAAddCarImageView *addCarImageView = [[HAAddCarImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) andAddCarInfoArr:totalArr andEditor:userInput andType:type];
    addCarImageView.tag = 100;
    addCarImageView.delegate = self;
    [self.view addSubview:addCarImageView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

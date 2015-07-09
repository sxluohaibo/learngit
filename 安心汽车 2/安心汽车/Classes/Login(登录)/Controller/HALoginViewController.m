//
//  HALoginViewController.m
//  安心汽车
//
//  Created by un2lock on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HALoginViewController.h"
#import "HAUserParam.h"
#import "HAUserResult.h"
#import "HAregisteViewController.h"
#import "HAUserTool.h"
#import "HAUITabBarController.h"
#import "HACarInfo.h"
#import "HABeanLoginUserInfo.h"
#import "HAUserDefalutTool.h"
#import "HAUserInfoModel.h"
#import "NSObject+MJKeyValue.h"
#import "HAMineLoveCarDBOperator.h"

#define MariginValue 30
@interface HALoginViewController ()
@property(nonatomic,weak) UITextField *userAccount;
@property(nonatomic,weak) UITextField *userPwd;
@end

@implementation HALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=HAColor(33, 60, 89);
    
    //输入框
    CGFloat FiledX=MariginValue;
    CGFloat FiledY=35;
    CGFloat FiledW=ScreenWidth - 2 * MariginValue;
    CGFloat FiledH=45;
    UITextField *userAccount=[[UITextField alloc] initWithFrame:CGRectMake(FiledX,FiledY, FiledW, FiledH)];
    userAccount.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"输入手机号" attributes:@{NSForegroundColorAttributeName: HAColor(131, 182, 223)}];
    userAccount.font=[UIFont systemFontOfSize:17];
    userAccount.textColor=HAColor(131, 182, 223);
    UIImageView *leftImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 27)];
    leftImageView.image=[UIImage imageNamed:@"mobile_icon"];
    leftImageView.contentMode=UIViewContentModeScaleAspectFit;
    userAccount.leftView=leftImageView;
    userAccount.leftViewMode=UITextFieldViewModeAlways;
    userAccount.textAlignment=NSTextAlignmentLeft;
    userAccount.keyboardType=UIKeyboardTypePhonePad;
    userAccount.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.userAccount=userAccount;
    userAccount.delegate=self;
    [self.view addSubview:userAccount];
    //分隔线一
    CGFloat line1Y=CGRectGetMaxY(userAccount.frame) + 3;
    UIImageView *line1=[[UIImageView alloc] initWithFrame:CGRectMake(userAccount.x + 5, line1Y, userAccount.width -5 , 1)];
    line1.image=[UIImage imageNamed:@"line_bar"];
    [self.view addSubview:line1];
    
    //密码框
    CGFloat userPwdY=CGRectGetMaxY(line1.frame) + 10;
    UITextField *userPwd=[[UITextField alloc] initWithFrame:CGRectMake(FiledX,userPwdY, FiledW, FiledH)];
    userPwd.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"输入您的密码" attributes:@{NSForegroundColorAttributeName: HAColor(131, 182, 223)}];;
    userPwd.font=[UIFont systemFontOfSize:17];
    userPwd.textColor=HAColor(131, 182, 223);
    UIImageView *userPwdleftImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
    userPwdleftImageView.image=[UIImage imageNamed:@"psw_icon"];
    userPwdleftImageView.contentMode=UIViewContentModeScaleAspectFit;
    userPwd.leftView=userPwdleftImageView;
    userPwd.leftViewMode=UITextFieldViewModeAlways;
    userPwd.textAlignment=NSTextAlignmentLeft;
    userPwd.secureTextEntry=YES;
    userPwd.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.userPwd=userPwd;
    [self.view addSubview:userPwd];
    
    //分隔线二
    CGFloat line2Y=CGRectGetMaxY(userPwd.frame) + 3;
    UIImageView *line2=[[UIImageView alloc] initWithFrame:CGRectMake(userPwd.x + 5, line2Y, userPwd.width -5 , 1)];
    line2.image=[UIImage imageNamed:@"line_bar"];
    [self.view addSubview:line2];
    
    //登录
    CGFloat registBtnX=userAccount.x;
    CGFloat registBtnY=CGRectGetMaxY(line2.frame) + 30;
    CGFloat registBtnW=userAccount.width;
    CGFloat registBtnH=45;
    UIButton *registBtn=[[UIButton alloc] initWithFrame:CGRectMake(registBtnX, registBtnY, registBtnW, registBtnH)];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"login_bar1"] forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"login_bar_select1"] forState:UIControlStateHighlighted];
    [registBtn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:registBtn];
    
    //注册
    CGFloat loginBtnX=userAccount.x;
    CGFloat loginBtnY=CGRectGetMaxY(registBtn.frame) + 15;
    CGFloat loginBtnW=userAccount.width;
    CGFloat loginBtnH=45;
    UIButton *loginBtn=[[UIButton alloc] initWithFrame:CGRectMake(loginBtnX, loginBtnY, loginBtnW, loginBtnH)];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"reg_bar"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"reg_bar_select"] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:loginBtn];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
}

-(void)backAction{
    if (ApplicationDelegate.loginType == 1) {//违章
        [self.navigationController popViewControllerAnimated:YES];//返回到违章的界面
    }else if (ApplicationDelegate.loginType == 3){//预约保养
        [self.navigationController popViewControllerAnimated:YES];//返回到主界面
    }else if (ApplicationDelegate.loginType == 2){//咨询服务
        [self.navigationController popViewControllerAnimated:YES];//资讯服务
    }else if (ApplicationDelegate.loginType == 5){//我的爱车
        [UIView transitionWithView:ApplicationDelegate.bkImageview duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            ApplicationDelegate.bkImageview.alpha = 0.5;
        } completion:^(BOOL finished) {
        }];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (ApplicationDelegate.loginType == 6){//我的爱车第二种登录
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];  //关闭键盘
}
/**
 *  用户注册
 */
-(void)regist{
    HAregisteViewController *registVc=[[HAregisteViewController alloc] init];
//    registVc.modalInPopover=YES;
//    [self presentViewController:registVc animated:YES completion:nil];
    [self.navigationController pushViewController:registVc animated:YES];
}
/**
 *  登录逻辑
 */
-(void)login{
    NSString *userName= _userAccount.text;
    if(userName.length <= 0 || [userName isEqualToString:@""]){
        [MBProgressHUD showError:@"帐号不能为空"];
        return ;
    }
    if(![self checkTel:userName]){
        [MBProgressHUD showError:@"帐号必须是手机号"];
        _userAccount.text=@"";
        return ;
    }
    NSString *userPwd= _userPwd.text;
    if(userPwd.length <= 0 || [userPwd isEqualToString:@""]){
        [MBProgressHUD showError:@"密码不能为空"];
        return ;
    }
    if(userPwd.length<6){
        [MBProgressHUD showError:@"密码少于6位"];
        _userPwd.text=@"";
        return ;
    }
    [MBProgressHUD showMessage:@"正在登录中"];
    HAUserParam *params=[[HAUserParam alloc] init];
    params.userAccount=userName;
    params.password=userPwd;
    [HAUserTool login:params success:^(HAUserResult *result) {
        NSLog(@"result == %@",result);
        [MBProgressHUD hideHUD];
        if([result.result isEqualToString:@"success"]){
            [MBProgressHUD showSuccess:@"登录成功"];
            //数据保存到数据库
            [[HABeanLoginUserInfo shareLoginUserInfo] addLoginUserInfoData:result param:params userNo:result.userInfo.userNo];
            [[NSUserDefaults standardUserDefaults] setObject:result.userInfo.userNo forKey:LoginUserNo];//保存电话号码和userNumber
            [[NSUserDefaults standardUserDefaults] setObject:userName forKey:LoginUserPhonenumer];
            
            //发送个推注册码
            NSString * clientId = [[NSUserDefaults standardUserDefaults] objectForKey:@"clientId"];
            if (clientId) {
                AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
                manager.responseSerializer=[AFHTTPResponseSerializer serializer];
                NSMutableDictionary * parame = [NSMutableDictionary dictionary];
                /**1userNo appType clientId appVersion*/
                parame[@"userNo"] = result.userInfo.userNo;
                parame[@"appType"] = @(1);
                parame[@"clientId"] =clientId;
                //2.获取应用版本号
                float localVersion=[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue];
                parame[@"appVersion"] = @(localVersion);
                //3.发送给服务器
                [manager POST:@"http://file.ywsoftware.com:9090/T100040/login/loginBand" parameters:parame success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    
                    NSLog(@"success ==%@",responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"error==%@",error);
                }];
            }
            
            [self getUserCarData];//获取车辆信息
        }else{
            [MBProgressHUD showError:result.result];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD showError:@"网络异常，请检查网络"];
        });
    }];
}

//获取用户的登陆车辆信息
- (void)getUserCarData{
    [HAUserTool carInfo:nil success:^(HACarInfoResult *result) {
        if ([result.resultCode integerValue] == 1) {
            //研保的车加入数据库
            HACarResult * carInfos = result.carResult;
            NSString * lNO = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo];
            BOOL ishave = [HAMineLoveCarDBOperator exqueryFMDBWithCondition:lNO andCarNumber:carInfos.carNo];
            if (!ishave) {
                NSString * sql = [NSString stringWithFormat:@"insert into t_carport (LoginUserNo,carInfo,carType,DateText,carNumber,isCooperation) values('%@','%@','%@','%@','%@',%d);",[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo],carInfos.carBand,carInfos.carBand,carInfos.carbuyDate,carInfos.carNo,YES];
                [HAMineLoveCarDBOperator insertIntoFMDBWithSql:sql];
            }
            [[HACarInfo shareCarInfo] addCarInfoData:result andUserNo:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]];
            if (ApplicationDelegate.loginType == 1) {//违章
                [self.navigationController popViewControllerAnimated:YES];
            }else if (ApplicationDelegate.loginType == 3){//预约保养
                [self.navigationController popViewControllerAnimated:YES];
            }else if (ApplicationDelegate.loginType == 2){//咨询服务
                [self.navigationController popViewControllerAnimated:YES];
            }else if (ApplicationDelegate.loginType == 5){//我的爱车
                HALoveCarViewController *loveVc = [[HALoveCarViewController alloc] init];
                [self.navigationController pushViewController:loveVc animated:YES];
            }else if (ApplicationDelegate.loginType == 6){//我的爱车第二种登录
                HALoveCarViewController *loveVc = [[HALoveCarViewController alloc] init];
                [self.navigationController pushViewController:loveVc animated:YES];
            }
        }else{
            if (ApplicationDelegate.loginType == 1) {//违章
                [self.navigationController popViewControllerAnimated:YES];
            }else if (ApplicationDelegate.loginType == 3){//预约保养
                [self.navigationController popViewControllerAnimated:YES];
            }else if (ApplicationDelegate.loginType == 2){//咨询服务
                [self.navigationController popViewControllerAnimated:YES];
            }else if (ApplicationDelegate.loginType == 5){//我的爱车
                HALoveCarViewController *loveVc = [[HALoveCarViewController alloc] init];
                [self.navigationController pushViewController:loveVc animated:YES];
            }else if (ApplicationDelegate.loginType == 6){//我的爱车第二种登录
                HALoveCarViewController *loveVc = [[HALoveCarViewController alloc] init];
                [self.navigationController pushViewController:loveVc animated:YES];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}

/**
 *  验证手机号的正则表达式
 */
-(BOOL)checkTel:(NSString *) phoneNumber{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    if (!isMatch) {
        return NO;
    }
    return YES;
}
#pragma mark UITextFieldDelegate的实现方法
/**
 *  限制输入框的长度
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.userAccount) {
        //如果输入的手机号大于11
        if (textField.text.length > 11) return NO;
    }
    return YES;
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.userAccount) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}
@end

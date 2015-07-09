//
//  HAChangPwdViewController.m
//  安心汽车
//
//  Created by un2lock on 15/4/13.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAChangPwdViewController.h"
#import "HAUserParam.h"
#import "HAUserResult.h"
#import "HAregisteViewController.h"
#import "HAUserTool.h"
#import "HAUserDefaultTool.h"

@interface HAChangPwdViewController ()
/**手机号*/
@property(nonatomic,weak) UITextField *phoneText;
/**老密码*/
@property(nonatomic,weak) UITextField *oldPwdText;
/**密码*/
@property(nonatomic,weak) UITextField *nPwdText;
/**重复密码*/
@property(nonatomic,weak) UITextField *rNewPwdText;
@end

@implementation HAChangPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor grayColor];
    //添加用户名和密码框
    UITextField *phoneText=[self createTextFiled:@"account_btnRegist" placeText:@"请输入手机号码" labelName:@"手机号码"];
    UILabel *phoneTextSplit=[[UILabel alloc] initWithFrame:CGRectMake(0, phoneText.y+phoneText.height-1, phoneText.width, 1)];
    phoneTextSplit.backgroundColor=[UIColor grayColor];
    [phoneText addSubview:phoneTextSplit];
    phoneText.y=40;
    phoneText.text=[HAUserDefaultTool getValueWithKey:@"userName"];
    self.phoneText=phoneText;
    [self.view addSubview:phoneText];
    
    UITextField *oldPwdText=[self createTextFiled:@"account_btnRegist" placeText:@"请输入原密码" labelName:@"原密码"];
    UILabel *oldPwdTextSplit=[[UILabel alloc] initWithFrame:CGRectMake(0, oldPwdText.y+oldPwdText.height-1, oldPwdText.width, 1)];
    oldPwdTextSplit.backgroundColor=[UIColor grayColor];
    [oldPwdText addSubview:oldPwdTextSplit];
    oldPwdText.y=75;
    oldPwdText.secureTextEntry=YES;
    self.oldPwdText=oldPwdText;
    [self.view addSubview:oldPwdText];
    
    UITextField *nPwdText=[self createTextFiled:@"account_btnRegist" placeText:@"请输入新密码" labelName:@"新密码"];
    UILabel *npwdTextSplit=[[UILabel alloc] initWithFrame:CGRectMake(0, nPwdText.y+nPwdText.height-1, nPwdText.width, 1)];
    npwdTextSplit.backgroundColor=[UIColor grayColor];
    [nPwdText addSubview:npwdTextSplit];
    nPwdText.y=110;
    nPwdText.secureTextEntry=YES;
    self.nPwdText=nPwdText;
    [self.view addSubview:nPwdText];
    
    UITextField *rNewPwdText=[self createTextFiled:@"account_btnRegist" placeText:@"重复密码" labelName:@"重复密码"];
    UILabel *rNPwdTextSplit=[[UILabel alloc] initWithFrame:CGRectMake(0, rNewPwdText.y+rNewPwdText.height-1, rNewPwdText.width, 1)];
    rNPwdTextSplit.backgroundColor=[UIColor grayColor];
    [rNewPwdText addSubview:rNPwdTextSplit];
    rNewPwdText.y=145;
    rNewPwdText.secureTextEntry=YES;
    self.rNewPwdText=rNewPwdText;
    [self.view addSubview:rNewPwdText];
    
    //添加确认注册
    UIButton *changePwdBtn=[self createButton:@"修改密码" imageName:@"account_btnRegist"];
    changePwdBtn.x=20;
    changePwdBtn.y=200;
    changePwdBtn.width=ScreenWidth * 0.9;
    changePwdBtn.height=47;
    [changePwdBtn setBackgroundImage:[UIImage imageNamed:@"regist_bg"] forState:UIControlStateNormal];
    [changePwdBtn addTarget:self action:@selector(changePwd) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:changePwdBtn];
    
}
/*
 修改密码
 */
-(void) changePwd{
    NSString *userOldPwd= _oldPwdText.text;  //原密码
    NSString *userNpwd= _nPwdText.text;  //新密码
    if(userOldPwd.length <= 0 || [userOldPwd isEqualToString:@""]){
        [MBProgressHUD showError:@"原密码不能为空"];
        return ;
    }
    if(userNpwd.length <= 0 || [userNpwd isEqualToString:@""]){
        [MBProgressHUD showError:@"新密码不能为空"];
        return ;
    }
    if(userNpwd.length < 6){
        [MBProgressHUD showError:@"新密码不能小于6位"];
        return ;
    }
     NSString *userRNpwd=_rNewPwdText.text;  //重复新密码
    if(userRNpwd.length <= 0 || [userRNpwd isEqualToString:@""]){
        [MBProgressHUD showError:@"重复密码不能为空"];
        return ;
    }
    if(![userNpwd isEqualToString:userRNpwd]){
        [MBProgressHUD showError:@"新密码与重复密码不相同"];
        return ;
    }
    HAUserParam *paramCheck=[[HAUserParam alloc] init];
    paramCheck.userAccount=_phoneText.text;
    paramCheck.password=userOldPwd;
    [HAUserTool checkOldPwd:paramCheck success:^(HAUserResult *result1) {
        //验证密码
        if(result1.resultCode){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                HAUserParam *params=[[HAUserParam alloc] init];
                params.userAccount=_phoneText.text;
                params.password=userNpwd;
                [HAUserTool changePwd:params success:^(HAUserResult *result2) {
                    NSLog(@"result%@",result2.resultCode);
#warning TODO  失败成功跳转:未做
                } failure:^(NSError *error) {
                    
                }];

            });
        }else{
            [MBProgressHUD showError:result1.result];
        }
        
    } failure:^(NSError *error) {
        
    }];
}
/**
 *  创建用户和密码等输入框
 */
-(UITextField *) createTextFiled:(NSString *) imageName placeText:(NSString *)placeText labelName:(NSString *) labelName{
    UITextField *filed=[[UITextField alloc] init];
    filed.x=0;
    filed.width=ScreenWidth;
    filed.height=35;
    
    [filed setBackgroundColor:[UIColor whiteColor]];
    filed.placeholder=placeText;
    filed.font=[UIFont systemFontOfSize:14];
    UILabel *leftLabel=[[UILabel alloc] init];
    [leftLabel setText:labelName];
    CGFloat leftLabelW=leftLabel.text.length * 20;
    leftLabel.frame=CGRectMake(0, 0, leftLabelW, filed.frame.size.height);
    leftLabel.font=[UIFont systemFontOfSize:14];
    filed.leftView=leftLabel;
    [filed.leftView setContentMode:UIViewContentModeRight];
    filed.leftViewMode=UITextFieldViewModeAlways;
    return filed;
}
/**
 *  创建注册和取消按钮
 */
-(UIButton *) createButton:(NSString *) title imageName:(NSString *)imageName{
    UIButton *button=[[UIButton alloc] init];
    button.titleLabel.text = [UIFont systemFontOfSize:13];
    
    //    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

@end

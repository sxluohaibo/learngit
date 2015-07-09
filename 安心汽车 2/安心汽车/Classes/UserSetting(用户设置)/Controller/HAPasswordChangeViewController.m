//
//  HAPasswordChangeViewController.m
//  安心汽车
//
//  Created by un2lock on 15/5/13.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAPasswordChangeViewController.h"
#import "HAUserTool.h"
#import "HAUserParam.h"
#import "HAUserResult.h"
#define MariginValue 30
@interface HAPasswordChangeViewController ()
/**原密码*/
@property(nonatomic,weak) UITextField *passwordText;
/**新密码*/
@property(nonatomic,weak) UITextField *nPassword;
/**重复新密码*/
@property(nonatomic,weak) UITextField *rPwdText;
@end

@implementation HAPasswordChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
    self.view.backgroundColor=HAColor(33, 60, 89);
    self.title=@"修改密码";
    //添加用户名
    CGFloat FiledX=MariginValue;
    CGFloat FiledY=20;
    CGFloat FiledW=ScreenWidth - 2 * MariginValue;
    CGFloat FiledH=45;
    UITextField *passwordText=[[UITextField alloc] initWithFrame:CGRectMake(FiledX,FiledY, FiledW, FiledH)];
    passwordText.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"输入原密码" attributes:@{NSForegroundColorAttributeName: HAColor(131, 182, 223)}];
    passwordText.font=[UIFont systemFontOfSize:17];
    passwordText.textColor=HAColor(131, 182, 223);
    UIImageView *leftImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
    leftImageView.image=[UIImage imageNamed:@"psw_icon"];
    leftImageView.contentMode=UIViewContentModeScaleAspectFit;
    passwordText.leftView=leftImageView;
    passwordText.leftViewMode=UITextFieldViewModeAlways;
    passwordText.textAlignment=NSTextAlignmentLeft;
    passwordText.secureTextEntry=YES;
    passwordText.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.passwordText=passwordText;
    [self.view addSubview:passwordText];
    //分隔线一
    CGFloat line1Y=CGRectGetMaxY(passwordText.frame) + 3;
    UIImageView *line1=[[UIImageView alloc] initWithFrame:CGRectMake(passwordText.x + 5, line1Y, passwordText.width -5 , 1)];
    line1.image=[UIImage imageNamed:@"line_bar"];
    [self.view addSubview:line1];
    
    //新密码
    CGFloat captchaX=FiledX;
    CGFloat captchaY=CGRectGetMaxY(line1.frame) + 5;
    CGFloat captchaW=FiledW;
    CGFloat captchaH=FiledH;
    UITextField *nPassword=[[UITextField alloc] initWithFrame:CGRectMake(captchaX,captchaY, captchaW, captchaH)];
    nPassword.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"输入新密码" attributes:@{NSForegroundColorAttributeName: HAColor(131, 182, 223)}];
    nPassword.font=[UIFont systemFontOfSize:17];
    nPassword.textColor=HAColor(131, 182, 223);
    UIImageView *captchaleftImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
    captchaleftImageView.image=[UIImage imageNamed:@"psw_icon"];
    captchaleftImageView.contentMode=UIViewContentModeScaleAspectFit;
    nPassword.leftView=captchaleftImageView;
    nPassword.leftViewMode=UITextFieldViewModeAlways;
    nPassword.textAlignment=NSTextAlignmentLeft;
    nPassword.clearButtonMode=UITextFieldViewModeWhileEditing;
    nPassword.secureTextEntry=YES;
    _nPassword=nPassword;
    [self.view addSubview:nPassword];
    
    //分隔线二
    CGFloat line2Y=CGRectGetMaxY(nPassword.frame) + 3;
    UIImageView *line2=[[UIImageView alloc] initWithFrame:CGRectMake(passwordText.x + 5, line2Y, passwordText.width -5 , 1)];
    line2.image=[UIImage imageNamed:@"line_bar"];
    [self.view addSubview:line2];
    
    //密码框
    CGFloat pwdTextX=FiledX;
    CGFloat pwdTextY=CGRectGetMaxY(line2.frame) + 5;
    CGFloat pwdTextW=FiledW;
    CGFloat pwdTextH=FiledH;
    UITextField *rPwdText=[[UITextField alloc] initWithFrame:CGRectMake(pwdTextX,pwdTextY, pwdTextW, pwdTextH)];
    rPwdText.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"确认新密码" attributes:@{NSForegroundColorAttributeName: HAColor(131, 182, 223)}];
    rPwdText.font=[UIFont systemFontOfSize:17];
    rPwdText.textColor=HAColor(131, 182, 223);
    UIImageView *pwdTextleftImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
    pwdTextleftImageView.image=[UIImage imageNamed:@"psw_icon"];
    pwdTextleftImageView.contentMode=UIViewContentModeScaleAspectFit;
    rPwdText.leftView=pwdTextleftImageView;
    rPwdText.leftViewMode=UITextFieldViewModeAlways;
    rPwdText.secureTextEntry=YES;
    rPwdText.textAlignment=NSTextAlignmentLeft;
    rPwdText.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.rPwdText=rPwdText;
    [self.view addSubview:rPwdText];
    
    
    //分隔线三
    CGFloat line3Y=CGRectGetMaxY(rPwdText.frame) + 3;
    UIImageView *line3=[[UIImageView alloc] initWithFrame:CGRectMake(passwordText.x + 5, line3Y, passwordText.width -5 , 1)];
    line3.image=[UIImage imageNamed:@"line_bar"];
    [self.view addSubview:line3];
    
    //添加确认注册
    CGFloat regsitBtnX=FiledX;
    CGFloat regsitBtnY=CGRectGetMaxY(line3.frame) + 5;
    CGFloat regsitBtnW=FiledW;
    CGFloat regsitBtnH=FiledH;
    UIButton *changBtn=[[UIButton alloc] initWithFrame:CGRectMake(regsitBtnX, regsitBtnY, regsitBtnW, regsitBtnH)];
    
    [changBtn setBackgroundImage:[UIImage imageNamed:@"enter_bar"] forState:UIControlStateNormal];
    [changBtn setBackgroundImage:[UIImage imageNamed:@"enter_bar"] forState:UIControlStateHighlighted];
    [changBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [changBtn setTitle:@"修改密码" forState:UIControlStateHighlighted];
    changBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [changBtn addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:changBtn];
}
-(void) changeClick:(UIButton *)sender{
    //修改密码
    NSString *passwordText= _passwordText.text;
    if(passwordText.length <= 0 || [passwordText isEqualToString:@""]){
        [MBProgressHUD showError:@"请输入原密码"];
        return ;
    }
    NSString *nPwdText=_nPassword.text;
    if(nPwdText.length<6){
        [MBProgressHUD showError:@"新密码少于6位"];
        return ;
    }
    NSString *rPwdText=_rPwdText.text;
    if(![rPwdText isEqualToString:nPwdText]){
        [MBProgressHUD showError:@"两次密码不一致"];
        return ;
    }
    if([passwordText isEqualToString:nPwdText]){
        [MBProgressHUD showError:@"原密码与新密码一致，不给予修改"];
        return ;
    }
    HAUserParam *oldCheck=[[HAUserParam alloc] init];
    NSString *userAccout=[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo];
    oldCheck.userNo=userAccout;
    oldCheck.password=passwordText;
    [HAUserTool checkOldPwd:oldCheck success:^(HAUserResult *result) {
        if([@"success" isEqualToString:result.result]){
            HAUserParam *param=[[HAUserParam alloc] init];
            param.userNo=userAccout;
            param.password=rPwdText;
            [HAUserTool changePwd:param  success:^(HAUserResult *result) {
                if([@"success" isEqualToString:result.result]){
                    [MBProgressHUD showError:@"密码修改成功"];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self dismissViewControllerAnimated:YES completion:nil];
                    });
                }else{
                    [MBProgressHUD showError:result.result];
                }
            } failure:^(NSError *error) {
                
            }];
        }else{
            [MBProgressHUD showError:result.result];
        }
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"本机网络不稳定，请稍候再试"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
    
}
-(void) back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

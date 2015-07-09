//
//  HAregisteViewController.m
//  安心汽车
//
//  Created by un2lock on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAregisteViewController.h"
#import "JKCountDownButton.h"
#import "HAUserTool.h"
#import "HAUserParam.h"
#import "HAUserResult.h"
#define MariginValue 30
@interface HAregisteViewController ()<UITextFieldDelegate>
/**手机号*/
@property(nonatomic,weak) UITextField *phoneText;
/**呢称*/
@property(nonatomic,weak) UITextField *nickText;
/**密码*/
@property(nonatomic,weak) UITextField *pwdText;
/**重复密码*/
@property(nonatomic,weak) UITextField *rPwdText;
/**验证码*/
@property(nonatomic,weak) UITextField *captcha;
/**验证码按钮*/
@property(nonatomic,weak) UIButton *captchaBtn;
@end

@implementation HAregisteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=HAColor(33, 60, 89);
    
    //添加用户名
    CGFloat FiledX=MariginValue;
    CGFloat FiledY=20;
    CGFloat FiledW=ScreenWidth - 2 * MariginValue;
    CGFloat FiledH=45;
    UITextField *phoneText=[[UITextField alloc] initWithFrame:CGRectMake(FiledX,FiledY, FiledW, FiledH)];
    phoneText.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"输入手机号" attributes:@{NSForegroundColorAttributeName: HAColor(131, 182, 223)}];
    phoneText.font=[UIFont systemFontOfSize:17];
    phoneText.textColor=HAColor(131, 182, 223);
    UIImageView *leftImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 27)];
    leftImageView.image=[UIImage imageNamed:@"mobile_icon"];
    leftImageView.contentMode=UIViewContentModeScaleAspectFit;
    phoneText.leftView=leftImageView;
    phoneText.leftViewMode=UITextFieldViewModeAlways;
    phoneText.textAlignment=NSTextAlignmentLeft;
    phoneText.keyboardType=UIKeyboardTypePhonePad;
    phoneText.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.phoneText=phoneText;
    phoneText.delegate=self;
    [self.view addSubview:phoneText];
    //分隔线一
    CGFloat line1Y=CGRectGetMaxY(phoneText.frame) + 3;
    UIImageView *line1=[[UIImageView alloc] initWithFrame:CGRectMake(phoneText.x + 5, line1Y, phoneText.width -5 , 1)];
    line1.image=[UIImage imageNamed:@"line_bar"];
    [self.view addSubview:line1];
    
    //添加验证码
    CGFloat captchaX=FiledX;
    CGFloat captchaY=CGRectGetMaxY(line1.frame) + 5;
    CGFloat captchaW=FiledW;
    CGFloat captchaH=FiledH;
    UITextField *captcha=[[UITextField alloc] initWithFrame:CGRectMake(captchaX,captchaY, captchaW, captchaH)];
    captcha.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"输入验证码" attributes:@{NSForegroundColorAttributeName: HAColor(131, 182, 223)}];
    captcha.font=[UIFont systemFontOfSize:17];
    captcha.textColor=HAColor(131, 182, 223);
    UIImageView *captchaleftImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
    captchaleftImageView.image=[UIImage imageNamed:@"psw_icon"];
    captchaleftImageView.contentMode=UIViewContentModeScaleAspectFit;
    captcha.leftView=captchaleftImageView;
    captcha.leftViewMode=UITextFieldViewModeAlways;
    captcha.textAlignment=NSTextAlignmentLeft;
    captcha.keyboardType=UIKeyboardTypePhonePad;
    captcha.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    
    UIButton *captchaBtn=[[UIButton alloc] init];
    captchaBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    captchaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    captchaBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [captchaBtn setBackgroundImage:[UIImage imageNamed:@"mins_bg"] forState:UIControlStateNormal];
    [captchaBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    captchaBtn.width=captchaBtn.titleLabel.text.length*20;
    captchaBtn.height=30;
    captcha.rightView=captchaBtn;
    captcha.rightViewMode=UITextFieldViewModeAlways;
    [captchaBtn addTarget:self action:@selector(getCaptcha:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:captchaBtn];
    self.captchaBtn=captchaBtn;
    self.captcha=captcha;
    [self.view addSubview:captcha];
    
    //分隔线二
    CGFloat line2Y=CGRectGetMaxY(captcha.frame) + 3;
    UIImageView *line2=[[UIImageView alloc] initWithFrame:CGRectMake(phoneText.x + 5, line2Y, phoneText.width -5 , 1)];
    line2.image=[UIImage imageNamed:@"line_bar"];
    [self.view addSubview:line2];
    
    //密码框
    CGFloat pwdTextX=FiledX;
    CGFloat pwdTextY=CGRectGetMaxY(line2.frame) + 5;
    CGFloat pwdTextW=FiledW;
    CGFloat pwdTextH=FiledH;
    UITextField *pwdText=[[UITextField alloc] initWithFrame:CGRectMake(pwdTextX,pwdTextY, pwdTextW, pwdTextH)];
    pwdText.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"输入您的密码" attributes:@{NSForegroundColorAttributeName: HAColor(131, 182, 223)}];
    pwdText.font=[UIFont systemFontOfSize:17];
    pwdText.textColor=HAColor(131, 182, 223);
    UIImageView *pwdTextleftImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
    pwdTextleftImageView.image=[UIImage imageNamed:@"psw_icon"];
    pwdTextleftImageView.contentMode=UIViewContentModeScaleAspectFit;
    pwdText.leftView=pwdTextleftImageView;
    pwdText.leftViewMode=UITextFieldViewModeAlways;
    pwdText.secureTextEntry=YES;
    pwdText.textAlignment=NSTextAlignmentLeft;
    pwdText.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.pwdText=pwdText;
    [self.view addSubview:pwdText];
    
    
    //分隔线三
    CGFloat line3Y=CGRectGetMaxY(pwdText.frame) + 3;
    UIImageView *line3=[[UIImageView alloc] initWithFrame:CGRectMake(phoneText.x + 5, line3Y, phoneText.width -5 , 1)];
    line3.image=[UIImage imageNamed:@"line_bar"];
    [self.view addSubview:line3];
    
    //重复密码
    CGFloat rPwdTextX=FiledX;
    CGFloat rPwdTextY=CGRectGetMaxY(line3.frame) + 5;
    CGFloat rPwdTextW=FiledW;
    CGFloat rPwdTextH=FiledH;
    UITextField *rPwdText=[[UITextField alloc] initWithFrame:CGRectMake(rPwdTextX,rPwdTextY, rPwdTextW, rPwdTextH)];
    rPwdText.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"再次输入您的密码" attributes:@{NSForegroundColorAttributeName: HAColor(131, 182, 223)}];
    rPwdText.font=[UIFont systemFontOfSize:17];
    rPwdText.textColor=HAColor(131, 182, 223);
    UIImageView *rpwdTextleftImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 20)];
    rpwdTextleftImageView.image=[UIImage imageNamed:@"psw_icon"];
    rPwdText.leftView=rpwdTextleftImageView;
    rpwdTextleftImageView.contentMode=UIViewContentModeScaleAspectFit;
    rPwdText.leftViewMode=UITextFieldViewModeAlways;
    rPwdText.textAlignment=NSTextAlignmentLeft;
    rPwdText.secureTextEntry=YES;
    rPwdText.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.rPwdText=rPwdText;
    [self.view addSubview:rPwdText];
    
    //分隔线四
    CGFloat line4Y=CGRectGetMaxY(rPwdText.frame) + 3;
    UIImageView *line4=[[UIImageView alloc] initWithFrame:CGRectMake(phoneText.x + 5, line4Y, phoneText.width -5 , 1)];
    line4.image=[UIImage imageNamed:@"line_bar"];
    [self.view addSubview:line4];
    
    //添加确认注册
    CGFloat regsitBtnX=FiledX;
    CGFloat regsitBtnY=CGRectGetMaxY(line4.frame) + 5;
    CGFloat regsitBtnW=FiledW;
    CGFloat regsitBtnH=FiledH;
    UIButton *registBtn=[[UIButton alloc] initWithFrame:CGRectMake(regsitBtnX, regsitBtnY, regsitBtnW, regsitBtnH)];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"reg_bar"] forState:UIControlStateNormal];
    [registBtn setBackgroundImage:[UIImage imageNamed:@"reg_bar_select"] forState:UIControlStateHighlighted];
    [registBtn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:registBtn];
    
}
/**
 *  获取验证码
 */
-(void) getCaptcha:(UIButton *)captchaBtn{
    //判断手机号是否输入正确
    NSString *userName= _phoneText.text;
    if(userName.length < 0 || [userName isEqualToString:@""]){
        [MBProgressHUD showError:@"帐号不能为空"];
        return ;
    }
    if(![self checkTel:userName]){
        [MBProgressHUD showError:@"帐号必须是手机号"];
        _phoneText.text=@"";
        return ;
    }
    HAUserParam *param=[[HAUserParam alloc] init];
    param.userAccount=userName;
    [HAUserTool getcaptcha:param success:^(HAUserResult *result) {
        
    } failure:^(NSError *error) {
        
    }];

    /*************倒计时************/
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [captchaBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
//                [captchaBtn setTitle:@"" forState:UIControlStateNormal];
//                [captchaBtn setBackgroundImage:[UIImage imageNamed:@"resent_icon"] forState:UIControlStateNormal];
                captchaBtn.userInteractionEnabled = YES;
            });
        }else{
            //            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [captchaBtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                captchaBtn.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
    
}
/**
 *  注册
 */
-(void) regist{
    NSString *userName= _phoneText.text;
    if(userName.length < 0 || [userName isEqualToString:@""]){
        [MBProgressHUD showError:@"帐号不能为空"];
        return ;
    }
    if(![self checkTel:userName]){
        [MBProgressHUD showError:@"帐号必须是手机号"];
        _phoneText.text=@"";
        return ;
    }
    NSString *userPwd= _pwdText.text;
    NSString *userRpwd= _rPwdText.text;
    if(userPwd.length < 0 || [userPwd isEqualToString:@""]){
        [MBProgressHUD showError:@"密码不能为空"];
        return ;
    }
    if(userPwd.length<6){
        [MBProgressHUD showError:@"密码少于6位"];
        _pwdText.text=@"";
        _rPwdText.text=@"";
        return ;
    }
    if(![userPwd isEqualToString:userRpwd]){
        [MBProgressHUD showError:@"两次密码不正确"];
        return ;
    }
    NSString *captchaText=_captcha.text;
    if([captchaText isEqualToString:@""] || captchaText.length<0){
        [MBProgressHUD showError:@"请输入验证码"];
        return ;
    }
    HAUserParam *params=[[HAUserParam alloc] init];
    params.userAccount=userName;
    params.password=userPwd;
    params.phoneCode=captchaText;
    [HAUserTool registe:params success:^(HAUserResult *result) {
        if([result.result isEqualToString:@"success"]){
            [MBProgressHUD showError:@"注册成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            return ;
        }
        [MBProgressHUD showError:result.result];
        _captcha.text=@"";
    } failure:^(NSError *error) {
        [MBProgressHUD showError:@"连接网络失败,请检查网络状态"];
    }];
}
/**
 *  验证手机号的正则表达式
 */
-(BOOL) checkTel:(NSString *) phoneNumber{
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:phoneNumber];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
#pragma mark UITextFieldDelegate的实现方法
/**
 *  限制输入框的长度
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneText) {
        //如果输入的手机号大于11
        if (textField.text.length > 11) return NO;
    }
    
    return YES;
}
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.phoneText) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField==self.rPwdText){
        [textField resignFirstResponder];
    }
    
    return YES;
}
@end

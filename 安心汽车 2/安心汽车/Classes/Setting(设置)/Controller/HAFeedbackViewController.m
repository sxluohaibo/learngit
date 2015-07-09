//
//  HAFeedbackViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/22.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  意见反馈

#import "HAFeedbackViewController.h"
#import "HAFeedBackTextView.h"
#import "AFNetworking.h"


@interface HAFeedbackViewController ()

@property(nonatomic,weak)HAFeedBackTextView * feedBack;
@property(nonatomic,weak)UITextField * NUmber;
@end

@implementation HAFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"意见反馈";
    self.view.backgroundColor = [UIColor whiteColor];
    //意见反馈输入
    HAFeedBackTextView * feedBack = [[HAFeedBackTextView alloc] initWithFrame:CGRectMake(5, 0, ScreenWidth-10, 150)];
    self.feedBack = feedBack;
    feedBack.placehold = @"请在此输入你的意见和反馈";
    
    //设置分隔线
    UIView * seperate = [[UIView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(feedBack.frame)+2, ScreenWidth -10, 0.5)];
    seperate.alpha = 0.7;
    seperate.backgroundColor = [UIColor lightGrayColor];
    //联系方式
    UITextField * textNumber = [[UITextField alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(seperate.frame)+2, ScreenWidth -20, 30)];
    textNumber.placeholder = @"请输联系方式，QQ/Email/手机号码";
    textNumber.delegate = self;
    textNumber.borderStyle = UITextBorderStyleRoundedRect;
    textNumber.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.NUmber = textNumber;
    // 发送按钮
    UIButton * sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendBtn setTitle:@"确认发送" forState:UIControlStateNormal];
    [sendBtn setBackgroundImage:[UIImage imageNamed:@"enter_bar"] forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sendBtn.frame = CGRectMake(10, CGRectGetMaxY(textNumber.frame)+10, ScreenWidth - 20, 44);
    [sendBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:seperate];
    [self.view addSubview:feedBack];
    [self.view addSubview:textNumber];
    [self.view addSubview:sendBtn];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
}

//返回的按钮
- (void)backAction:(UIButton *)sender{
    [UIView transitionWithView:ApplicationDelegate.bkImageview duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        ApplicationDelegate.bkImageview.alpha = 0.5;
    } completion:^(BOOL finished) {
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)btnClick{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary * parame = [NSMutableDictionary dictionary];
    if (self.NUmber.text.length == 0 || self.feedBack.text.length == 0) {
        
        [MBProgressHUD showError:@"意见和联系方式都不能"];
        return;
    }
    parame[@"phoneNo"] = self.NUmber.text;
    NSLog(@"%@",parame[@"phoneNo"]);
    parame[@"content"] = self.feedBack.text;
    NSLog(@"%@",parame[@"content"]);
    [manager POST:@"http://file.ywsoftware.com:9090/T100040/advice/addAdvice" parameters:parame success:^(AFHTTPRequestOperation *operation, id responseObject) {
        

        [MBProgressHUD showMessage:@"正在发送中。。"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"发送成功"];

        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUD];
    }];
    
    self.NUmber.text = nil;
    self.feedBack.text = nil;
    
}

//点击return 按钮 去掉
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end

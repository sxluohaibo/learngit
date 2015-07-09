//
//  QuestionAddViewController.m
//  提问列表demo1
//
//  Created by un2lock on 15/4/23.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "QuestionAddViewController.h"
#import "QuestionDetailViewController.h"
@interface QuestionAddViewController ()
@property(nonatomic,strong) AFHTTPRequestOperationManager *mrg;
@property(nonatomic,strong) UITextView *textView;
@end

@implementation QuestionAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor blackColor];
    UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(0, 40, 300, 200)];
    textView.backgroundColor=[UIColor whiteColor];
    _textView=textView;
    [self.view addSubview:textView];
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(130, 300, 50, 50)];
    button.titleLabel.text=@"联系客服";
    button.backgroundColor=[UIColor greenColor];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

-(void)clickButton{
    //提交
    self.mrg=[[AFHTTPRequestOperationManager alloc] init];
    _mrg.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userNo"] = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo];
    params[@"question"]=_textView.text;
    NSString *url=[NSString stringWithFormat:@"%@consult/ask",MainURL];
    [_mrg GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSString *questionIdStr=dict[@"questionId"];
        if(questionIdStr!=nil){
            QuestionDetailViewController *vc=[[QuestionDetailViewController alloc] init];
            vc.questionIdStr=questionIdStr;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            HALog(@"提交问题失败");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HALog(@"error");
    }];
    
//    //跳转
}
@end

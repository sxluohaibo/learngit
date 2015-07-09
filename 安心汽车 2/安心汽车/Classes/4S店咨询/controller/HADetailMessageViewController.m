//
//  HADetailMessageViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/29.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  咨询详情界面

#import "HADetailMessageViewController.h"
#import "HA4SInfoTool.h"
#import "HADetailResult.h"


#define margin 5
#define  iconViewSize 80
#define  ContentSize 11  //咨询详情
#define titleSize 12  //咨询详情标题字体大小
@interface HADetailMessageViewController ()

/**图像*/
@property(nonatomic,weak)UIImageView * iconView;

/**新闻标题*/
@property(nonatomic,weak)UILabel * newtitle;

/**详细标题*/
@property(nonatomic,weak)UILabel * detailtitle;


/**时间*/
@property(nonatomic,weak)UILabel * timeTitle;


/**咨询详情*/
@property(nonatomic,strong)NSArray * message;

/**咨询详情*/
@property(nonatomic,strong)HADetailResult * result;
@end

@implementation HADetailMessageViewController
@synthesize newId;

+ (HADetailMessageViewController *) Message:(NSInteger)newId
{
    HADetailMessageViewController * vc = [[self alloc] init];
    vc.newId = newId;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [HA4SInfoTool store4SDetailMessage:newId success:^(HADetailResult * result) {
        self.result = result;
        NSLog(@"self == %@",self.result.content);
        //添加详情界面的控件
        [self setupNew];
    } failure:^(NSError *error) {
        [MBProgressHUD showError:[NSString stringWithFormat:@"%@",error]];
        NSLog(@"error:%@",error);
    }];
}

/**
 *  添加详情界面的控件
 */
- (void)setupNew{
    self.title = @"资讯详情";
    UIView * newView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    [self.view addSubview:newView];
    
    UILabel *titleName = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, ScreenWidth, 12)];
    titleName.textColor = HAColor(47, 92, 143);
    titleName.textAlignment = NSTextAlignmentLeft;
    titleName.text = self.result.title;
    titleName.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
    [newView addSubview:titleName];
    
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 35, ScreenWidth, 12)];
    descriptionLabel.textColor = RGBA(114, 135, 160, 1);
    descriptionLabel.text = self.result.updateTime;
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.font = [UIFont systemFontOfSize:10.0f];
    [newView addSubview:descriptionLabel];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 50, ScreenWidth-20, ScreenHeight)];
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    [webView loadHTMLString:self.result.content baseURL:nil];
    [self.view addSubview:webView];
}

@end

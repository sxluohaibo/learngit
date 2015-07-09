//
//  HAAnXinLiuChengViewController.m
//  安心汽车
//
//  Created by un2lock on 15/4/13.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAAnXinLiuChengViewController.h"

@implementation HAAnXinLiuChengViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"安心流程";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sub_bg.jpg"]];
    
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    webView.backgroundColor = [UIColor clearColor];
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"anxinliucheng.htm" ofType:nil];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:-2147482062 error:nil];
    [webView loadHTMLString:html baseURL:baseURL];
    [self.view addSubview:webView];
}
@end

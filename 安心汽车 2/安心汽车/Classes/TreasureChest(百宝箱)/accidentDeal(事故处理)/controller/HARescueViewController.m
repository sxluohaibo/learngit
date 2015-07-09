//
//  HARescueViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/17.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  救援

#import "HARescueViewController.h"

@interface HARescueViewController ()

@end

@implementation HARescueViewController


- (void)loadView
{
    [super loadView];
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    webView.scrollView.bounces = NO;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"firstaild" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];
    self.view = webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"紧急救援";
}

@end

//
//  HAProtectSceneController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/17.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  保护现场

#import "HAProtectSceneController.h"

@interface HAProtectSceneController ()


@end

@implementation HAProtectSceneController


- (void)loadView
{
    [super loadView];
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    webView.scrollView.bounces = NO;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"protect" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];
    self.view = webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"保护现场";
    
    
}






@end

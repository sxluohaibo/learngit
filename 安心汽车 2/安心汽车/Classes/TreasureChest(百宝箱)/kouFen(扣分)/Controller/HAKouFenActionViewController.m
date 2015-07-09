//
//  HAKouFenActionViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/13.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  扣分行为

#import "HAKouFenActionViewController.h"

@interface HAKouFenActionViewController ()


@property(nonatomic,weak)UIWebView *actionView;//网页


@end

@implementation HAKouFenActionViewController

- (void)loadView
{
    [super loadView];
    int action = 0;
    
    if ([self.htmlName isEqualToString:@"one"]) {
        
        action = 1;
    }else if ([self.htmlName isEqualToString:@"two"]){
        action = 2;
    }else if ([self.htmlName isEqualToString:@"three"]){
        action = 3;
    }else if ([self.htmlName isEqualToString:@"six"]){
        action = 6;
    }else{
        
        action =12;
    }
    
    self.title = [NSString stringWithFormat:@"一次扣%d的行为",action];
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    webView.backgroundColor = [UIColor clearColor];
    webView.scrollView.bounces = NO;
    NSString* path = [[NSBundle mainBundle] pathForResource:self.htmlName ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [webView loadRequest:request];
    webView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:webView];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sub_bg.jpg"]];
}

- (void)setHtmlName:(NSString *)htmlName{
    _htmlName = htmlName;
}


@end

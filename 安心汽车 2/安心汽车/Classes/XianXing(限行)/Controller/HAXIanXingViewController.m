//
//  HAXIanXingViewController.m
//  安心汽车
//
//  Created by un2lock on 15/3/23.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAXIanXingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AFNetworking.h"
#import "HAUserDefalutTool.h"

#define kAppViewH 80
#define kStartY   0
#define kStartX 10
#define kColCount 5
#define kAppViewY 30

@interface HAXIanXingViewController ()
@property(nonatomic,strong) NSDictionary *dict;
/**限行数据*/
@property(nonatomic,strong) NSArray *XianXingNumberArray;
/**日期数据*/
@property(nonatomic,strong) NSArray *DateArray;
@end

@implementation HAXIanXingViewController
@synthesize xianXinDic,dict;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"限行详情";
    //初始化数组
    dict= [[NSDictionary alloc] initWithObjectsAndKeys:@"beijing",@"北京市",@"chengdu",@"成都市",@"guiyang",@"贵阳市",@"lanzhou",@"兰州市",@"nanchang",@"南昌市",@"tianjin",@"天津市",@"hangzhou",@"杭州市", nil];
    self.XianXingNumberArray = [[NSArray alloc] init];
    self.DateArray = [[NSArray alloc] init];

    [self getXianXingNumberData];  //获取数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (xianXinDic) {
            self.XianXingNumberArray = [xianXinDic objectForKey:@"limitNo"];
            self.DateArray = [xianXinDic objectForKey:@"limitDate"];
            [self initXianXingView];
        }
    });
}

-(void)getXianXingNumberData{
    //http://172.16.10.18:8080/T100040/xianxin/query?cityName=%E5%85%B0%E5%B7%9E%E5%B8%82
    NSString *downName = [NSString stringWithFormat:@"/T100040/xianxin/query?cityName=%@",[HAManger HAUTF8Change:[[NSUserDefaults standardUserDefaults] objectForKey:dwCityName]]];
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:nil httpMethod:@"GET" ssl:NO];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
        xianXinDic = cityInfo;
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"失败");
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
}
/**
 *  初始化限行界面
 */
-(void) initXianXingView{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    CGFloat width=[UIScreen mainScreen ].bounds.size.width;
    CGFloat height=[UIScreen mainScreen ].bounds.size.height;
    //设置限行日期
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
    [label1 setText:@"限行通知"];
    [label1 setTextColor:[UIColor blackColor]];
    [self.view addSubview:label1];
    
    CGFloat kAppViewW= width / kColCount;
    CGFloat marginX = (self.view.bounds.size.width - kColCount * kAppViewW) / (kColCount + 1);
    for (int i = 0; i < kColCount; i++) {
        CGFloat x = marginX + i * (marginX + kAppViewW);
        CGFloat y=kAppViewY;
        // 从XIB来加载自定义视图
        UIView *appView = [[UIView alloc] initWithFrame:CGRectMake(x, y, kAppViewW, kAppViewH)];
        // 设置视图位置
        appView.layer.borderColor = [UIColor grayColor].CGColor;
        appView.layer.borderWidth = 1;
        //显示日期
        UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, kAppViewW, 10)];
        label1.textAlignment=NSTextAlignmentCenter;
        label1.font = [UIFont fontWithName:@"Helvetica" size:12];
        NSString *dateStr=[self.DateArray objectAtIndex:i+1];
        if(dateStr!=nil){
            label1.text=dateStr;
        }else{
            label1.text=@"未知日期";
        }
        [appView addSubview:label1];
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"submit"]];
        imageView.frame=CGRectMake((kAppViewW-20)/2, 30, 20,20);
        [appView addSubview:imageView];
        
        //显示限行信息
        UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(0, 60, kAppViewW, 10)];
        label2.textAlignment=NSTextAlignmentCenter;
        label2.font = [UIFont fontWithName:@"Helvetica" size:12];
        NSArray *xianArray=[self.XianXingNumberArray objectAtIndex:i+1];
        if(xianArray !=nil && xianArray.count>0){
            label2.text=[NSString stringWithFormat:@"%@和%@",[xianArray objectAtIndex:0],[xianArray objectAtIndex:1]];
        }else{
            label2.text=@"不限行";
        }
        [appView addSubview:label2];
        [self.view addSubview:appView];
    }
    UILabel *label2=[[UILabel alloc] initWithFrame:CGRectMake(0, 115, width, 30)];
    label2.text=@"限行详情";
    label2.textAlignment=NSTextAlignmentCenter;
    [label2 setTextColor:[UIColor grayColor]];
    [label2 setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:label2];
    
    UIWebView *webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 145, width, height-210)];
    [webView setBackgroundColor:[UIColor whiteColor]];
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    
    NSString *xx = [[NSUserDefaults standardUserDefaults] objectForKey:dwCityName];
    NSString *path = [[NSBundle mainBundle] pathForResource:[dict objectForKey:xx] ofType:@"htm"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [webView loadHTMLString:html baseURL:baseURL];
    
    [self.view addSubview:webView];
}
#pragma mark 懒加载
@end

//
//  HACarHelpViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/30.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACarHelpViewController.h"

#define  BTNCOUNT 4
#define BTNSIZE 63
#define TITLECOLOR 14
#define LWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface HACarHelpViewController ()<UITableViewDelegate,UITableViewDataSource>

/**保险公司电话列表*/
@property(nonatomic,strong)UITableView * callTableView;

/**紧急按钮*/
@property(nonatomic,strong)NSArray * btnName;

/**紧急电话号码*/
@property(nonatomic,strong)NSArray * btnNumber;

/**保险公司电话*/
@property(nonatomic,strong) NSMutableArray *BaoXianArrays;

@end

@implementation HACarHelpViewController

/**
 *  tableView的
 */
- (UITableView *)callTableView
{
    if (_callTableView == nil) {
        
        _callTableView = [[UITableView alloc] init];
        
        _callTableView.backgroundColor = [UIColor whiteColor];
        _callTableView.delegate = self;
        _callTableView.dataSource = self;
    }
    
    return _callTableView;
}

/**
 *  图片名称
 */
- (NSArray *)btnName
{
    if (_btnName == nil) {
        
        _btnName = [NSArray array];
        _btnName = @[@"110_icon.png",@"120_icon.png",@"122_icon.png",@"4s_icon.png"];
    }
    return _btnName;
}

/**
 *  保险公司电话
 */
- (NSMutableArray *)BaoXianArrays
{
    if (_BaoXianArrays == nil) {
        
        _BaoXianArrays = [NSMutableArray array];
        
        NSString *BaoXianplistPath = [[NSBundle mainBundle] pathForResource:@"BaoXian" ofType:@"plist"];
        _BaoXianArrays = [[NSMutableArray alloc] initWithContentsOfFile:BaoXianplistPath];
        
    }
    
    return _BaoXianArrays;
}

/**
 *  紧急电话
   改客服电话
 */
- (NSArray *)btnNumber
{
    if (_btnNumber == nil) {
        _btnNumber = [NSArray array];
        _btnNumber = @[@"110",@"120",@"122",@"4000881615"];
        
    }
    return _btnNumber;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"车辆救援";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:LWColor(49, 84, 128)};
    //设置控件
    [self setupwidget];
}


- (void)setupwidget
{
    //1
    UILabel * exigencyLable  = [[UILabel alloc] init];
    
    exigencyLable.textColor = LWColor(43,89,135);
    exigencyLable.backgroundColor = LWColor(234,234,234);
    exigencyLable.text = @"    常用紧急联系电话";
  
    exigencyLable.font = [UIFont systemFontOfSize:TITLECOLOR];
    exigencyLable.contentMode = UIViewContentModeCenter;
    CGFloat exigencyLableX = 0;
    CGFloat exigencyLableY = 0;
    CGFloat exigencyLableW = ScreenWidth;
    CGFloat exigencyLableH = 30;
    exigencyLable.frame = (CGRect){exigencyLableX,exigencyLableY,exigencyLableW,exigencyLableH};
   
    [self.view addSubview:exigencyLable];
    
    
    //2
    UIView * btnView = [[UIView alloc] init];
    btnView.backgroundColor = LWColor(240, 241, 244);
    CGFloat btnViewX = 0;
    CGFloat btnViewY = exigencyLableY + exigencyLableH;
    CGFloat btnViewW = ScreenWidth;
    CGFloat btnViewH = 94;
    btnView.frame = (CGRect){btnViewX,btnViewY,btnViewW,btnViewH};
    
    CGFloat margin = (btnViewW - BTNCOUNT * BTNSIZE) / (BTNCOUNT + 1);
    CGFloat btnY = (btnViewH - BTNSIZE) * 0.5;
    
    for (int index = 0; index < BTNCOUNT; index++) {
        
        UIButton * btn = [[UIButton alloc] init];
        btn.tag = index;
        [btn setImage:[UIImage imageNamed:self.btnName[index]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(emergencyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat btnX = (margin + BTNSIZE) * index + margin;
        btn.frame = (CGRect){btnX,btnY,BTNSIZE,BTNSIZE};
        [btnView addSubview:btn];
    }
    [self.view addSubview:btnView];
    
    //3
    UILabel * companyLable  = [[UILabel alloc] init];
    companyLable.font = [UIFont systemFontOfSize:TITLECOLOR];
    companyLable.textColor = LWColor(43,89,135);
    companyLable.backgroundColor = LWColor(234,234,234);
    companyLable.text = @"    保险公司客服电话";
    companyLable.contentMode = UIViewContentModeCenter;
    CGFloat companyLableX = 0;
    CGFloat companyLableY = btnViewY+btnViewH;
    CGFloat companyLableW = ScreenWidth;
    CGFloat companyLableH = 30;
    companyLable.frame = (CGRect){companyLableX,companyLableY,companyLableW,companyLableH};
    [self.view addSubview:companyLable];
    
    
    CGFloat tableViewX = 0;
    CGFloat tableViewY = companyLableY+companyLableH;
    CGFloat tableViewW = ScreenWidth;
    CGFloat tableViewH = ScreenHeight - tableViewY-63;
    CGRect tFrame = self.callTableView.frame;
    tFrame = (CGRect){tableViewX,tableViewY,tableViewW,tableViewH};
//    self.callTableView.backgroundColor = [UIColor redColor];
    self.callTableView.frame = tFrame;
    [self.view addSubview:self.callTableView];
    
}


/**
 *  电击紧急电话按钮打打电话
 *
 *  @param btn 点击的按钮
 */
- (void)emergencyBtnClick:(UIButton *)btn{
    
    NSString *number = self.btnNumber[btn.tag];
    NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
}

#pragma callTableView 数据原方法



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.BaoXianArrays.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"company";
    UITableViewCell *  cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43, ScreenWidth, 1)];
        lineImageView.image = [UIImage imageNamed:@"dots_divider.png"];
        [cell addSubview:lineImageView];
        
    }
    NSArray *array=[self.BaoXianArrays objectAtIndex:indexPath.row];
    cell.textLabel.text=[array objectAtIndex:0];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.text=[array objectAtIndex:1];
    
    UIButton *rightButton=[self addRightButton:cell];;
    rightButton.bounds = CGRectMake(0, 0, 30, 30);
    [rightButton setImage:[UIImage imageNamed:@"tel_icon"] forState:UIControlStateNormal];
    cell.accessoryView = rightButton;
    return cell;
}

- (UIButton *) addRightButton:(UITableViewCell *)cell{
    UIButton *rightButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    NSString *phoneNumber=cell.detailTextLabel.text;
    rightButton.tag=[phoneNumber integerValue];  //将当前电话赋值给按钮的tag
    [rightButton setImage:[UIImage imageNamed:@"call_ico"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    return rightButton;
}

/**
 *  点击按钮拔打电话
 */
-(void)callPhone:(UIButton *) button{
    NSString *number=[NSString stringWithFormat:@"%ld",(long)button.tag];
    NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
}

@end

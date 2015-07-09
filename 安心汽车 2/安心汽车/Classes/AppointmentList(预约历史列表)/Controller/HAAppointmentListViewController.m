//
//  HAAppointmentListViewController.m
//  安心汽车
//
//  Created by un2lock on 15/4/16.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAAppointmentListViewController.h"
#import "HAAppointmentCell.h"
#import "HAAppointmentListResult.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "HAAppointmentModel.h"
#import "HAAppointmentDetailsViewController.h"
#import "MJRefresh.h"
#import "HABeanLoginUserInfo.h"
#import "HAUserDefaultTool.h"
#import "MBProgressHUD.h"

#define  pageSize 5
@interface HAAppointmentListViewController ()
@property(nonatomic,strong) AFHTTPRequestOperationManager *mrg;
/**
 *HAAppointmentListResult对象的array
 */
@property(nonatomic,strong) NSMutableArray *appointSummary;
@property(nonatomic,weak) UITableView  *tableview;
@property(nonatomic,strong) NSNumber *index;
@property(nonatomic,copy) NSString *UserNo;
@property(nonatomic,assign) BOOL isRefresh;  //是否正在刷新
@end

@implementation HAAppointmentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"预约列表";
    self.tableView.height=107;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.appointSummary=[[NSMutableArray alloc] init];
    _index=@1;//默认请求第一条开始
    [_appointSummary removeAllObjects];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //获取用户信息UserNo
    NSString *UserNo = [HAUserDefaultTool getValueWithKey:LoginUserNo];
    _UserNo=UserNo;
    if(_UserNo.length<=0 || [_UserNo isEqualToString:@""] || _UserNo==nil){
        [MBProgressHUD showMessage:@"请先登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        return ;
    }
    [self setupRefresh];
}

//返回的按钮
- (void)backAction:(UIButton *)sender{
    [UIView transitionWithView:ApplicationDelegate.bkImageview duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        ApplicationDelegate.bkImageview.alpha = 0.5;
    } completion:^(BOOL finished) {
    }];
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
//#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    if(_isRefresh==YES) return;
    [MBProgressHUD showMessage:@"正在刷新最新数据"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if(_appointSummary!=nil){
            [_appointSummary removeAllObjects];
        }
        _isRefresh=YES;
        self.index=@1;
        // 1.获取数据
        [self getLastData];
        // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        [MBProgressHUD hideHUD];
        [self.tableView headerEndRefreshing];
        _isRefresh=NO;
    });
    
}

- (void)footerRereshing{
    // 1.添加数据
    if(self.index<0){
        self.index=@1;
    }
    NSNumber *index1=[NSNumber numberWithInt:([self.index intValue]+pageSize)];
    self.index=index1;
    [self getMoreData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView footerEndRefreshing];
}
/**
 *  获取网络数据
 */
-(void)getLastData{
    if(_UserNo.length<=0 || [_UserNo isEqualToString:@""] || _UserNo==nil) return;
    
    self.mrg=[[AFHTTPRequestOperationManager alloc] init];
    _mrg.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userNo"]=_UserNo;
    params[@"startIndex"]=@1;
    params[@"pageSize"]=[NSNumber numberWithInt:pageSize];
    
    NSString *URL = [HTTP_MAIN_URL stringByAppendingFormat:@"%@",@"/T100040/appointment/showAppointmentList"];
    [_mrg GET:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HAAppointmentListResult *result=[HAAppointmentListResult objectWithJSONData:responseObject];
        [_appointSummary addObjectsFromArray:result.appointSummary];
        // 刷新表格
        if(_appointSummary.count==0){
            [MBProgressHUD showError:@"您还没有任何一条预约记录"];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HALog(@"error");
        
    }];
}
-(void)getMoreData{
    if(_UserNo.length<=0 || [_UserNo isEqualToString:@""] || _UserNo==nil ) return;
    self.mrg=[[AFHTTPRequestOperationManager alloc] init];
    _mrg.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"userNo"]=[HAUserDefaultTool getValueWithKey:LoginUserNo];
    params[@"startIndex"]=self.index;
    params[@"pageSize"]=[NSNumber numberWithInt:pageSize];
    NSString *URL = [MainURL stringByAppendingFormat:@"%@",@"/appointment/showAppointmentList"];
    [_mrg GET:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HAAppointmentListResult *result=[HAAppointmentListResult objectWithJSONData:responseObject];
        if(result!=nil){
            [_appointSummary addObjectsFromArray:result.appointSummary];
            // 刷新表格
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _tableview=tableView;
    return _appointSummary.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"appointcell";
    HAAppointmentCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell=[[[NSBundle mainBundle] loadNibNamed:@"HAAppointmentCell" owner:nil options:nil] lastObject];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSInteger row=indexPath.row;
    if(_appointSummary.count>0){
        HAAppointmentModel *result=[_appointSummary objectAtIndex:row];
        cell.appointTimeLabel.text=result.appointTime;
        cell.carNoLabel.text=result.carNo;
        NSLog(@"%@",result.appointStatus);
        if([result.appointStatus isEqualToNumber:@0]){
            cell.appointStatusLabel.text=@"待处理";
            cell.appointStatusLabel.textColor=[UIColor redColor];
        }else if([result.appointStatus isEqualToNumber:@1]){
            cell.appointStatusLabel.text=@"预约成功";
            cell.appointStatusLabel.textColor=[UIColor greenColor];
            
        } else if([result.appointStatus isEqualToNumber:@2]){
            cell.appointStatusLabel.text=@"预约失败";
            cell.appointStatusLabel.textColor=[UIColor orangeColor];
        }
        cell.partnerNameLabel.text=result.partnerName;
        cell.createTimeLabel.text=result.createTime;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HAAppointmentModel *result=[_appointSummary objectAtIndex:indexPath.row];
    HAAppointmentDetailsViewController *detailView = [[HAAppointmentDetailsViewController alloc] init];
    detailView.appointmentModel = result;
    [self.navigationController pushViewController:detailView animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 107;
}

@end

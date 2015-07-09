//
//  HAMessageBoxViewController.m
//  安心汽车
//
//  Created by kongw on 15/4/24.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAMessageBoxViewController.h"
#import "MJRefresh.h"

@interface HAMessageBoxViewController ()

@end

@implementation HAMessageBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    messageArr = [[NSMutableArray alloc] init];
    self.navigationItem.title = @"消息盒子";
    pageSize = 10;
    startIndex = 1;
    //self.view.backgroundColor=[UIColor whiteColor];
    //self.tableView.height=156;
    [self setupRefresh];//刷新数据
    //self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sub_bg.jpg"]];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    //self.tableView.delegate = self;
    //self.tableView.dataSource = self;
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    [self.tableView headerBeginRefreshing];
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = @"下拉可以刷新了";
    self.tableView.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tableView.headerRefreshingText = @"正在刷新最新数据,请稍等";
    
    self.tableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tableView.footerRefreshingText = @"正在加载更多数据,请稍等";
}


#pragma mark 开始进入刷新状态
- (void)headerRereshing{
    if(messageArr!=nil){
        [messageArr removeAllObjects];
    }
    startIndex = 1;
    // 1.获取数据
    [self getData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
}

- (void)footerRereshing{
    // 1.添加数据
    startIndex = 1 + messageArr.count;
    [self getData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView footerEndRefreshing];
}

//请求数据
- (void)getData{
    NSString *downName = [NSString stringWithFormat:@"/T100040/push/showPushMsgList?userNo=%@&startIndex=%ld&pageSize=%ld",[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo],(long)startIndex,(long)pageSize];
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:nil httpMethod:@"GET" ssl:NO];
    NSLog(@"URL消息盒子 == %@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
        NSArray *tempArr = [cityInfo objectForKey:@"pushMsgList"];
        NSLog(@"这次加载了几条 %lu",(unsigned long)tempArr.count);
        for (int i = 0; i < tempArr.count; i++) {
            NSDictionary *dic = [tempArr objectAtIndex:i];
            [messageArr addObject:dic];
        }
        
        NSLog(@"messageArr == %@",messageArr);
        [self.tableView reloadData];
        //请求成功
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"失败");
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return messageArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        //tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//去掉线
        NSDictionary *dic = [messageArr objectAtIndex:indexPath.row];
        
        UILabel *titleName = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 20)];
        titleName.backgroundColor = [UIColor clearColor];
        titleName.textColor = HAColor(47, 92, 143);
        titleName.font = [UIFont systemFontOfSize:14.0f];
        titleName.text = [dic objectForKey:@"msgTitle"];
        [cell addSubview:titleName];
        
        
        UILabel *msgSummary = [[UILabel alloc] initWithFrame:CGRectMake(10, 32, 150, 20)];
        msgSummary.backgroundColor = [UIColor clearColor];
        msgSummary.font = [UIFont systemFontOfSize:12.0f];
        msgSummary.text = [dic objectForKey:@"msgSummary"];
        [cell addSubview:msgSummary];
        
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 32, 120, 20)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.font = [UIFont systemFontOfSize:12.0f];
        timeLabel.text = [dic objectForKey:@"sendTime"];
        [cell addSubview:timeLabel];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击消息");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

//
//  HAViolationListViewController.m
//  安心汽车
//
//  Created by kongw on 15/3/25.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAViolationListViewController.h"
#import "HAVioDetailController.h"
#import "MJRefresh.h"

@interface HAViolationListViewController (){

}
@end

@implementation HAViolationListViewController
@synthesize carType;
@synthesize vioArea;
//获得数据
- (void)getData{
    YTKKeyValueItem *item = [ApplicationDelegate.store getYTKKeyValueItemById:carType fromTable:VioResultDB];
    NSDictionary *dic = item.itemObject;
    if ([[dic objectForKey:@"resultcode"] integerValue] == 200) {
        vioInfoListArr = [[dic objectForKey:@"result"] objectForKey:@"lists"];
    }else{
        vioInfoListArr = [[NSMutableArray alloc] init];
    }
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //#warning 自动刷新(一进入程序就下拉刷新)
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    //[self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
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
    vioInfoListArr = [[NSMutableArray alloc] init];
    // 1.获取数据
    HAUserInputModel *input = [[HABeanUserInput shareUserInput] getUserInfoData:carType];
    if (input) {
        [self LoadDataInput:input];
    }
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"违章详情";
    [self getData];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sub_bg.jpg"]];
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.bounds.size.width, 32.0f)];
    self.tableView.tableHeaderView = tableHeaderView;
    
    UIImageView *linebk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 31.5, ScreenWidth, 0.5)];
    linebk.backgroundColor = [UIColor blackColor];
    linebk.alpha = 0.5;
    [tableHeaderView addSubview:linebk];
    
    NSInteger getMoney = 0;
    NSInteger getFen = 0;
    if (vioInfoListArr.count > 0) {
        for (int i = 0; i < vioInfoListArr.count; i++) {
            NSDictionary *dic = [vioInfoListArr objectAtIndex:i];
            NSInteger money = [[dic objectForKey:@"money"] integerValue];
            NSInteger fen = [[dic objectForKey:@"fen"] integerValue];
            getMoney += money;
            getFen += fen;
        }
    }
    
    //累计违章
    UILabel *vioNumber = [[UILabel alloc] initWithFrame:CGRectMake(14, 10, 48, 12)];
    vioNumber.textColor = HAColor(100, 120, 144);
    vioNumber.text = @"累计违章:";
    vioNumber.font = [UIFont systemFontOfSize:11.0f];
    [tableHeaderView addSubview:vioNumber];

    UILabel *numberCount = [[UILabel alloc] initWithFrame:CGRectMake(64, 10, 20, 12)];
    numberCount.textColor = HAColor(203, 80, 68);
    numberCount.text = [NSString stringWithFormat:@"%lu",(unsigned long)vioInfoListArr.count];
    numberCount.font = [UIFont systemFontOfSize:11.0f];
    [tableHeaderView addSubview:numberCount];
    
    
    //累计罚款
    UILabel *vioMoney = [[UILabel alloc] initWithFrame:CGRectMake(129, 10, 48, 12)];
    vioMoney.textColor = HAColor(100, 120, 144);
    vioMoney.text = @"累计罚款:";
    vioMoney.font = [UIFont systemFontOfSize:11.0f];
    [tableHeaderView addSubview:vioMoney];
    
    UILabel *moneyCount = [[UILabel alloc] initWithFrame:CGRectMake(179, 10, 20+10, 12)];
    moneyCount.textColor = HAColor(203, 80, 68);
    moneyCount.text = [NSString stringWithFormat:@"%lu",(unsigned long)getMoney];
    moneyCount.font = [UIFont systemFontOfSize:11.0f];
    [tableHeaderView addSubview:moneyCount];
    
    //累计扣分
    UILabel *vioFen = [[UILabel alloc] initWithFrame:CGRectMake(255, 10, 48, 12)];
    vioFen.textColor = HAColor(100, 120, 144);
    vioFen.text = @"累计扣分:";
    vioFen.font = [UIFont systemFontOfSize:11.0f];
    [tableHeaderView addSubview:vioFen];
    
    
    UILabel *fenCount = [[UILabel alloc] initWithFrame:CGRectMake(305, 10, 20,12)];
    fenCount.textColor = HAColor(203, 80, 68);
    fenCount.text = [NSString stringWithFormat:@"%lu",(unsigned long)getFen];
    fenCount.font = [UIFont systemFontOfSize:11.0f];
    [tableHeaderView addSubview:fenCount];
    
    [self setupRefresh];//刷新数据
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return vioInfoListArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HAVioDetailController *detailVc = [[HAVioDetailController alloc] init];
    detailVc.detailDic = [vioInfoListArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {

    }
    NSDictionary *dic = [vioInfoListArr objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor clearColor];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    NSString *time = [dic objectForKey:@"date"];
    NSString *title = [dic objectForKey:@"area"];
    NSString *descrption = [dic objectForKey:@"act"];
    NSString *hand = [dic objectForKey:@"handled"];
    
    //是否处理
    UILabel *handLabel = [[UILabel alloc] initWithFrame:CGRectMake(263, 15, 36, 15)];
    handLabel.backgroundColor = [UIColor clearColor];
    handLabel.textAlignment = NSTextAlignmentLeft;
    handLabel.font = [UIFont systemFontOfSize:12.0f];
    handLabel.textColor = HAColor(70, 115, 199);
    if ([hand integerValue] == 1) {
        handLabel.text = @"已处理";
    }else if ([hand integerValue] == 0){
        handLabel.text = @"未处理";
    }
    [cell addSubview:handLabel];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 14, 222, 13)];
    titleLabel.font = [UIFont systemFontOfSize:14.0f];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.text = [NSString stringWithFormat:@"%@",title];;
    [cell addSubview:titleLabel];
    
    //评论内容
    UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 32,222,11)];
    desLabel.backgroundColor = [UIColor clearColor];
    desLabel.textColor = [UIColor grayColor];
    desLabel.font = [UIFont systemFontOfSize:12.0f];
    desLabel.textAlignment = NSTextAlignmentLeft;
    desLabel.text = [NSString stringWithFormat:@"%@",descrption];;
    [cell addSubview:desLabel];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(244, 31, 55, 12)];
    timeLabel.backgroundColor = [UIColor clearColor];
    timeLabel.textColor = [UIColor grayColor];
    NSArray *timeArr = [time componentsSeparatedByString:@" "];
    timeLabel.font = [UIFont systemFontOfSize:10.0f];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    timeLabel.text = [timeArr objectAtIndex:0];
    [cell addSubview:timeLabel];
    
    UIImageView *arrowIcon = [[UIImageView alloc] initWithFrame:CGRectMake(304, 21, 7, 15)];
    arrowIcon.image = [UIImage imageNamed:@"next_icon"];
    [cell addSubview:arrowIcon];
    
    UIImageView *linebk = [[UIImageView alloc] initWithFrame:CGRectMake(0, 51.5, ScreenWidth, 0.5)];
    linebk.backgroundColor = [UIColor blackColor];
    linebk.alpha = 0.5;
    [cell addSubview:linebk];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//跳转的方法
- (void)LoadDataInput:(HAUserInputModel *)userInput{
    HAViolationCitysParameResult *relust = (HAViolationCitysParameResult *)[[HABeancity shareBeanCity] checkOneCityData:userInput.vioArea];
    NSString *cityName = relust.city_code;//城市名称
    NSString *carCard = userInput.carTypeNumber;//车牌号
    NSString *engineno = @"";
    if (userInput.engineNumber) {
        engineno = userInput.engineNumber;//发动机号
    }else{
        engineno = @"";
    }
    NSString *classno = @"";
    if (userInput.classNumber) {
        classno = userInput.classNumber;//机架号
    }else{
        classno = @"";
    }
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    [params setObject:cityName forKey:@"city"];
    [params setObject:carCard forKey:@"hphm"];
    [params setObject:engineno forKey:@"engineno"];
    [params setObject:classno forKey:@"classno"];
    //NSLog(@"222 == %@ %@ %@ %@",cityName,carCard,engineno,classno);
    NSString *downName = @"T100040/wz/query";
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:params httpMethod:@"GET" ssl:NO];
    //NSLog(@"op.url == %@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
        //NSLog(@"cityInfo == %@",cityInfo);
        if ([[cityInfo objectForKey:@"resultcode"] integerValue] == 200) {
            //保存数据
            NSArray *tempArr = [[cityInfo objectForKey:@"result"] objectForKey:@"lists"];
            NSLog(@"这次加载了几条 %lu",(unsigned long)tempArr.count);
            for (int i = 0; i < tempArr.count; i++) {
                NSDictionary *dic = [tempArr objectAtIndex:i];
                [vioInfoListArr addObject:dic];
            }
            [ApplicationDelegate.store putObject:cityInfo withId:carCard intoTable:VioResultDB];
            [self.tableView reloadData];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"加载数据失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"失败");
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
}
@end

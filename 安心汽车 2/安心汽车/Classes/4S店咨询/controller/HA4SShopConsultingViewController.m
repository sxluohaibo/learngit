//
//  HA4SShopConsultingViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/27.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  汽车资讯展示页面

#import "HA4SShopConsultingViewController.h"
#import "HA4SInfoTool.h"
#import "HA4STableViewCell.h"
#import "HA4SRequestResult.h"
#import "HA4sFrame.h"
#import "MJRefresh.h"
#import "HA4SInfoRequestParame.h"
#import "HADetailMessageViewController.h"


#define PageSize 10  //每页显示多少行

@interface HA4SShopConsultingViewController (){
    NSNumber *startIndex;
}

/**4s店咨询*/
@property(nonatomic,strong) NSMutableArray * carMessagesF;

@end

@implementation HA4SShopConsultingViewController
@synthesize proCode;

/**
 *  加载数据
 *
 */
- (NSMutableArray *)carMessagesF{
    if (_carMessagesF == nil) {
        _carMessagesF = [NSMutableArray array];
    }
    return _carMessagesF;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *bkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bkImageView.image = [UIImage imageNamed:@"sub_bg.jpg"];
    self.tableView.backgroundView = bkImageView;
    self.title = @"4S店资讯";
     //集成刷新控件
    [self setupRefresh];
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
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
//头部刷新
- (void)headerRereshing  //加载最新数据
{
    startIndex = @1;
   [self getMoreData];
    // 2.(最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView headerEndRefreshing];
}

//尾部刷新
- (void)footerRereshing{  //加载更多数据数据
    startIndex = @(1 + _carMessagesF.count);
    // 1.添加数据
    [self getMoreData];
    // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
    [self.tableView footerEndRefreshing];
}


-(void)getMoreData{
    //1、设置网络获取的参数
    HA4SInfoRequestParame * parame = [HA4SInfoRequestParame InfoRequestParameWithpartnerCode:proCode andStartIndex:startIndex andPageSize:@(PageSize)];
    //2、网络获取加载数据
    [HA4SInfoTool store4SMessage:parame success:^(NSArray * responseObject) {
        NSMutableArray * arrays = [NSMutableArray array];
        for (HA4SRequestResult * obj in responseObject) {
            HA4sFrame * frame = [HA4sFrame FrameWith4SRequestResult:obj];
            [arrays addObject:frame];
        }
        if ([startIndex intValue] == 1) {
            [_carMessagesF removeAllObjects];
            [_carMessagesF setArray:arrays];
        }else{
            [_carMessagesF addObjectsFromArray:arrays];
        }
        [self.tableView reloadData];
         
    } failure:^(NSError * error) {
        NSLog(@"error 4s店咨询:%@",error);
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carMessagesF.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        HA4sFrame *frame_4S = (HA4sFrame *)[self.carMessagesF objectAtIndex:indexPath.row];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(14, 12, 56, 50)];
        iconImage.backgroundColor = HAColor(47, 92, 143);
        [cell addSubview:iconImage];
        
        UILabel *titleName = [[UILabel alloc] initWithFrame:CGRectMake(80, 13, 225, 12)];
        titleName.textColor = HAColor(47, 92, 143);
        titleName.text = frame_4S.message.title;
        titleName.font = [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
        [cell addSubview:titleName];
        
        CGSize mydetailsize = [frame_4S.message.summary sizeWithFont:[UIFont systemFontOfSize:10.0f] constrainedToSize:CGSizeMake(225, 36)];
        
        UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 28, 225, mydetailsize.height)];
        descriptionLabel.textColor = RGBA(114, 135, 160, 1);
        descriptionLabel.text = frame_4S.message.summary;
        descriptionLabel.numberOfLines = 0;
        descriptionLabel.font = [UIFont systemFontOfSize:10.0f];
        [cell addSubview:descriptionLabel];
        
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 74, ScreenWidth, 1)];
        lineImageView.image = [UIImage imageNamed:@"dots_divider.png"];
        [cell addSubview:lineImageView];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HA4sFrame * sFrame = self.carMessagesF[indexPath.row];
    HA4SRequestResult * result = sFrame.message;
    NSLog(@"newId = %d",result.newsId);
    HADetailMessageViewController * vc = [HADetailMessageViewController Message:result.newsId];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

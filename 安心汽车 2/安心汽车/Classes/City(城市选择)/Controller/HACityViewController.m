//
//  HACityViewController.m
//  安心汽车
//
//  Created by un2lock on 15/3/19.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACityViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "HACityHostListCell.h"
#import "HANavigationController.h"
#import "HAAreaViewController.h"
#import "HAUserDefalutTool.h"

@interface HACityViewController()<UITableViewDelegate>
@property(nonatomic,strong) NSMutableArray *cityArrays;
@end

@implementation HACityViewController
@synthesize fatherVC;

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setupNav];  //设置导航栏
    [self readPlist];  //读取plist文件
}
/**
 *  设置导航栏
 */
-(void)setupNav{
    self.title=@"城市选择";
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
}
/**
 *  读取省份数据
 */
- (void)readPlist{
    self.cityArrays = [HASaveInfoByFMDB readProvincefrom];
}

/**设置每个section显示的Title */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section==0){
        return @"热门城市";
    }else{
        return @"省份";
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 44.0)];
    [customView setBackgroundColor:[UIColor colorWithRed:207/255.0 green:214/255.0 blue:210/255.0 alpha:1.0]];
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:12];
    headerLabel.frame = CGRectMake(10.0, 0.0, 50, 22);
    if (section == 0) {
        headerLabel.text =  @"热门城市";
    }else if (section == 1){
        headerLabel.text = @"省份";
    }
    [customView addSubview:headerLabel];
    
    return customView;
}
//别忘了设置高度
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22;
}

/**
 *  自动定位城市
 */
-(void)setupCity{
        UIButton *leftButton=[[UIButton alloc] init];
        [leftButton setTitle:@"城市" forState:UIControlStateNormal];
        leftButton.size=CGSizeMake(40, 44);
        [leftButton setBackgroundColor:[UIColor orangeColor]];
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:leftButton];
}
/**
 *  点击返回按钮,返回到首界面
 */
-(void)backAction:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma  mark tableview的数据源内容
/**
 *  返回显示的组数
 */
- (NSInteger )numberOfSectionsInTableView:(UITableView  *)tableView{
    return 2;
}
/**
 *  返回tableVew高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  indexPath.section == 0 ? 120 : 44;
}
/**
 *  返回显示的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : self.cityArrays.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        HACityHostListCell *cell=[[HACityHostListCell alloc] init];
        return cell;
    }else{
        static NSString *ID = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        HAProvinceModel *province = [self.cityArrays objectAtIndex:indexPath.row];
        NSString *cityName = province.name;
        cell.accessibilityHint = province.code;
        cell.textLabel.text=cityName;
        return cell;
    }
}
#pragma mark UITableViewDelegate的代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    HAAreaViewController *areaVc=[[HAAreaViewController alloc] init];
    areaVc.pcode = cell.accessibilityHint;  //传值
    [self.navigationController pushViewController:areaVc animated:YES];
}
@end

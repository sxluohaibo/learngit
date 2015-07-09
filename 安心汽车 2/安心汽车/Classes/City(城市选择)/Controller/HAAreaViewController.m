//
//  HAAreaViewController.m
//  安心汽车
//
//  Created by un2lock on 15/3/20.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAAreaViewController.h"
#import "HAUserDefalutTool.h"

@interface HAAreaViewController ()<UITableViewDelegate>
/**
 *  省份列表
 */
@property(nonatomic,strong) NSMutableDictionary *provineceDicts;
/**
 *  城市列表
 */
@property(nonatomic,strong) NSMutableArray *cityArrays;
@end

@implementation HAAreaViewController
@synthesize pcode;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self readPlist];
}
/**
 *  读取省份数据,并设置值
 */
-(void) readPlist{
    self.cityArrays = [HASaveInfoByFMDB readCityfrom:pcode];
}
/**
 *  设置导航栏
 */
-(void) setupNav{
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
/**
 *  返回省份查询界面
 */
-(void)backAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cityArrays.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    NSString *cityName=self.cityArrays[indexPath.row];
    cell.textLabel.text=cityName;
    return cell;
}
/**
 *  点击某项跳转到主界面
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    NSString *currentCityName=cell.textLabel.text;
    [self dismissViewControllerAnimated:YES completion:^{
        //存储用户选择的城市
        [[NSUserDefaults standardUserDefaults] setObject:currentCityName forKey:dwCityName];
        [[NSNotificationCenter  defaultCenter] postNotificationName:ClickHotCityName object:currentCityName];
    }];
}

@end

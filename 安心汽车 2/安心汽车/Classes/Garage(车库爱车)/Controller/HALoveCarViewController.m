//
//  HALoveCarViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/8.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  我的爱车

#import "HALoveCarViewController.h"
#import "HACarRebordViewController.h"
#import "HALoveCarModel.h"
#import "HAMineLoveCarDBOperator.h"



@interface HALoveCarViewController ()<HACarRebordViewControllerdelegate>



@property(nonatomic,strong)NSArray * loveCars;



@end

@implementation HALoveCarViewController
/**
 *  车数组懒加载
 *
 *  @return <#return value description#>
 */
- (NSArray *)loveCars
{
    if (_loveCars == nil) {
        
        _loveCars = [NSArray array];
    }
    
    return _loveCars;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置顶部导航栏样式
    [self setupNavagationBarItem];
    
    
    //添加底部按钮
    [self setupBottom];
    
    //重本地数据库中加载我的爱车数据
    _loveCars = [HAMineLoveCarDBOperator exqueryFMDBWithSql:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]];
    [self.tableView reloadData];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
}

//返回的按钮
- (void)backAction:(UIButton *)sender{
    NSLog(@"11%@",self.navigationController);
    NSLog(@"22%@",self.presentingViewController);
    NSLog(@"33%@",self.presentedViewController);
    NSLog(@"ApplicationDelegate.loginType == %ld",(long)ApplicationDelegate.loginType);
    if (ApplicationDelegate.loginType == 5) {
        [UIView transitionWithView:ApplicationDelegate.bkImageview duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            ApplicationDelegate.bkImageview.alpha = 0.5;
        } completion:^(BOOL finished) {
        }];
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }else if (ApplicationDelegate.loginType == 6){
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/**
 *  添加底部按钮
 */
- (void)setupBottom{
    UIButton * addCarBtn = [[UIButton alloc] init];
    addCarBtn.frame = CGRectMake(10, 5, ScreenWidth -20, 35);
    addCarBtn.backgroundColor = HAColor(54, 103, 152);
    [addCarBtn setTitle:@"添加我的车辆信息" forState:UIControlStateNormal];
    addCarBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [addCarBtn addTarget:self action:@selector(addCarInfo:) forControlEvents:UIControlEventTouchUpInside];
    UIView * footView = [[UIView alloc] init];
    footView.frame = CGRectMake(0, 0, 0, 60);
    [footView addSubview:addCarBtn];
    self.tableView.tableFooterView = footView;
}
/**
 *  设置顶部导航栏样式
 */
-(void)setupNavagationBarItem
{
    self.title = @"我的爱车";
    //self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:HAColor(49, 84, 128)};
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

/**
 *  导航栏游册按钮点击监听按钮
 */
-(void)addCarInfo:(UIButton*)btn{
    HACarRebordViewController * vc = [[HACarRebordViewController alloc] initWithNibName:@"HACarRebordViewController" bundle:nil];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma tableView 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.loveCars.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
        cell.detailTextLabel.textColor = HAColor(67, 100, 130);
        //分割线
        UIView * speratorView = [[UIView alloc] initWithFrame:CGRectMake(0, 46.5, ScreenWidth, 0.5)];
        speratorView.backgroundColor =  [UIColor lightGrayColor];
        speratorView.alpha = 0.5;
        cell.textLabel.textColor = HAColor(38, 67, 98);
        [cell addSubview:speratorView];
        
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imageView.image = [UIImage imageNamed:@"car_edit_icon"];
        cell.accessoryView = imageView;
    }
    
    //设置cell样式
    HALoveCarModel * loveCar = self.loveCars[indexPath.row];
    cell.textLabel.text = loveCar.carinfo;
//    cell.detailTextLabel.text =
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HACarRebordViewController * vc = [[HACarRebordViewController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
    vc.loveCarMessage = self.loveCars[indexPath.row];

}

/*删除用到的函数*/

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (editingStyle == UITableViewCellEditingStyleDelete){
       //进行删除
        [HAMineLoveCarDBOperator deleteFMDBWithSql:[NSString stringWithFormat:@"delete from t_carport where carType = '%@' and carInfo = '%@';",cell.textLabel.text,cell.detailTextLabel.text]];
       //删除后重新加载数据
        
        self.loveCars = [HAMineLoveCarDBOperator exqueryFMDBWithSql:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]];
        [self.tableView reloadData];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47.34;
}

#pragma mark - HACarRebordViewController 代理方法
/**
 *  点击添加车辆信息保存按钮
 */
- (void)CarRebordViewControllerToLoadNewDate
{
    self.loveCars = [HAMineLoveCarDBOperator exqueryFMDBWithSql:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]];
    [self.tableView reloadData];
    
}

- (void)deleteLoveCarInfoButtonClick
{
    self.loveCars = [HAMineLoveCarDBOperator exqueryFMDBWithSql:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]];
    [self.tableView reloadData];
}
@end

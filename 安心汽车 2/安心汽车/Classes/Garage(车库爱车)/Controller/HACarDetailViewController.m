//
//  HACarDetailViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/15.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  车辆详细信息

#import "HACarDetailViewController.h"
#import "HACarRebordViewController.h"
#import "AFNetworking.h"
#include "MJExtension.h"
#include "HACarYear.h"
#include "HACarClass.h"
#include "HABrandSelectViewController.h"

@interface HACarDetailViewController ()



@property(nonatomic,strong) NSArray * carClasses;
@end

@implementation HACarDetailViewController




- (void)setCarYear:(HACarYear *)carYear
{
    _carYear = carYear;
    
}


- (NSArray *)carClasses
{
    if (_carClasses==nil) {
        
        _carClasses = [NSArray array];
    }
    
    return _carClasses;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择车型";
    
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSString * url = [NSString stringWithFormat:@"http://file.ywsoftware.com:9090/T100040/carType/showCarSpecific?yearId=%ld",self.carYear.yearId];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
     
        self.carClasses = [HACarClass carClassYeadWithDictArray:responseObject];
        [self .tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
}

-(void)backAction:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carClasses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ID = @"class";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.textColor = HAColor(23, 56, 84);
    }
    
    
    HACarClass * carClass = self.carClasses[indexPath.row];
    cell.textLabel.text =[NSString stringWithFormat:@"%@%@款",carClass.specialName,self.carYear.year];
    [cell.textLabel setFont:[UIFont systemFontOfSize:13]];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HACarClass * carClass = self.carClasses[indexPath.row];
    carClass.year = self.carYear.year;
    carClass.brandName = self.carYear.brandName;
    carClass.seriesName = self.carYear.seriesName;

    for (UIViewController * aa in self.navigationController.viewControllers) {
        if ([aa isKindOfClass:[HACarRebordViewController class]]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:CarClassPickNotification object:carClass];
            [self.navigationController popToViewController:aa animated:YES];
        }
    }
    
//    for (UIViewController * tempVc in self.navigationController.viewControllers){
//        if ([tempVc isKindOfClass:[HACarRebordViewController class]]){
//            HABrandSelectViewController *brandVc = (HABrandSelectViewController *)tempVc;
//            if ([brandVc.type intValue]== 1) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:CarClassPickNotification object:carClass];
//                //                [self dismissViewControllerAnimated:YES completion:^{
//                //                }];
//                //                [self.navigationController popToViewController:tempVc animated:YES];
//            }
//            if ([brandVc.type intValue] == 2) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:MainTenanceCarTypeChoice object:carClass];
//                [self dismissViewControllerAnimated:YES completion:^{
//                }];
//            }
//        }
//    }
}

@end

//
//  HACarYearTableViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/15.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  车辆年份

#import "HACarYearTableViewController.h"
#import "AFNetworking.h"
#include "HACarSeries.h"
#include "MJExtension.h"
#include "HACarYear.h"
#import "HACarDetailViewController.h"

@interface HACarYearTableViewController ()


@property(nonatomic,strong)NSArray *years;
@end

@implementation HACarYearTableViewController


- (NSArray *)years
{
    if (_years == nil) {
        
        _years = [NSArray array];
    }
    
    return _years;
}


- (void)setCarSeries:(HACarSeries *)carSeries
{
    _carSeries =carSeries;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"车辆年代";
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSString * url = [NSString stringWithFormat:@"http://file.ywsoftware.com:9090/T100040/carType/showCarYears?seriesId=%ld",(long)self.carSeries.seriesId];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.years = [HACarYear carYeadWithDictArray:responseObject];
        [self.tableView reloadData];
        
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

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.years.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ID = @"year";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = HAColor(23, 56, 84);
    }
    HACarYear * carYear = self.years[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@款",carYear.year];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HACarYear * cyear = self.years[indexPath.row];
    cyear.seriesName = self.carSeries.seriesName;
    cyear.brandName = self.carSeries.carBrandName;
    
//    NSLog(@"yeadid%d",cyear.yearId);
    HACarDetailViewController * vc = [[HACarDetailViewController alloc] init];
    vc.carYear = cyear;
    [self.navigationController pushViewController:vc animated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

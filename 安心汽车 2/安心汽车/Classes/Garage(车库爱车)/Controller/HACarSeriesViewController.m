//
//  HACarSeriesViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/15.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  车系

#import "HACarSeriesViewController.h"
#import "HACarYearTableViewController.h"
#import "AFNetworking.h"
#import "HACarBrand.h"
#include "HACarSeries.h"
#include "MJExtension.h"

@interface HACarSeriesViewController ()


@property(nonatomic,strong)NSArray * carSerieses;

@end

@implementation HACarSeriesViewController


- (NSArray *)carSerieses
{
    if (_carSerieses==nil) {
        
        _carSerieses = [NSArray array];
    }
    
    return _carSerieses;
}


- (void)setCarBrand:(HACarBrand *)carBrand
{
    _carBrand = carBrand;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
   
    
    NSString * url = [NSString stringWithFormat:@"http://file.ywsoftware.com:9090/T100040/carType/showCarSeries?brandId=%ld",(long)self.carBrand.brandId];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        NSLog(@"%@",responseObject);
        self.carSerieses = [HACarSeries objectArrayWithKeyValuesArray:responseObject];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.carSerieses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * ID = @"carSeries";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = HAColor(23, 56, 84);
    }
    
    HACarSeries * series = self.carSerieses[indexPath.row];
    cell.textLabel.text = series.seriesName;
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HACarSeries * ser = self.carSerieses[indexPath.row];
    ser.carBrandName = self.carBrand.brandName;
    
    HACarYearTableViewController * year = [[HACarYearTableViewController alloc] init];
    year.carSeries = ser;
    
    
    [self.navigationController pushViewController:year animated:year];
    
    
    
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

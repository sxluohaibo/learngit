//
//  HAPenaltyPointsViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/13.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//  扣分表

#import "HAPenaltyPointsViewController.h"
#import "HADeduction.h"
#import "HAKouFenActionViewController.h"
#import "HACommonTableViewController.h"

@interface HAPenaltyPointsViewController ()

/**扣分行为*/
@property(nonatomic,strong)NSArray * PenaltyPointsActions;
@end

@implementation HAPenaltyPointsViewController

- (NSArray *)PenaltyPointsActions
{
    if (_PenaltyPointsActions == nil) {
        
        _PenaltyPointsActions = [NSArray array];
        
    }
    return _PenaltyPointsActions;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扣分表";
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sub_bg.jpg"]];
    //扣分行为
    [self setupData];
}

/**
 *  扣分行为
 */
- (void)setupData
{
    HADeduction *item0 = [HADeduction itemWithTitle:@"常规扣分情况" destVcClass:[HACommonTableViewController class]];

    HADeduction *item1 = [HADeduction itemWithTitle:@"一次扣12分的行为" withHtml:@"twelve" destVcClass:[HAKouFenActionViewController class]];
    HADeduction *item2 = [HADeduction itemWithTitle:@"一次扣6分的行为" withHtml:@"six" destVcClass:[HAKouFenActionViewController class]];
    HADeduction *item3 = [HADeduction itemWithTitle:@"一次扣3分的行为" withHtml:@"three" destVcClass:[HAKouFenActionViewController class]];
    HADeduction *item4 = [HADeduction itemWithTitle:@"一次扣2分的行为" withHtml:@"two" destVcClass:[HAKouFenActionViewController class]];
    HADeduction *item5 = [HADeduction itemWithTitle:@"一次扣1分的行为" withHtml:@"one" destVcClass:[HAKouFenActionViewController class]];

    self.PenaltyPointsActions= @[item0,item1,item2,item3,item4,item5];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.PenaltyPointsActions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"koufen";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    HADeduction * item = self.PenaltyPointsActions[indexPath.row];
    cell.textLabel.text = item.title;
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CellArrow"]];
    cell.accessoryView = imageView;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row==0) {
        HADeduction * item = self.PenaltyPointsActions[indexPath.row];
    [self.navigationController pushViewController:[[item.destVcClass alloc] init] animated:YES];
        
    }else{
        HADeduction * item = self.PenaltyPointsActions[indexPath.row];
         NSLog(@"dasdasd==%@",item.html);
        HAKouFenActionViewController * vc = [[item.destVcClass alloc] init];
        
        vc.htmlName = item.html;
        NSLog(@"dasdasd==%@",item.html);
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end

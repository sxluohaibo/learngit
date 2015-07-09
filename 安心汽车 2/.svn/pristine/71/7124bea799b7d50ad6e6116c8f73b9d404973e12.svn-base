//
//  HADutyViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/17.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HADutyViewController.h"
#import "HADutyCell.h"
#import "HAFrame.h"
#import "HADuty.h"

@interface HADutyViewController ()


@property(nonatomic,strong)NSArray * haFrames;


@end

@implementation HADutyViewController



- (NSArray *)haFrames
{
    if (_haFrames == nil) {
        
        _haFrames = [NSArray array];
        
        
        HADuty * da0 = [HADuty dutyWithTitle:@"    在没有信号灯的十字路口，采取右侧先行的原则。要让右侧车辆先行。A车没有让右侧的B车先行，A车承担责任" iconName:@"accident1.jpg"];
        HAFrame * aa0 = [HAFrame FrameWithDuty:da0];
        
        
        HADuty * da1 = [HADuty dutyWithTitle:@"     A车左转，B车右转。小转弯（右转）要让大转弯（左转）的车先行。B车承担责任。" iconName:@"accident2.jpg"];
        HAFrame * aa1 = [HAFrame FrameWithDuty:da1];
        
        HADuty * da2 = [HADuty dutyWithTitle:@"     变道的车辆，要让正常行驶的车辆优先通行。A车正常行驶，B车变道，B车承担责任。" iconName:@"accident3.jpg"];
        HAFrame * aa2 = [HAFrame FrameWithDuty:da2];
        
        HADuty * da3 = [HADuty dutyWithTitle:@"     两辆车变道，A车已进入车道，但B车刚刚变道，A车承担次要责任，B车承担主要责任。" iconName:@"accident4.jpg"];
        HAFrame * aa3 = [HAFrame FrameWithDuty:da3];
        
        HADuty * da4 = [HADuty dutyWithTitle:@"     B车一侧有围挡，A车一侧无围挡，B车要让A车。发送事故，B车全责。" iconName:@"accident5.jpg"];
        HAFrame * aa4= [HAFrame FrameWithDuty:da4];
        
        
        
        _haFrames = @[aa0,aa1,aa2,aa3,aa4];
    }
    
    return _haFrames;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"责任列表";
    self.tableView.userInteractionEnabled = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.haFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
  
    HADutyCell * cell = [HADutyCell cellWithTableView:tableView];
    cell.cellFram = self.haFrames[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HAFrame * fram = self.haFrames[indexPath.row];
    return (fram.cellHeight+5);
}



@end

//
//  HABaseSettingViewController.m
//  华奥移动
//
//  Created by tusm on 15-3-4.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HABaseSettingViewController.h"
#import "HASettingCell.h"
@interface HABaseSettingViewController ()

@end

@implementation HABaseSettingViewController

- (void)loadView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT+STATEBAR_HEIGHT, ScreenWidth, ScreenHeight-NAVBAR_HEIGHT-TABBAR_HEIGHT-STATEBAR_HEIGHT) style:UITableViewStyleGrouped];
    //CGRectMake(0, NAVBAR_HEIGHT+STATEBAR_HEIGHT, ScreenWidth, ScreenHeight-NAVBAR_HEIGHT-TABBAR_HEIGHT-STATEBAR_HEIGHT);
    tableView.delegate = self;
    tableView.dataSource = self;
    self.view = tableView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _allGroups = [NSMutableArray array];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    HASettingGroup *group = _allGroups[section];
    return group.items.count;
}

#pragma mark 每当有一个cell进入视野范围内就会调用，返回当前这行显示的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 1.创建一个HASettingCell
    HASettingCell *cell = [HASettingCell settingCellWithTableView:tableView];
    
    // 2.取出这行对应的模型（ILSettingItem）
    HASettingGroup *group = _allGroups[indexPath.section];
    cell.item = group.items[indexPath.row];
    return cell;
}

#pragma mark 点击了cell后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 0.取出这行对应的模型
    HASettingGroup *group = _allGroups[indexPath.section];
    HASettingItem *item = group.items[indexPath.row];
    
    // 1.取出这行对应模型中的block代码
    if (item.operation) {
        // 执行block
        item.operation();
    }
}

#pragma mark 返回每一组的header标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    HASettingGroup *group = _allGroups[section];
    return group.header;
}
#pragma mark 返回每一组的footer标题
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    HASettingGroup *group = _allGroups[section];
    return group.footer;
}

@end

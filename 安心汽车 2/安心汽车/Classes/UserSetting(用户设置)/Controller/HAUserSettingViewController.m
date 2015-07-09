//
//  HAUserSettingViewController.m
//  安心汽车
//
//  Created by un2lock on 15/5/13.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAUserSettingViewController.h"
#import "HAPasswordChangeViewController.h"
#import "HATSettingCell.h"

@interface HAUserSettingViewController ()
@property(nonatomic,strong) NSArray *settingList;
@end

@implementation HAUserSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) image:@"back" highImage:@"back"];
    // 设置右边的更多按钮
    //self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"user" highImage:@"user"];
    self.title=@"帐号设置";
    
    self.settingList=[NSArray arrayWithObjects:@"修改密码", nil];
    _tableview=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableview.contentInset=UIEdgeInsetsMake(10, 0, 0, 0);
    _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    _tableview.backgroundColor=HAColor(241, 241, 241);
    _tableview.scrollEnabled=NO;
    _tableview.delegate=self;
    _tableview.dataSource=self;
    [self.view addSubview:_tableview];
}
-(void)back{
    [UIView transitionWithView:ApplicationDelegate.bkImageview duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        ApplicationDelegate.bkImageview.alpha = 0.5;
    } completion:^(BOOL finished) {
    }];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID=@"cell";
    HATSettingCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(cell==nil){
        cell=[[HATSettingCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.imageView.image=[UIImage imageNamed:@"psw_icon"];
    cell.textLabel.text=[_settingList objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger index = indexPath.row;
    if(index==0){
        if ([[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]) {
            //修改密码
            HAPasswordChangeViewController *pwdVc=[[HAPasswordChangeViewController alloc] init];
            [self.navigationController pushViewController:pwdVc animated:YES];
        }else{
            [MBProgressHUD showError:@"请您先登录"];
        }
    }
}




@end

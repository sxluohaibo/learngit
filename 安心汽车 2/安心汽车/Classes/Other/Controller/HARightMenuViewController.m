//
//  HARightMenuViewController.m
//  安心汽车
//
//  Created by 孔伟 on 15/4/19.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HARightMenuViewController.h"
#import "HAFeedbackViewController.h"

@implementation HARightMenuViewController{
    NSArray *iconArr;
    UILabel *userName;//用户名
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        self.title = @"右侧边栏";
    }
    return self;
}

-(void)goToSubView{
    [self.viewDeckController closeRightViewBouncing:^(IIViewDeckController *controller) {
                  
    }];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@" s  %f",ScreenHeight);
    rightBk = [[UIImageView alloc] initWithFrame:CGRectMake(94, 0, ScreenWidth-94, ScreenHeight)];
    rightBk.userInteractionEnabled = YES;
    rightBk.image = [UIImage imageNamed:@"user_bg.jpg"];
    [self.view addSubview:rightBk];
    
    UIImageView *picImage = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-94-99)/2, 48, 99, 99)];
    picImage.image = [UIImage imageNamed:@"user_icon"];
    [rightBk addSubview:picImage];
    
    userName = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, ScreenWidth-94, 25)];
    userName.backgroundColor = [UIColor clearColor];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LoginUserPhonenumer]) {
        userName.text = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserPhonenumer];
    }else{
        userName.text = @"请您先登录";
    }
    userName.font = [UIFont systemFontOfSize:15.0f];
    userName.textAlignment = NSTextAlignmentCenter;
    userName.textColor = HAColor(255, 195, 82);
    [rightBk addSubview:userName];
    
    rightTableView = [[UITableView alloc] init];
    if (ScreenHeight == 480) {
        rightTableView.frame = CGRectMake(0, 184-20, ScreenWidth, ScreenHeight-184+20);
    }else{
        rightTableView.frame = CGRectMake(0, 184, ScreenWidth, ScreenHeight-184);
    }
    rightTableView.backgroundColor = [UIColor clearColor];
    rightTableView.delegate = self;
    rightTableView.dataSource = self;
    [rightBk addSubview:rightTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LoginUserPhonenumer]) {
        userName.text = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserPhonenumer];
        iconArr = [[NSArray alloc] initWithObjects:@"order_icon&我的预约",@"garage_icon&我的爱车",@"share_icon&分享",@"feedback_icon&用户反馈",@"sys_setting_icon&账号设置",@"quiet_icon&退出登录", nil];
    }else{
        userName.text = @"请您先登录";
        iconArr = [[NSArray alloc] initWithObjects:@"order_icon&我的预约",@"garage_icon&我的爱车",@"share_icon&分享",@"feedback_icon&用户反馈",@"sys_setting_icon&账号设置", nil];
    }
    [rightTableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return iconArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    NSArray *tempArr = [[iconArr objectAtIndex:indexPath.row] componentsSeparatedByString:@"&"];
    
    NSString *iconName = [tempArr objectAtIndex:0];
    NSString *iconTitle = [tempArr objectAtIndex:1];
    
    cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    cell.backgroundColor = [UIColor clearColor];
    //图标
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 9, 30, 30)];
    [cell addSubview:iconImage];
    //标题
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 9, 200, 30)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.font = [UIFont systemFontOfSize:13.0f];
    textLabel.text = iconTitle;
    textLabel.textColor = HAColor(62, 62, 62);
    [cell addSubview:textLabel];
    iconImage.image = [UIImage imageNamed:iconName];
    textLabel.text = iconTitle;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {//预约列表
        [UIView transitionWithView:ApplicationDelegate.bkImageview duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            ApplicationDelegate.bkImageview.alpha = 0.0;
        } completion:^(BOOL finished) {
            
        }];
        HAAppointmentListViewController *pointVc = [[HAAppointmentListViewController alloc] init];
        MyNavigationViewController *navigationVC=[[MyNavigationViewController alloc] initWithRootViewController:pointVc];
        [self presentViewController:navigationVC animated:YES completion:^{
            
        }];
    }else if (indexPath.row == 5){//推出登陆
        [MBProgressHUD showSuccess:@"登出成功"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:LoginUserNo];//保存电话号码和userNumber
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:LoginUserPhonenumer];
        [self goToSubView];
        [[NSNotificationCenter defaultCenter] postNotificationName:RefreshCenterView object:nil];//响应刷新的的方法
    }else if (indexPath.row == 1){//我的爱车
        [UIView transitionWithView:ApplicationDelegate.bkImageview duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            ApplicationDelegate.bkImageview.alpha = 0.0;
        } completion:^(BOOL finished) {
            
        }];
        ApplicationDelegate.loginType = 5;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]) {
            HALoveCarViewController *loveVc = [[HALoveCarViewController alloc] init];
            MyNavigationViewController *navigationVC=[[MyNavigationViewController alloc] initWithRootViewController:loveVc];
            [self presentViewController:navigationVC animated:YES completion:^{
                
            }];
        }else{
            HALoginViewController *loginVc = [[HALoginViewController alloc] init];
            MyNavigationViewController *navigationVC=[[MyNavigationViewController alloc] initWithRootViewController:loginVc];
            [self presentViewController:navigationVC animated:YES completion:^{
                
            }];
        }
    }else if (indexPath.row == 3){//用户反馈
        [UIView transitionWithView:ApplicationDelegate.bkImageview duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            ApplicationDelegate.bkImageview.alpha = 0.0;
        } completion:^(BOOL finished) {
            
        }];
        
        HAFeedbackViewController *feedVc = [[HAFeedbackViewController alloc] init];
        MyNavigationViewController *navigationVC=[[MyNavigationViewController alloc] initWithRootViewController:feedVc];
        [self presentViewController:navigationVC animated:YES completion:^{
            
        }];
    }else if (indexPath.row == 2){//分享
        [self.viewDeckController toggleRightViewAnimated:YES];
        [self shareSDK];//分享
    }else if (indexPath.row == 4){
        [UIView transitionWithView:ApplicationDelegate.bkImageview duration:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            ApplicationDelegate.bkImageview.alpha = 0.0;
        } completion:^(BOOL finished) {
            
        }];
        
        HAUserSettingViewController *setVc = [[HAUserSettingViewController alloc] init];
        MyNavigationViewController *navigationVC=[[MyNavigationViewController alloc] initWithRootViewController:setVc];
        [self presentViewController:navigationVC animated:YES completion:^{
            
        }];
    }
}

//分享
- (void)shareSDK{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    //[container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_SUC", @"分享成功"));
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(NSLocalizedString(@"TEXT_ShARE_FAI", @"分享失败,错误码:%d,错误描述:%@"), [error errorCode], [error errorDescription]);
                                }
                            }];
}
@end

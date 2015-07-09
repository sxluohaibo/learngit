//
//  HAMainViewController.m
//  安心汽车
//
//  Created by kongw on 15/4/23.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAMainViewController.h"
#import "ResultViewController.h"

@interface HAMainViewController (){
    HATopView *topView;//顶部的视图
    HACenterView *centerView;//中间的视图
    UIImageView *bkCenterView;//中间视图的背景
    UIImageView *iconImage;//车的图标
    UIButton *addButton;//增加车辆的按钮
}

@end

@implementation HAMainViewController
@synthesize cityNameButton;

- (void)viewDidLoad {
    [super viewDidLoad];

    //[self addCheckNewVersionsItems];//检查新版本
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bk"]];
    //主视图可以响应点击事件
    #define topHeight 42
    #define endHeight 80
    self.view.userInteractionEnabled = YES;
    
    //顶部的视图
    topView = [[HATopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, topHeight)];
    topView.delegate = self;
    topView.image = [UIImage imageNamed:@"weather_bg.png"];
    [self.view addSubview:topView];
    
    
    UIImageView *homebk = [[UIImageView alloc] initWithFrame:CGRectMake(0, topHeight, ScreenWidth, ScreenHeight-topHeight)];
    homebk.image = [UIImage imageNamed:@"home_bg.jpg"];
    homebk.userInteractionEnabled = YES;
    [self.view addSubview:homebk];
    
    //中间大的背景
    bkCenterView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, ScreenWidth-60, ScreenHeight-topHeight-endHeight-TABBAR_TAP_BUTTON_WIDTH-20)];
    bkCenterView.backgroundColor = [UIColor clearColor];
    bkCenterView.userInteractionEnabled = YES;
    [homebk addSubview:bkCenterView];
    
    //奥迪的图标
    iconImage = [[UIImageView alloc] initWithFrame:CGRectMake((bkCenterView.frame.size.width-150)/2, 89, 150, 50)];
    iconImage.image = [UIImage imageNamed:@"audi.png"];
    [bkCenterView addSubview:iconImage];
    
    //增加的按钮
    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:[UIImage imageNamed:@"new_add_Button.png"] forState:UIControlStateNormal];
    addButton.frame = CGRectMake((bkCenterView.frame.size.width-140)/2, 143, 140, 98);
    [addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [bkCenterView addSubview:addButton];
    
    //中间的视图 第二个视图
    centerView = [[HACenterView alloc] initWithFrame:CGRectMake(30, 143, ScreenWidth-60, bkCenterView.frame.size.height-143)];
    centerView.backgroundColor = [UIColor clearColor];
    [homebk addSubview:centerView];
    
    //底部的视图
    HABottomView *bottomView = [[HABottomView alloc] initWithFrame:CGRectMake(0, homebk.frame.size.height-23-endHeight-55, ScreenWidth, endHeight)];
    [homebk addSubview:bottomView];
    
    //旋转的控制器 第一个视图
    ResultViewController *primaryView = [[ResultViewController alloc] initWithNibName:@"ResultView" bundle:nil];//两个控制器
    HAFlipViewController *flipView = [[HAFlipViewController alloc] initWithNibName:@"HAFlipViewController" bundle:nil];
    [centerView setPrimaryView:primaryView.view];
    [centerView setSecondaryView:flipView.view];
    [centerView setSpinTime:1.0];

    
    //定位的初始化以及启动
    [[GprsGetCity shareGetCityLocation] initGetCityData:@""];
    [[GprsGetCity shareGetCityLocation] setCityDelegate:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getHotCityName:) name:ClickHotCityName object:nil];
    
    //资讯信息
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.backgroundColor = [UIColor clearColor];
    [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    menuButton.frame=CGRectMake(0, 0, 105, 22);
    [menuButton addTarget:self action:@selector(messageInfoBox:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:menuButton];
    
    UIImageView *menu = [[UIImageView alloc] initWithFrame:CGRectMake(0, 4, 20, 16)];
    menu.image = [UIImage imageNamed:@"news"];
    [menuButton addSubview:menu];
    
    UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, 0, 70, 22)];
    menuLabel.font = [UIFont systemFontOfSize:15.0f];
    menuLabel.backgroundColor = [UIColor clearColor];
    menuLabel.textColor = RGBACOLOR(84, 102, 126, 1);
    menuLabel.text = @"信息";
    [menuButton addSubview:menuLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAddInterFace) name:RefreshCenterView object:nil];
}


//增加的按钮
- (void)addButtonAction:(UIButton *)sender{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]) {
        ApplicationDelegate.loginType = 6;
        HALoveCarViewController *loveVc = [[HALoveCarViewController alloc] init];
        [self.navigationController pushViewController:loveVc animated:YES];
    }else{
        ApplicationDelegate.loginType = 6;//我的爱车主界面登录
        HALoginViewController *loginVc = [[HALoginViewController alloc] init];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
}

//显示消息盒子
- (void)messageInfoBox:(UIButton *)sender{
    HAMessageBoxViewController *messageBox = [[HAMessageBoxViewController alloc] init];
    [self.navigationController pushViewController:messageBox animated:YES];
}

//选择城市
- (void)changCity{
    HACityViewController *cityView=[[HACityViewController alloc] init];
    UINavigationController *navigationVC=[[UINavigationController alloc] initWithRootViewController:cityView];
    [self presentViewController:navigationVC animated:YES completion:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//刷新中间的视图
- (void)refreshCenterView{
    NSArray *yanBaoArr = [HAMineLoveCarDBOperator getLoveCarModel:YES];//延保用户车的信息
    NSArray *noYanBaoArr = [HAMineLoveCarDBOperator getLoveCarModel:NO];//不是延保车的信息
    if ([appointTime isEqualToString:@""]) {
        if (yanBaoArr.count>0) {
            HALoveCarModel *loveModel = [yanBaoArr objectAtIndex:0];
            [centerView getCarNumber:loveModel andServerTime:loveModel.serverTime];//显示车辆的信息
        }else{
            HALoveCarModel *loveModel = [noYanBaoArr objectAtIndex:0];
            [centerView getCarNumber:loveModel andServerTime:loveModel.serverTime];//显示车辆的信息
        }
    }else{
        if (yanBaoArr.count>0) {
            HALoveCarModel *loveModel = [yanBaoArr objectAtIndex:0];
            [centerView getCarNumber:loveModel andServerTime:appointTime];//显示车辆的信息
        }else{
            HALoveCarModel *loveModel = [noYanBaoArr objectAtIndex:0];
            [centerView getCarNumber:loveModel andServerTime:appointTime];//显示车辆的信息
        }
    }
}

//视图刚要出现
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self getAddInterFace];//刷新界面
}

//刷新增加的界面
- (void)getAddInterFace{
    NSArray *tempArr = [HAMineLoveCarDBOperator exqueryFMDBWithSql:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]];
    if (tempArr.count>0 && [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]) {//只要我的爱车数据库里面有车就显示车牌号码
        addButton.hidden = YES;
        iconImage.hidden = NO;
        centerView.hidden = NO;
        NSArray *yanBaoArr = [HAMineLoveCarDBOperator getLoveCarModel:YES];//延保用户车的信息
        NSArray *noYanBaoArr = [HAMineLoveCarDBOperator getLoveCarModel:NO];//不是延保车的信息
        if (yanBaoArr.count > 0) {//延保用户取第一条数据
            HALoveCarModel *loveModel = [yanBaoArr objectAtIndex:0];
            [self getNewsApointTime:loveModel];
        }else{//不是延保也取第一条数据
            HALoveCarModel *loveModel = [noYanBaoArr objectAtIndex:0];
            [self getNewsApointTime:loveModel];
        }
    }else{
        addButton.hidden = NO;
        iconImage.hidden = YES;
        centerView.hidden = YES;
    }
}

//获得最新的预约时间
- (void)getNewsApointTime:(HALoveCarModel *)loveModel{
     //http://file.ywsoftware.com:9090/T100040/appointment/showLatestAppointTime
    NSString *downName = @"/T100040/appointment/showLatestAppointTime";
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo] forKey:@"userNo"];
    [data setObject:loveModel.carNumber forKey:@"carNo"];
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:data httpMethod:@"GET" ssl:NO];
    NSLog(@"最新预约的时间 == %@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
        NSLog(@"预约的时间 ＝＝ %@",completedOperation.responseString);
        if ([[cityInfo objectForKey:@"resultCode"] integerValue] == 1) {
            appointTime = [cityInfo objectForKey:@"appointTime"];
            [self refreshCenterView];
        }else{
            appointTime = @"";
            [self refreshCenterView];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"失败");
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
}


- (void)addCheckNewVersionsItems{
    // 2.1.检查新版本
    NSString *temp1 = [HTTP stringByAppendingFormat:@"%@",MAIN_URL];
    NSString *version = [temp1 stringByAppendingFormat:@"%@",@"/T100040/update.txt"];
    NSLog(@"version == %@",version);
    NSDictionary *dict = [[NSString stringWithContentsOfURL:[NSURL URLWithString:version] encoding:NSUTF8StringEncoding error:nil]  objectFromJSONString];
    HAVersionModel *versionModel=[HAVersionModel versionWithDict:dict];
    //检查用户更新
    if([HAManger checkVersion:version]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"有新版本" message:versionModel.upgradetip delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = 100;
        alert.delegate = self;
        [alert show];
    }
}

//刷新界面
- (void)refreshtheInterface{
    //开启定位
    NSLog(@"刷新界面");
    [[GprsGetCity shareGetCityLocation] initGetCityData:@""];
    [[GprsGetCity shareGetCityLocation] setCityDelegate:self];
}


-(void)getHotCityName:(NSNotification *)noti{
    [self initWithCenterView];//加载天气预报的数据
    [self LoadVioLationData];//限行的规则
}

//定位结果的返回
- (void)getCityName:(NSString *)object{
    //刷新界面
    [self initWithCenterView];//加载天气预报的数据
    [self LoadVioLationData];//加载限行
}

- (void)LoadVioLationData{
    //http://file.ywsoftware.com:9090/T100040/xianxin/showLimitNo?cityName=一天的数据
    NSString *downName = [NSString stringWithFormat:@"/T100040/xianxin/showLimitNo?cityName=%@",[HAManger HAUTF8Change:[[NSUserDefaults standardUserDefaults] objectForKey:dwCityName]]];
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:nil httpMethod:@"GET" ssl:NO];
    NSLog(@"URL限行 == %@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
        NSLog(@"限行 ＝＝ %@",completedOperation.responseString);
        //刷新界面
        [topView initrefreshStopwalk:cityInfo];//刷新限行的界面
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"失败");
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
}

- (void)initWithCenterView{
    NSString *downName = [NSString stringWithFormat:@"/T100040/weather/index?cityName=%@",[HAManger HAUTF8Change:[[NSUserDefaults standardUserDefaults] objectForKey:dwCityName]]];
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:nil httpMethod:@"GET" ssl:NO];
    NSLog(@"URL天气 == %@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
        //NSLog(@"天气 ＝＝ %@",completedOperation.responseString);
        //请求成功
        if ([[cityInfo objectForKey:@"resultcode"] integerValue]==200) {
            //刷新界面
            [topView initrefreshWeather:cityInfo];//刷新天气
        }else{
            [MBProgressHUD showError:[cityInfo objectForKey:@"reason"]];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD showError:@"请检查您的网络"];
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {//849574097
            NSLog(@"检测新版本");
            NSString *str = [NSString stringWithFormat:
                             @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",
                             APPID];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }
}
@end

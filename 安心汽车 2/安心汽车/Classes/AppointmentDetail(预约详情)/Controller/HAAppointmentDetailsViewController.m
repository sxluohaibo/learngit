//
//  HAAppointmentDetailsViewController.m
//  安心汽车
//
//  Created by un2lock on 15/4/17.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAAppointmentDetailsViewController.h"
#import "AFNetworking.h"
#import "HAAppointmentDetailModel.h"
#import "MBProgressHUD.h"

@interface HAAppointmentDetailsViewController ()
@property(nonatomic,strong) AFHTTPRequestOperationManager *mrg;
@property(nonatomic,strong) HAAppointmentDetailModel *result;

@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@property (weak, nonatomic) IBOutlet UILabel *appointTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *carNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *carBuyTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *mileageLabel;
@property (weak, nonatomic) IBOutlet UILabel *appointStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *partnerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
- (IBAction)cancelAppointmentBtn:(id)sender;

@end

@implementation HAAppointmentDetailsViewController
@synthesize appointmentModel;

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //[self getData];//刷新数据
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showMessage:@"数据加载中"];
    self.navigationItem.title = @"详情界面";
    [self getData];
    
    _mainView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _scrollView.frame=[UIScreen mainScreen].bounds;
    CGFloat h = CGRectGetMaxY(self.cancelBtn.frame) + 10;
    _scrollView.contentSize=CGSizeMake(ScreenWidth, h);
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0, 0, 11, 20);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:backButton];
}

//返回到主界面
- (void)backAction:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/**
 *  设置详情
 */
-(void)setDealInfo{
        _appointTimeLabel.text=_result.appointTime;  //预约时间
        _carNoLabel.text=_result.carNo;
        _appointPhoneLabel.text=_result.phoneNo;
        _carBuyTimeLabel.text=_result.carBuyDate;
        _mileageLabel.text=_result.mileage;
        if([_result.appointStatus isEqualToNumber:@0]){
            _appointStatusLabel.text=@"待处理";
            _appointStatusLabel.textColor=[UIColor redColor];
        }else if([_result.appointStatus isEqualToNumber:@1]){
            _appointStatusLabel.text=@"预约成功";
            _appointStatusLabel.textColor=[UIColor greenColor];
            
        } else if([_result.appointStatus isEqualToNumber:@2]){
            _appointStatusLabel.text=@"预约失败";
            _appointStatusLabel.textColor=[UIColor orangeColor];
        }
        _createTimeLabel.text=_result.createTime;
        _partnerNameLabel.text=_result.partnerName;
        _remarkLabel.text=_result.remarks;
        _remarkLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _remarkLabel.layer.borderWidth = 2.0;
    
//    [_remarkLabel sizeToFit];
}
/**
 *  获取网络数据
 */
-(void)getData{
    self.mrg=[[AFHTTPRequestOperationManager alloc] init];
    _mrg.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //订单号
    NSLog(@"111 == %d",appointmentModel.appointId);
    if (appointmentModel.appointId) {
        params[@"appointId"] = [NSString stringWithFormat:@"%d",appointmentModel.appointId];
    }else{
        params[@"appointId"] = @"";
    }
    NSString *URL = [HTTP_MAIN_URL stringByAppendingFormat:@"%@",@"/T100040/appointment/showAppointmentDetail"];
    [_mrg GET:URL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        HAAppointmentDetailModel *result=[HAAppointmentDetailModel objectWithJSONData:responseObject];
        _result=result;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUD];
        });
        [self setDealInfo];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error");
    }];
}

- (IBAction)cancelAppointmentBtn:(id)sender {
    [MBProgressHUD showMessage:@"正在取消预约"];
    ////http://file.ywsoftware.com:9090/T100040/appointment/deleteAppointment
    NSString *downName = [NSString stringWithFormat:@"/T100040/appointment/deleteAppointment?appointId=%d",appointmentModel.appointId];
    MKNetworkOperation *op = [ApplicationDelegate.engine operationWithPath:downName params:nil httpMethod:@"GET" ssl:NO];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [MBProgressHUD hideHUD];
        NSDictionary *cityInfo = [completedOperation.responseString objectFromJSONString];
        if ([[cityInfo objectForKey:@"resultCode"]integerValue]==1) {
            [MBProgressHUD showSuccess:@"取消成功"];
            [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(backAction) userInfo:nil repeats:NO];
        }else{
            [MBProgressHUD showError:@"取消失败"];
        }
    }errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [MBProgressHUD hideHUD];
        NSLog(@"失败");
    }];
    [ApplicationDelegate.engine enqueueOperation:op];
}

//返回上一目录
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

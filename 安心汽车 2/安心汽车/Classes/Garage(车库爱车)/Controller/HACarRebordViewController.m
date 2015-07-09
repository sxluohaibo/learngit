//
//  HACarRebordViewController.m
//  安心汽车
//
//  Created by 罗海波 on 15/4/9.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HACarRebordViewController.h"
#import "HABrandSelectViewController.h"
#import "FMDB.h"
#import "HALoveCarModel.h"
#import "HAAreaViewController.h"
#import "HACarDetailViewController.h"
#import "HACarClass.h"
#import "HAMineLoveCarDBOperator.h"
#import "HAMineLoveCarDBOperator.h"

//文本框文字颜色
#define titleColor (HAColor(55, 84, 113))
//车牌号文字长度限制
#define carNumberLimitNumber 7
//车架号文本长度限制
#define carFrameLimitNumber 6
//发动机号文本长度限制
#define engineNumberLimitNumber 8
//发动机号文本长度限制
#define mileageTextLimitNumber 7

@interface HACarRebordViewController ()<UITextFieldDelegate>


/**城市选择*/
@property (weak, nonatomic) IBOutlet UIButton *citySelect;
/**车品牌*/
@property (weak, nonatomic) IBOutlet UILabel *carSelectLable;
/**车类型*/
@property (weak, nonatomic) IBOutlet UILabel *carClassLable;
/**里程数*/
@property (weak, nonatomic) IBOutlet UITextField *mileageText;
/**购车日期*/
@property (weak, nonatomic) IBOutlet UITextField *DateText;
/**车牌号*/
@property (weak, nonatomic) IBOutlet UITextField *carNumber;
/**车架号*/
@property (weak, nonatomic) IBOutlet UITextField *carframe;
/**发动机号*/
@property (weak, nonatomic) IBOutlet UITextField *engineNumber;
/**最近保养时间*/
@property (weak, nonatomic) IBOutlet UITextField *serverTime;

/**日期选择*/
@property (nonatomic, strong) UIDatePicker * datePicker;

//action
- (IBAction)citySelect:(id)sender;

//保存车辆信息
- (IBAction)saveCarInfoBtn:(id)sender;
//右边的剪头
@property (weak, nonatomic) IBOutlet UIImageView *firstIconView;
@property (weak, nonatomic) IBOutlet UIImageView *SecondIconView;

//删除按钮
@property (weak, nonatomic) IBOutlet UIButton *deleteCarInfo;
//删除按钮点击
- (IBAction)deleteBtnClick:(id)sender;


//分割线
@property (weak, nonatomic) IBOutlet UIView *cityView;
/**车型选择*/
@property (weak, nonatomic) IBOutlet UIView *carClass;
@property (weak, nonatomic) IBOutlet UIView *carBoardView;
@property (weak, nonatomic) IBOutlet UIView *mileView;
@property (weak, nonatomic) IBOutlet UIView *carNumberView;
@property (weak, nonatomic) IBOutlet UIView *carFrameView;
@property (weak, nonatomic) IBOutlet UIView *carEnView;
@property (weak, nonatomic) IBOutlet UIView *buyDateView;
/**车辆上次保养时间*/
@property (weak, nonatomic) IBOutlet UIView *ServerTimeView;

@end

@implementation HACarRebordViewController



- (UIDatePicker *)datePicker
{
    if (_datePicker==nil) {
        
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.date = [NSDate date];
        _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
      }
    
    return _datePicker;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.carBoardView.ba ckgroundColor = [UIColor lightGrayColor];
    //设置分割线
    [self setupSperator];
    //设置导航栏样式
    [self setupNavgationItem];
    //设置datepicker
    [self setupDatePicker];
    //设置文本框样式
    [self setproperty];
    
    self.deleteCarInfo.backgroundColor = HAColor(215, 8, 15);
    self.deleteCarInfo.hidden = YES;
    //设置按钮文字
    [self.citySelect setTitle:@"选择城市" forState:UIControlStateNormal];
    if (self.loveCarMessage) {
        [self.citySelect setTitle:(self.loveCarMessage.city?self.loveCarMessage.city:@"选择城市") forState:UIControlStateNormal];
        self.carSelectLable.text = self.loveCarMessage.carType;
        self.carClassLable.text = self.loveCarMessage.carinfo;
        self.mileageText.text = self.loveCarMessage.mileageText;
        self.DateText.text= self.loveCarMessage.DateText;
        self.carNumber.text = self.loveCarMessage.carNumber;
        self.carframe.text = self.loveCarMessage.carframe;
        self.engineNumber.text = self.loveCarMessage.engineNumber;
        self.serverTime.text = self.loveCarMessage.serverTime;
        self.deleteCarInfo.hidden = NO;
    }
    
    //设置代理
    self.carframe.delegate = self;
    self.engineNumber.delegate = self;
    self.serverTime.delegate = self;
    self.DateText.delegate = self;

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

//添加分割线
- (void)setupSperator{
    UIView * sperator1 = [[UIView alloc] init];
    sperator1.frame = CGRectMake(0, 39.4, ScreenWidth, 0.5);
    sperator1.backgroundColor = [UIColor grayColor];
    sperator1.alpha = 0.5;
    [self.cityView addSubview:sperator1];
    
    UIView * sperator2 = [[UIView alloc] init];
    sperator2.frame = CGRectMake(0, 39.4, ScreenWidth, 0.5);
    sperator2.backgroundColor = [UIColor grayColor];
    sperator2.alpha = 0.5;
    [self.carClass addSubview:sperator2];
    
    UIView * sperator3 = [[UIView alloc] init];
    sperator3.frame = CGRectMake(0, 39.4, ScreenWidth, 0.5);
    sperator3.backgroundColor = [UIColor grayColor];
    sperator3.alpha = 0.5;
    [self.buyDateView addSubview:sperator3];
    
    
    UIView * sperator4 = [[UIView alloc] init];
    sperator4.frame = CGRectMake(0, 39.4, ScreenWidth, 0.5);
    sperator4.backgroundColor = [UIColor grayColor];
    sperator4.alpha = 0.5;
    [self.mileView addSubview:sperator4];
    
    UIView * sperator5 = [[UIView alloc] init];
    sperator5.frame = CGRectMake(0, 39.4, ScreenWidth, 0.5);
    sperator5.backgroundColor = [UIColor grayColor];
    sperator5.alpha = 0.5;
    [self.carNumberView addSubview:sperator5];
    
    UIView * sperator6 = [[UIView alloc] init];
    sperator6.frame = CGRectMake(0, 39.4, ScreenWidth, 0.5);
    sperator6.backgroundColor = [UIColor grayColor];
    sperator6.alpha = 0.5;
    [self.carFrameView addSubview:sperator6];
    
    UIView * sperator7 = [[UIView alloc] init];
    sperator7.frame = CGRectMake(0, 39.4, ScreenWidth, 0.5);
    sperator7.backgroundColor = [UIColor grayColor];
    sperator7.alpha = 0.5;
    [self.carEnView addSubview:sperator7];
    
    UIView * sperator8 = [[UIView alloc] init];
    sperator8.frame = CGRectMake(0, 39.4, ScreenWidth, 0.5);
    sperator8.backgroundColor = [UIColor grayColor];
    sperator8.alpha = 0.5;
    [self.ServerTimeView addSubview:sperator8];
    
}


- (void)setproperty
{
//    self.carNumber.ca
    //1、公里数
    self.mileageText.keyboardType = UIKeyboardTypeNumberPad;
    self.mileageText.textColor = titleColor;
    self.mileageText.delegate = self;
    //2、车牌号
    self.carNumber.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    self.carNumber.delegate = self;
    self.carNumber.textColor = titleColor;
    //3、车架号
    self.carframe.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters|UITextAutocapitalizationTypeWords;
    self.carframe.textColor = titleColor;
    self.carframe.keyboardType = UIKeyboardTypeASCIICapable;
    //3、发动机号
    self.engineNumber.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters|UITextAutocapitalizationTypeWords;
    self.engineNumber.textColor = titleColor;
    self.engineNumber.keyboardType = UIKeyboardTypeASCIICapable;
    
    self.DateText.inputView = self.datePicker;
    self.DateText.textColor = titleColor;
    
    self.serverTime.inputView = self.datePicker;
    self.serverTime.textColor = titleColor;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (self.serverTime == textField) {
        self.datePicker.tag = 1;
    }else if (self.DateText == textField){
        
        self.datePicker.tag = 2;
    }
    if (self.DateText == textField) {
        
        [UIView animateWithDuration:0.4 animations:^{
            
            self.carBoardView.transform = CGAffineTransformMakeTranslation(0, -180);
        }];
    }
    if (self.carframe == textField) {
        
        [UIView animateWithDuration:0.4 animations:^{
            
            self.carBoardView.transform = CGAffineTransformMakeTranslation(0, -180);
        }];
    }
    
    if (self.engineNumber == textField) {
        
        [UIView animateWithDuration:0.4 animations:^{
            
            self.carBoardView.transform = CGAffineTransformMakeTranslation(0, -180);
        }];
    } 
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    if (self.carNumber == textField) {
        
        if (self.carNumber.text.length<7) {
            
            [MBProgressHUD showError:@"车牌号不能小于7位"];
            self.carNumber.text = nil;
        }
        [UIView animateWithDuration:0.4 animations:^{
            
            self.carBoardView.transform = CGAffineTransformIdentity;
        }];
    }
    
    if (self.carframe == textField) {
        
        if (self.carframe.text.length<6) {
            
            [MBProgressHUD showError:@"车架号不能小于6位"];
            
        }
        [UIView animateWithDuration:0.4 animations:^{
            
            self.carBoardView.transform = CGAffineTransformIdentity;
        }];
    }
    
    if (self.engineNumber == textField) {
        
        if (self.engineNumber.text.length<8) {
            
            [MBProgressHUD showError:@"发动机号不能小于8位"];
            
            
        }
        [UIView animateWithDuration:0.4 animations:^{
            
            self.carBoardView.transform = CGAffineTransformIdentity;
        }];
    }
    if (self.DateText == textField) {
        [UIView animateWithDuration:0.4 animations:^{
            
            self.carBoardView.transform = CGAffineTransformIdentity;
        }];
    }

}

#pragma HACarRebordViewController delegate

/**
 *  设置textField样式
 *  @param loveCarMessage <#loveCarMessage description#>
 */
- (void)setLoveCarMessage:(HALoveCarModel *)loveCarMessage{
    _loveCarMessage = loveCarMessage;
    self.carSelectLable.text = loveCarMessage.carType;
    self.carClassLable.text = loveCarMessage.carinfo;
    
    self.mileageText.text = loveCarMessage.mileageText;
    self.DateText.text= loveCarMessage.DateText;
}

/**
 *  设置导航栏样式
 */
- (void)setupNavgationItem{
    self.title = @"车辆信息";
    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor:HAColor(49, 84, 128)};
    self.carSelectLable.hidden = YES;
    UITapGestureRecognizer * tapGes = [[UITapGestureRecognizer alloc] init];
    [self.carClass addGestureRecognizer:tapGes];
    [tapGes addTarget:self action:@selector(boardSelect)];
}

- (void)saveInfo:(UIButton *)button{
    if ([self.carNumber.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"车牌号不能为空"];
        return;
    }
    
    if ([self.serverTime.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"保养时间不能为空"];
        return;
    }
    
    if ([self.mileageText.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"里程数不能为空"];
        return;
    }
    
    if ([self.DateText.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"购车日期不能为空"];
        return;
    }
    if (self.loveCarMessage) {
        //跟新数据
        NSString *sql = [NSString stringWithFormat:@"UPDATE t_carport set city = '%@' ,carType='%@',carInfo ='%@',carmileage ='%@',DateText='%@',carNumber='%@',carframe='%@',engineNumber='%@',ServerTime='%@' where id = %d and LoginUserNo='%@';",self.citySelect.titleLabel.text,self.carSelectLable.text,self.carClassLable.text,self.mileageText.text,self.DateText.text,self.carNumber.text,self.carframe.text,self.engineNumber.text,self.serverTime.text,self.loveCarMessage.Did,[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]];
        NSLog(@"dadsasd=%@",sql);
        [HAMineLoveCarDBOperator updateFMDBWithSql:sql];
    }
    else{
        //插入数据
        NSString * sql = [NSString stringWithFormat:@"insert into t_carport (LoginUserNo,city,carType,carInfo,carmileage,DateText,carNumber,carframe,engineNumber,isCooperation,ServerTime) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%d','%@');",[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo],self.citySelect.titleLabel.text,self.carSelectLable.text,self.carClassLable.text,self.mileageText.text,self.DateText.text,self.carNumber.text,self.carframe.text,self.engineNumber.text,NO,self.serverTime.text];
        
        [HAMineLoveCarDBOperator insertIntoFMDBWithSql:sql];
    }
    if ([self.delegate respondsToSelector:@selector(CarRebordViewControllerToLoadNewDate)]) {
        
        [self.delegate CarRebordViewControllerToLoadNewDate];
    }
        
    [self.navigationController popViewControllerAnimated:YES];
    
}


/**
 *  设置datepicker的工具条
 */
- (void)setupDatePicker
{
    
    UIToolbar * toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleClick)];
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(selectClick)];
    UIBarButtonItem * item3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolBar.items = @[item1,item3,item2];
//    self.datePicker.inputAccessoryView = toolBar;
    self.DateText.inputAccessoryView = toolBar;
    self.serverTime.inputAccessoryView = toolBar;
}


/**
 *  日期取消
 */
- (void)cancleClick
{
    [self.view endEditing:YES];
   
}

/**
 *  日期确定
 */
- (void)selectClick
{
    [self.view endEditing:YES];
    NSLog(@"%@",self.datePicker.date);
    NSDate * dateS = self.datePicker.date;
    if (self.datePicker.tag == 2) {
        
            NSTimeInterval  interval = [dateS timeIntervalSinceNow];
            if (interval>0) {
        
                [MBProgressHUD showError:@"不能选择比当前大的日期"];
                return;
            }
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            //购车日期
            self.DateText.text = [dateFormatter stringFromDate:dateS];
        
    }else if(self.datePicker.tag == 1){
        
        NSTimeInterval  interval = [dateS timeIntervalSinceNow];
        if (interval>0) {
            
            [MBProgressHUD showError:@"不能选择比当前大的日期"];
            return;
        }
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //上次预约保养时间
        self.serverTime.text = [dateFormatter stringFromDate:dateS];
    }
}


/**
 *  车牌选择
 */
-(void)boardSelect
{
    HABrandSelectViewController * boardVc = [[HABrandSelectViewController alloc] init];
    [self.navigationController pushViewController:boardVc animated:YES];
    boardVc.type = @1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CarDetailInfoByCarBrandAndCarYear:) name:CarClassPickNotification object:nil];
}

- (void)CarDetailInfoByCarBrandAndCarYear:(NSNotification *)notification
{
    HACarClass * carClass = [notification object];
    self.carSelectLable.text = [NSString stringWithFormat:@"%@ %@",carClass.brandName,carClass.seriesName];
    self.carClassLable.text = [NSString stringWithFormat:@"%@ %@款",carClass.specialName,carClass.year];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [HAMineLoveCarDBOperator closeDMDB];
}

/**
 *  退出键盘
 */
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    self.view.transform=CGAffineTransformIdentity;
}


- (IBAction)citySelect:(id)sender {
    HACityViewController *cityView=[[HACityViewController alloc] init];
    UINavigationController *navigationVC=[[UINavigationController alloc] initWithRootViewController:cityView];
    [self presentViewController:navigationVC animated:YES completion:nil];
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityClick:) name:ClickHotCityName object:nil];
}

/**
 *  保存车辆信息
 *
 *  @param sender <#sender description#>
 */
- (IBAction)saveCarInfoBtn:(id)sender {
    
    [self saveInfo:nil];
}

- (void)cityClick:(NSNotification *) note
{
    [self.citySelect setTitle:[note object] forState:UIControlStateNormal];
}

//删除按钮点击
- (IBAction)deleteBtnClick:(id)sender {
    
    
    [HAMineLoveCarDBOperator deleteFMDBWithSql:[NSString stringWithFormat:@"delete from t_carport where id = '%d' and LoginUserNo ='%@';",self.loveCarMessage.Did,[[NSUserDefaults standardUserDefaults] objectForKey:LoginUserNo]]];
    
    if ([self.delegate respondsToSelector:@selector(deleteLoveCarInfoButtonClick)]) {
        
        [self.delegate deleteLoveCarInfoButtonClick];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma textField 的代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];    //主要是[receiver resignFirstResponder]在哪调用就能把receiver对应的键盘往下收
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{  //string就是此时输入的那个字符 textField就是此时正在输入的那个输入框 返回YES就是可以改变输入框的值 NO相反
    
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (self.carNumber == textField)  //车牌号判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > carNumberLimitNumber) { //如果输入框内容大于20则弹出警告
            self.carNumber.text = [toBeString substringToIndex:carNumberLimitNumber];

            return NO;
        }
        
    }else if(self.carframe == textField)  //车架号判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > carFrameLimitNumber) { //如果输入框内容大于20则弹出警告
            self.carframe.text = [toBeString substringToIndex:carFrameLimitNumber];
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"不能超过7位" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
            //            [alert show];
            return NO;
        }
    }else if(self.engineNumber == textField)  //车架号判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > engineNumberLimitNumber) { //如果输入框内容大于20则弹出警告
            self.engineNumber.text = [toBeString substringToIndex:engineNumberLimitNumber];
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"不能超过7位" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] ;
            //            [alert show];
            return NO;
        }
    }else if(self.mileageText == textField)  //车架号判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > mileageTextLimitNumber) { //如果输入框内容大于20则弹出警告
            self.mileageText.text = [toBeString substringToIndex:mileageTextLimitNumber];
            return NO;
        }
    }
    
    return YES;
}


@end

//
//  HAAddCarImageView.m
//  安心汽车
//
//  Created by kongw on 15/3/25.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAAddCarImageView.h"
#import "HAViobkImageView.h"

@implementation HAAddCarImageView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame andAddCarInfoArr:(NSMutableArray *)carListInfoArr andEditor:(HAUserInputModel *)inputData andType:(NSInteger)type{
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    if (self) {
        //#define violationArea @"违章区域"
        //#define carTypeNO @"车牌号"
        //#define classNO @"车架号"
        //#define engineNo @"发动机号"
        //#define registerNO @"注册号"
        //#define remarkNO @"备注号"
        //#define carTYShort @"车牌简写"
        if (carListInfoArr.count == 0) {
            //中间的虚线
            //所有的背景
            HAViobkImageView *tempView = [[HAViobkImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 47) andIndex:violationArea];
            tempView.userInteractionEnabled = YES;
            [self addSubview:tempView];
            //第一条 （城市选择）
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 80, 30)];
            tempView.accessibilityIdentifier = violationArea;
            textLabel.textAlignment = NSTextAlignmentLeft;
            textLabel.text = violationArea;
            textLabel.textColor = [UIColor blackColor];
            [tempView addSubview:textLabel];
            
            //标题 点击的按钮
            HAListButton *title = [[HAListButton alloc] initWithFrame:CGRectMake(100, 0, 220, 44)];
            title.backgroundColor = [UIColor clearColor];
            [title addTarget:self action:@selector(changeCity:) forControlEvents:UIControlEventTouchUpInside];
            [tempView addSubview:title];
            
            UILabel *titleName = [[UILabel alloc] init];
            titleName.backgroundColor = [UIColor clearColor];
            titleName.frame = CGRectMake(30, 10, 150, 24);
            titleName.tag = 10;
            titleName.textAlignment = NSTextAlignmentLeft;
            titleName.textColor = HAColor(95, 119, 146);
            titleName.text = @"选择城市";
            [title addSubview:titleName];
            
            
            UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-30, 12, 10, 18)];
            arrowImage.image = [UIImage imageNamed:@"arrow_right.png"];
            [tempView addSubview:arrowImage];
            
            
            //第二条 车牌号
            HAViobkImageView *carImageView = [[HAViobkImageView alloc] initWithFrame:CGRectMake(0, 47, ScreenWidth, 47) andIndex:carTypeNO];
            carImageView.accessibilityIdentifier = carTypeNO;
            carImageView.userInteractionEnabled = YES;
            [self addSubview:carImageView];
            
            UILabel *carLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 80, 30)];
            carLabel.textAlignment = NSTextAlignmentLeft;
            carLabel.tag = 10;
            carLabel.text = carTypeNO;
            carLabel.textColor = [UIColor blackColor];
            [carImageView addSubview:carLabel];
            
            //显示简称
            UIButton *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
            tapButton.frame = CGRectMake(100, 6, 25, 30);
            tapButton.tag=99;
            //HAViolationCitysParameResult *cityModel = [carListInfoArr objectAtIndex:0];
            [tapButton setTitle:@"" forState:UIControlStateNormal];
            [tapButton setTitleColor:HAColor(95, 119, 146) forState:UIControlStateNormal];
            [tapButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
            tapButton.backgroundColor = [UIColor clearColor];
            [carImageView addSubview:tapButton];
            
            UITextField *carInfo = [[UITextField alloc] initWithFrame:CGRectMake(130, 6, ScreenWidth-140, 30)];
            carInfo.backgroundColor = [UIColor clearColor];
            carInfo.keyboardType = UIKeyboardTypeASCIICapable;
            carInfo.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters | UITextAutocapitalizationTypeWords;
            carInfo.tag = 20;
            carInfo.accessibilityHint = carTypeNO;
            carInfo.textColor = HAColor(95, 119, 146);
            carInfo.placeholder = @"请输入完整的数据";
            carInfo.delegate = self;
            [carImageView addSubview:carInfo];
            
            //最后一个 备注号
            HAViobkImageView *remarkImageView = [[HAViobkImageView alloc] initWithFrame:CGRectMake(0, 47*2, ScreenWidth, 47) andIndex:remarkNO];
            remarkImageView.backgroundColor = [UIColor clearColor];
            remarkImageView.accessibilityIdentifier = remarkNO;
            remarkImageView.userInteractionEnabled = YES;
            [self addSubview:remarkImageView];
            
            UILabel *remarkLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 80, 30)];
            remarkLabel.textAlignment = NSTextAlignmentLeft;
            remarkLabel.tag = 10;
            remarkLabel.text = remarkNO;
            remarkLabel.textColor = [UIColor blackColor];
            [remarkImageView addSubview:remarkLabel];
            
            UITextField *remarkInfo = [[UITextField alloc] initWithFrame:CGRectMake(100, 6, ScreenWidth-110, 30)];
            remarkInfo.backgroundColor = [UIColor clearColor];
            remarkInfo.font = [UIFont systemFontOfSize:16.0f];
            remarkInfo.tag = 20;
            //remarkInfo.borderStyle = UITextBorderStyleRoundedRect;
            remarkInfo.textColor = HAColor(95, 119, 146);
            remarkInfo.placeholder = @"备注(例如张三)";
            remarkInfo.delegate = self;
            [remarkImageView addSubview:remarkInfo];
            
            //增加车辆的按钮
            UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
            addButton.frame = CGRectMake((ScreenWidth-290)/2, 24+47*3, 290, 38);
            [addButton addTarget:self action:@selector(addButton:) forControlEvents:UIControlEventTouchUpInside];
            addButton.backgroundColor = HAColor(78, 109, 151);
            [addButton setTitle:@"保存并去查询" forState:UIControlStateNormal];
            [self addSubview:addButton];
        }else{
            NSMutableArray *viewArr = [[NSMutableArray alloc] init];
            
            NSMutableArray *classArr = [[NSMutableArray alloc] init];
            NSMutableArray *engineArr = [[NSMutableArray alloc] init];
            NSMutableArray *registArr = [[NSMutableArray alloc] init];

            NSMutableArray *titleArr = [[NSMutableArray alloc] initWithCapacity:5];
            for (int i = 0; i < carListInfoArr.count; i++) {
                HAViolationCitysParameResult *cityModel = [carListInfoArr objectAtIndex:i];
                [titleArr addObject:cityModel.city_name];// 得到数组最多5个
                
                if (cityModel.classa){
                    [classArr addObject:[NSString stringWithFormat:@"车架号:-%ld",(long)cityModel.classno]];
                }
                if (cityModel.engine) {
                    [engineArr addObject:[NSString stringWithFormat:@"发动机号:-%ld",(long)cityModel.engineno]];
                }
                
                if (cityModel.regist) {
                    [registArr addObject:[NSString stringWithFormat:@"注册号:-%ld",(long)cityModel.registno]];
                }
            }
            
            //第一条 （城市选择）
            HAViobkImageView *tempView = [[HAViobkImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 47) andIndex:violationArea];
            tempView.accessibilityIdentifier = violationArea;
            tempView.userInteractionEnabled = YES;
            [self addSubview:tempView];
            
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 80, 30)];
            textLabel.textAlignment = NSTextAlignmentLeft;
            textLabel.text = violationArea;
            textLabel.textColor = [UIColor blackColor];
            [tempView addSubview:textLabel];
            
            //标题 点击的按钮
            HAListButton *title = [[HAListButton alloc] initWithFrame:CGRectMake(100, 0, 220, 44)];
            [title buttonListArr:titleArr];
            title.delegate = self;
            title.backgroundColor = [UIColor clearColor];
            [title addTarget:self action:@selector(changeCity:) forControlEvents:UIControlEventTouchUpInside];
            [tempView addSubview:title];
            
            
            UIImageView *arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth-30, 12, 10, 18)];
            arrowImage.image = [UIImage imageNamed:@"arrow_right.png"];
            [tempView addSubview:arrowImage];
            
            //第二条 车牌号
            HAViobkImageView *carImageView = [[HAViobkImageView alloc] initWithFrame:CGRectMake(0, 47, ScreenWidth, 47) andIndex:carTypeNO];
            carImageView.accessibilityIdentifier = carTypeNO;
            carImageView.userInteractionEnabled = YES;
            [self addSubview:carImageView];
            
            UILabel *carLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 80, 30)];
            carLabel.textAlignment = NSTextAlignmentLeft;
            carLabel.text = carTypeNO;
            carLabel.tag=10;
            carLabel.textColor = [UIColor blackColor];
            [carImageView addSubview:carLabel];
            
            //显示简称
            UIButton *tapButton = [UIButton buttonWithType:UIButtonTypeCustom];
            tapButton.frame = CGRectMake(100, 6, 25, 30);
            tapButton.tag=99;
            HAViolationCitysParameResult *cityModel = [carListInfoArr objectAtIndex:0];
            [tapButton setTitle:cityModel.abbr forState:UIControlStateNormal];
            [tapButton setTitleColor:HAColor(95, 119, 146) forState:UIControlStateNormal];
            [tapButton addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
            tapButton.backgroundColor = [UIColor clearColor];
            [carImageView addSubview:tapButton];
    
            UITextField *carInfo = [[UITextField alloc] initWithFrame:CGRectMake(130, 6, ScreenWidth-140, 30)];
            carInfo.backgroundColor = [UIColor clearColor];
            carInfo.tag = 20;
            carInfo.keyboardType = UIKeyboardTypeASCIICapable;
            carInfo.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters | UITextAutocapitalizationTypeWords;
            carInfo.accessibilityHint = carTypeNO;
            //carInfo.borderStyle = UITextBorderStyleRoundedRect;
            carInfo.textColor = HAColor(95, 119, 146);
            if (inputData) {
                carInfo.text = inputData.carTypeShort;
                carInfo.userInteractionEnabled = NO;
            }else{
                carInfo.userInteractionEnabled = YES;
                carInfo.placeholder = @"请输入完整的车牌号";
            }
            carInfo.delegate = self;
            [carImageView addSubview:carInfo];

            NSInteger classIndex = -1;
            NSInteger engineIndex = -1;
            NSInteger registIndex = -1;

            for (int i = 0; i < classArr.count; i++) {
                NSString *temp = [classArr objectAtIndex:i];
                NSArray *tempArr = [temp componentsSeparatedByString:@"-"];
                NSInteger xx = [[tempArr objectAtIndex:1] integerValue];
                if (xx >= classIndex) {
                    classIndex = xx;
                }
            }
            
            for (int i = 0; i < engineArr.count; i++) {
                NSString *temp = [engineArr objectAtIndex:i];
                NSArray *tempArr = [temp componentsSeparatedByString:@"-"];
                NSInteger xx = [[tempArr objectAtIndex:1] integerValue];
                if (xx >= engineIndex) {
                    engineIndex = xx;
                }
            }
            
            for (int i = 0; i < registArr.count; i++) {
                NSString *temp = [registArr objectAtIndex:i];
                NSArray *tempArr = [temp componentsSeparatedByString:@"-"];
                NSInteger xx = [[tempArr objectAtIndex:1] integerValue];
                if (xx >= registIndex) {
                    registIndex = xx;
                }
            }
            
            if (classIndex >= 0) {
                [viewArr addObject:[NSString stringWithFormat:@"%@-%ld",classNO,(long)classIndex]];
            }
            
            if (engineIndex >= 0) {
                [viewArr addObject:[NSString stringWithFormat:@"%@-%ld",engineNo,(long)engineIndex]];
            }
            
            if (registIndex >= 0) {
                [viewArr addObject:[NSString stringWithFormat:@"%@-%ld",registerNO,(long)registIndex]];
            }
            [viewArr addObject:[NSString stringWithFormat:@"%@-%d",remarkNO,0]];//去掉相同的元素

            
            for (int i = 0; i < viewArr.count; i++) {
                NSArray *tempArr = [[viewArr objectAtIndex:i] componentsSeparatedByString:@"-"];
                NSString *one = [tempArr objectAtIndex:0];
                NSString *two = [tempArr objectAtIndex:1]; 
                HAViobkImageView *carImageView = [[HAViobkImageView alloc] initWithFrame:CGRectMake(0, 47*2+47*i, ScreenWidth, 47) andIndex:one];
                carImageView.accessibilityIdentifier = one;
                carImageView.accessibilityLabel = [NSString stringWithFormat:@"%d",20+i];//来判断升降
                carImageView.userInteractionEnabled = YES;
                [self addSubview:carImageView];
                
                UILabel *carLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 6, 80, 30)];
                carLabel.textAlignment = NSTextAlignmentLeft;
                carLabel.tag = 10;
                carLabel.text = one;
                carLabel.textColor = [UIColor blackColor];
                [carImageView addSubview:carLabel];

                UITextField *carInfo = [[UITextField alloc] initWithFrame:CGRectMake(100, 6, ScreenWidth-110, 30)];
                carInfo.backgroundColor = [UIColor clearColor];
                carInfo.accessibilityHint = one;
                carInfo.tag = 20;
                carInfo.delegate = self;
                carInfo.textColor = HAColor(95, 119, 146);
                
                if ([carImageView.accessibilityIdentifier isEqualToString:remarkNO]) {
                    if (inputData) {
                        carInfo.text = inputData.remarkNumber;
                    }else{
                        carInfo.placeholder = @"备注(例如张三)";
                    }
                }else{
                    carInfo.keyboardType = UIKeyboardTypeASCIICapable;
                    carInfo.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters | UITextAutocapitalizationTypeWords;
                    if ([two integerValue] == 0) {
                        carInfo.placeholder = [NSString stringWithFormat:@"请输入完整的%@",one];
                    }else{
                        carInfo.placeholder = [NSString stringWithFormat:@"请输入%@的后%ld位",one,(long)[two integerValue]];
                    }
                }
                
                //车架号
                if ([carImageView.accessibilityIdentifier isEqualToString:classNO]) {
                    if (inputData) {
                        carInfo.text = inputData.classNumber;
                    }
                }
                //发动机号
                if ([carImageView.accessibilityIdentifier isEqualToString:engineNo]) {
                    if (inputData) {
                        carInfo.text = inputData.engineNumber;
                    }
                }
                
                //注册号
                if ([carImageView.accessibilityIdentifier isEqualToString:registerNO]) {
                    if (inputData) {
                        carInfo.text = inputData.registNumber;
                    }
                }
                [carImageView addSubview:carInfo];
            }
            
            
            if (type == 1) {
                //增加车辆的按钮
                UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
                addButton.frame = CGRectMake((ScreenWidth-290)/2, 47*2+47*viewArr.count+24, 290, 38);
                [addButton setImage:[UIImage imageNamed:@"save_bar"] forState:UIControlStateNormal];
                [addButton addTarget:self action:@selector(addButton:) forControlEvents:UIControlEventTouchUpInside];
                //addButton.backgroundColor = HAColor(78, 109, 151);
                [addButton setTitle:@"保存并去查询" forState:UIControlStateNormal];
                [self addSubview:addButton];
            }else{
                //增加车辆的按钮
                UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
                addButton.frame = CGRectMake((ScreenWidth-290)/2, 47*2+47*viewArr.count+24, 290, 38);
                [addButton setImage:[UIImage imageNamed:@"save_bar"] forState:UIControlStateNormal];
                [addButton addTarget:self action:@selector(addButton:) forControlEvents:UIControlEventTouchUpInside];
                //addButton.backgroundColor = HAColor(78, 109, 151);
                [addButton setTitle:@"保存并去查询" forState:UIControlStateNormal];
                [self addSubview:addButton];
                
                
                //增加车辆的按钮
                UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
                deleteButton.frame = CGRectMake((ScreenWidth-290)/2, 47*2+47*viewArr.count+24 + 50, 290, 38);
                [deleteButton addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
                //deleteButton.backgroundColor = HAColor(78, 109, 151);
                [deleteButton setImage:[UIImage imageNamed:@"del_bar"] forState:UIControlStateNormal];
                [deleteButton setTitle:@"保存并去查询" forState:UIControlStateNormal];
                [self addSubview:deleteButton];
            }
        }
    }
    return self;
}

//删除信息
- (void)deleteButton:(UIButton *)sender{
    [delegate deteleButtonAction:sender];
}

//增加车辆信息
- (void)addButton:(UIButton *)sender{
    [delegate addButtonAction:sender];
}

//刷新界面(删除listButton 然后重新绘制界面)
- (void)deleteRefreshView:(UIButton *)sender{
    [delegate deleteButtonAgainView:sender];
}


- (void)changeCity:(UIButton *)sender{
    NSLog(@"选择城市");
    [delegate getNotifaCation];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSInteger index = [textField.superview.accessibilityLabel integerValue];
    if (index < 21) {
        [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        } completion:nil];
    }else{
        [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.frame = CGRectMake(0, -(index-20)*60, ScreenWidth, ScreenHeight);
        } completion:nil];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (self.superview.frame.origin.y != 0) {
        [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        } completion:nil];
    }
    return NO;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UIImageView *tempView = (UIImageView *)[self viewWithTag:88];
    [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        tempView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 270);
        [tempView removeFromSuperview];
    } completion:nil];
    [self endEditing:YES];
}

- (void)tapButton:(UIButton *)sender{
    NSLog(@"点击");
    UIImageView *tempView = (UIImageView *)[self viewWithTag:88];
    if (tempView) {
        [tempView removeFromSuperview];
    }
    UIImageView *choiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 270)];
    choiceImageView.backgroundColor = [UIColor grayColor];
    choiceImageView.userInteractionEnabled = YES;
    choiceImageView.alpha = 0.5;
    choiceImageView.tag = 88;
    [self addSubview:choiceImageView];
    
    NSArray *abbreviationArr = [[NSArray alloc] initWithObjects:@"京", @"沪", @"浙", @"苏", @"粤", @"鲁", @"晋", @"翼", @"豫",
                        @"川", @"渝", @"辽", @"吉", @"黑", @"皖", @"鄂", @"湘", @"赣", @"闽", @"陕", @"甘", @"宁", @"蒙", @"津", @"贵", @"云",
                        @"桂", @"琼", @"青", @"新", @"藏" ,@"台", nil];
    #define iconWidth 28   //x的宽度
    #define iconHeight 40  //y的宽度
    #define iconCount 32   //总的个数
    #define iconListcount 10//每一行的个数
    #define x_interval 4  //x的间隙
    #define y_interval 10 //y的间隙
    for (int i = 0; i < abbreviationArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        NSInteger x = 0;
        NSInteger y = 0;
        x = (i%iconListcount)*(iconWidth+x_interval);
        y = (i/iconListcount)*(iconHeight+y_interval);
        button.frame = CGRectMake(2+x, 10+y, iconWidth, iconHeight);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 6.0;
        button.accessibilityHint = [abbreviationArr objectAtIndex:i];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonSender:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[abbreviationArr objectAtIndex:i] forState:UIControlStateNormal];
        [choiceImageView addSubview:button];
    }
    
    [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        choiceImageView.frame = CGRectMake(0, ScreenHeight-270, ScreenWidth, 270);
    } completion:nil];
   
    
    UIButton *completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    completeButton.frame = CGRectMake(ScreenWidth-70, 165, 60, 35);
    completeButton.backgroundColor = [UIColor greenColor];
    [completeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [completeButton addTarget:self action:@selector(completeAction:) forControlEvents:UIControlEventTouchUpInside];
    completeButton.layer.masksToBounds = YES;
    completeButton.layer.cornerRadius = 6.0;
    [completeButton setTitle:@"完成" forState:UIControlStateNormal];
    [choiceImageView addSubview:completeButton];
}

- (void)buttonSender:(UIButton *)sender{
    for (UIImageView *imageView in self.subviews) {
        if ([imageView.accessibilityIdentifier isEqualToString:@"车牌号"]) {
            UIButton *button = (UIButton *)[imageView viewWithTag:99];
            [button setTitle:sender.accessibilityHint forState:UIControlStateNormal];
        }
    }
}


- (void)completeAction:(UIButton *)sender{
    UIImageView *tempView = (UIImageView *)[self viewWithTag:88];
    [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame = CGRectMake(0, 64, ScreenWidth, ScreenHeight);
        tempView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 270);
    } completion:nil];
    [self endEditing:YES];
}


#define kMaxLength 6
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([textField.accessibilityHint isEqualToString:carTypeNO]) {//车牌
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > kMaxLength && range.length!=1){
            textField.text = [toBeString substringToIndex:kMaxLength];
            return NO;
        }
        return YES;
    }
    if ([textField.accessibilityHint isEqualToString:engineNo]) {//发动机
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > 8 && range.length!=1){
            textField.text = [toBeString substringToIndex:8];
            return NO;
        }
        return YES;
    }
    if ([textField.accessibilityHint isEqualToString:classNO]) {//车架
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > 6 && range.length!=1){
            textField.text = [toBeString substringToIndex:6];
            return NO;
        }
        return YES;
    }
    return YES;
}

@end

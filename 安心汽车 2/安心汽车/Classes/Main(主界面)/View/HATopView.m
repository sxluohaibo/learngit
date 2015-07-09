//
//  HATopView.m
//  安心汽车
//
//  Created by kongw on 15/4/23.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HATopView.h"

@implementation HATopView{
    UILabel *temperature;//温度
    UIImageView *iconImage;//温度的图片
    UILabel *adress;//显示地点
    UILabel *date;
    UILabel *description;//描述
    UILabel *resTitle;//限行的标题
    
    
    UILabel *oneAndTwo;//两个Label
    UIImageView *oneImage;//第一个数字
    UIImageView *twoImage;//第二个数字
    
}
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.userInteractionEnabled = YES;
    if (self) {
        //天气信息
        temperature  = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, 40+5, 21)];
        temperature.textAlignment = NSTextAlignmentCenter;
        temperature.font = [UIFont systemFontOfSize:28.0f];
        temperature.textColor = RGBACOLOR(84, 102, 126, 1);
        temperature.text = @"30°";
        temperature.backgroundColor = [UIColor clearColor];
        [self addSubview:temperature];
        
        
        adress  = [[UILabel alloc] initWithFrame:CGRectMake(10, 28, 25, 12)];
        adress.textAlignment = NSTextAlignmentCenter;
        adress.font = [UIFont systemFontOfSize:6.0f];
        adress.textColor = RGBACOLOR(84, 102, 126, 1);
        //adress.text = @"BeiJing";
        adress.backgroundColor = [UIColor clearColor];
        [self addSubview:adress];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd"];
        NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
        date  = [[UILabel alloc] initWithFrame:CGRectMake(35, 28, 20, 12)];
        date.textAlignment = NSTextAlignmentLeft;
        date.font = [UIFont systemFontOfSize:6.0f];
        date.textColor = RGBACOLOR(84, 102, 126, 1);
        date.text = destDateString;
        date.backgroundColor = [UIColor clearColor];
        [self addSubview:date];
        
        //显示天气的图片
        iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(72, 7, 28, 28)];
        iconImage.image = [UIImage imageNamed:@"00"];
        iconImage.backgroundColor = [UIColor clearColor];
        [self addSubview:iconImage];
        
        //描述
        description  = [[UILabel alloc] initWithFrame:CGRectMake(260, 11, 58, 20)];
        description.text = @"适宜洗车";
        description.font = [UIFont systemFontOfSize:12.0f];
        description.textColor = RGBACOLOR(84, 102, 126, 1);
        description.font = [UIFont systemFontOfSize:8.0f];
        description.textAlignment = NSTextAlignmentCenter;
        description.backgroundColor = [UIColor clearColor];
        [self addSubview:description];
        
        //限行的尾号
        resTitle = [[UILabel alloc] initWithFrame:CGRectMake(118, 11, 69, 20)];
        resTitle.text = [NSString stringWithFormat:@"今日(%@)限行",[self getTodayWeek]];
        resTitle.backgroundColor = [UIColor clearColor];
        resTitle.font = [UIFont systemFontOfSize:8.0f];
        resTitle.textColor = RGBACOLOR(84, 102, 126, 1);
        [self addSubview:resTitle];
        
        //两个按钮的背景
        oneAndTwo = [[UILabel alloc] initWithFrame:CGRectMake(192, 0, 57, 42)];
        oneAndTwo.textAlignment = NSTextAlignmentCenter;
        oneAndTwo.textColor = RGBACOLOR(84, 102, 126, 1);
        oneAndTwo.hidden = YES;
        oneAndTwo.backgroundColor = [UIColor clearColor];
        [self addSubview:oneAndTwo];
        
        
        oneImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 9, 26, 24)];
        [oneAndTwo addSubview:oneImage];
        
        twoImage = [[UIImageView alloc] initWithFrame:CGRectMake(30, 9, 26, 24)];
        [oneAndTwo addSubview:twoImage];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

//刷新天气
- (void)initrefreshWeather:(NSDictionary *)weatherData{
    if (weatherData) {
        NSString *average = [[[weatherData objectForKey:@"result"] objectForKey:@"sk"] objectForKey:@"temp"];
        temperature.text = [NSString stringWithFormat:@"%@°",average];//平均温度
        adress.text = [[[weatherData objectForKey:@"result"] objectForKey:@"today"] objectForKey:@"city"];//地址
        NSString *icon = [[[[weatherData objectForKey:@"result"] objectForKey:@"today"] objectForKey:@"weather_id"] objectForKey:@"fa"];
        iconImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",icon]];//显示图片
        if ([[[[weatherData objectForKey:@"result"] objectForKey:@"today"] objectForKey:@"wash_index"] isEqualToString:@"null"]) {
            description.text = @"适宜洗车";
        }else{
            description.text = [NSString stringWithFormat:@"%@洗车",[[[weatherData objectForKey:@"result"] objectForKey:@"today"] objectForKey:@"wash_index"]];
        }
    }
}

//刷新限行
- (void)initrefreshStopwalk:(NSDictionary *)vioData{
    if ([[vioData objectForKey:@"reason"] isEqualToString:@"该城市限行"]) {
        NSArray *tempArr = [vioData objectForKey:@"limitNo"];
        NSArray *numberArr = [tempArr objectAtIndex:0];
        if ((numberArr != nil && ![numberArr isKindOfClass:[NSNull class]] && numberArr.count != 0)) {
            oneAndTwo.hidden = NO;
            resTitle.hidden = NO;
            NSString *one = [NSString stringWithFormat:@"%ld",(long)[[numberArr objectAtIndex:0] integerValue]];
            NSString *two = [NSString stringWithFormat:@"%ld",(long)[[numberArr objectAtIndex:1] integerValue]];
            oneImage.image = [UIImage imageNamed:one];
            twoImage.image = [UIImage imageNamed:two];
            description.frame = CGRectMake(260, 11, 58, 20);
        }else{
            oneAndTwo.hidden = YES;
            resTitle.hidden = YES;
            description.frame = CGRectMake(100, 11, 58, 20);
        }
    }else if ([[vioData objectForKey:@"reason"] isEqualToString:@"该城市不限行"]){
        oneAndTwo.hidden = YES;
        resTitle.hidden = YES;
        description.frame = CGRectMake(118, 11, 58, 20);
    }
}

- (void)tapView:(UIGestureRecognizer *)tap{
    [delegate changCity];
}

//得到今天是周几
- (NSString *)getTodayWeek{
    NSArray * arrWeek=[NSArray arrayWithObjects:@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六", nil];
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger week = [comps weekday]-1;
    NSString *weekToday = [arrWeek objectAtIndex:week];
    return weekToday;
}

@end

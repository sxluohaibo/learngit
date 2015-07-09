//
//  HAQuestionDetailTopView.m
//  提问列表demo1
//
//  Created by un2lock on 15/5/4.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "HAQuestionDetailTopView.h"
#import "questionModelFrame.h"
#import "questionModel.h"
@interface HAQuestionDetailTopView()
/**左边图片的view*/
@property(nonatomic,weak) UIImageView *iconView;
/**车牌的view*/
@property(nonatomic,weak) UILabel *carNoView;
/**维修保养的view*/
@property(nonatomic,weak) UILabel *wxbyView;
/**车型的view*/
@property(nonatomic,weak) UILabel *carRankView;
/**汽车问题描述的view*/
@property(nonatomic,weak) UILabel *questionNoteView;

/**时间的view*/
@property(nonatomic,weak) UILabel *timeView;

/**已解答与未解答的view*/
@property(nonatomic,weak) UIImageView *questionFlagView;

@end

@implementation HAQuestionDetailTopView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        self.backgroundColor=HAColor(213, 213, 213);
        //图标
        UIImageView *iconView=[[UIImageView alloc] init];
        _iconView=iconView;
        [self addSubview:iconView];
        
        //维修保养
        UILabel *wxbyView=[[UILabel alloc] init];
        wxbyView.text=@"维修保养";
        wxbyView.font=HAStatusCellYXBYFont;
        wxbyView.textColor=HAColor(125,139,160);
        _wxbyView=wxbyView;
        [self addSubview:wxbyView];
        
//        //车牌
//        UILabel *carNoView=[[UILabel alloc] init];
//        carNoView.text=@"京N61389";
//        carNoView.textColor=HAColor(122, 122, 122);
//        carNoView.font=HAStatusCellCarFont;
//        [self addSubview:carNoView];
//        _carNoView=carNoView;
        
        //车型
        UILabel *carRankView=[[UILabel alloc] init];
        carRankView.text=@"奥迪A6";
        carRankView.font=HAStatusCellCarFont;
        carRankView.textColor=HAColor(122, 122, 122);
        [self addSubview:carRankView];
        _carRankView=carRankView;
        
        //时间
        UILabel *timeView=[[UILabel alloc] init];
        timeView.text=@"9:00 PM";
        timeView.textColor=HAColor(122, 122, 122);
        timeView.font=HAStatusCellCarFont;
        [self addSubview:timeView];
        _timeView=timeView;
        
        //问题描述
        UILabel *questionNoteView=[[UILabel alloc] init];
        questionNoteView.numberOfLines=0;
        questionNoteView.text=@"发动机最近总是有异响...很响...很响...很响...";
        questionNoteView.font=HAStatusCellCarFont;
        questionNoteView.textColor=HAColor(122, 122, 122);
        [self addSubview:questionNoteView];
        _questionNoteView=questionNoteView;
        
        UIImageView *questionFlagView=[[UIImageView alloc] init];
        [self addSubview:questionFlagView];
        _questionFlagView=questionFlagView;
    }
    return self;
}
-(void)setQuestionModelFrame:(QuestionModelFrame *)questionModelFrame{
    _questionModelFrame=questionModelFrame;
    
    _iconView.frame=_questionModelFrame.iconViewF;
    _carNoView.frame=_questionModelFrame.carNoViewF;
    _wxbyView.frame=_questionModelFrame.wxbyViewF;
    _carRankView.frame=_questionModelFrame.carRankViewF;
    _questionNoteView.frame=_questionModelFrame.questionNoteViewF;
    _timeView.frame=_questionModelFrame.timeViewF;
    _questionFlagView.frame=_questionModelFrame.questionFlagViewF;
    
    NSString *carBrandText=_questionModelFrame.questionModel.carBrand;
    _carRankView.text=carBrandText;
    
    //设置时间
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-dd-mm HH:mm:ss";
    NSString *createTimeText=_questionModelFrame.questionModel.createTime;
    NSDate  *create_date=[fmt dateFromString:createTimeText];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:create_date];
    int hour=[dateComponent hour];
    int minute=[dateComponent minute];
    NSString *minuteText=@"";
    if(minute==0){
        minuteText=@"00";
    }else{
        minuteText=[NSString stringWithFormat:@"%d",minute];
    }
    NSString *timeText=@"";
    if(hour>12){
        hour=hour-12;
        timeText=[NSString stringWithFormat:@"%d:%@ PM",hour,minuteText];
    }else{
        timeText=[NSString stringWithFormat:@"%d:%@ AM",hour,minuteText];
    }
    _timeView.text=timeText;
    
    //解答与未解答图片设置
    _questionNoteView.text=questionModelFrame.questionModel.questionDescription;
    NSNumber *questionFlag=questionModelFrame.questionModel.questionFlag;
    if([@0 isEqualToNumber:questionFlag]){
        //        _questionFlagView.text=@"未解答";
        UIImage *image=[UIImage imageNamed:@"need_answer_bar"];
        _questionFlagView.image=image;
    }else{
        //        _questionFlagView.text=@"已解答";
        UIImage *image=[UIImage imageNamed:@"answer_bar"];
        _questionFlagView.image=image;
    }
    NSNumber *questionType=questionModelFrame.questionModel.questionType;
    //1：维修保养，2：系统客服，3：延长保修
    //1：维修保养，2：系统客服，3：延长保修
    if([@1 isEqualToNumber:questionType]){
        _wxbyView.text=@"维修保养";
        _iconView.image=[UIImage imageNamed:@"wxby_icon"];
    }else if([@2 isEqualToNumber:questionType]){
        _wxbyView.text=@"系统客服";
        _iconView.image=[UIImage imageNamed:@"khfw_icon"];
    }else if([@3 isEqualToNumber:questionType]){
        _wxbyView.text=@"延长保修";
        _iconView.image=[UIImage imageNamed:@"ycbx_icon"];
    }
}
@end

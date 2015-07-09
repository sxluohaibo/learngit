//
//  QuestionModelFrame.m
//  提问列表demo1
//
//  Created by un2lock on 15/4/24.
//  Copyright (c) 2015年 ywkj. All rights reserved.
//

#import "QuestionModelFrame.h"
#import "QuestionModel.h"

#define HAStatusCellYXBYFont [UIFont systemFontOfSize:15]
#define HAStatusCellCarFont [UIFont systemFontOfSize:12]
#define HAquestionCellBorderW 10
#define HAquestionCellPadding 20
#define HAquestionLabelPadding 7
#define HAquestionNotePaddding 5
@implementation QuestionModelFrame
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}
-(void)setQuestionModel:(QuestionModel *)questionModel
{
    _questionModel=questionModel;
    
    
    //设置汽车图片位置
    CGFloat iconX=HAquestionCellBorderW;
    CGFloat iconY=HAquestionCellBorderW;
    CGFloat iconW=40;
    CGFloat iconH=iconW;
    self.iconViewF=CGRectMake(iconX, iconY, iconW, iconH);
    
    CGFloat wxbyX=CGRectGetMaxX(self.iconViewF) + HAquestionLabelPadding;
    CGFloat wxbyY=iconY;
    CGSize wxbySize=[self sizeWithText:@"维修保养" font:HAStatusCellYXBYFont];
    self.wxbyViewF=(CGRect){{wxbyX, wxbyY},wxbySize};
    
    
//    CGFloat carNoX=CGRectGetMaxX(self.wxbyViewF) + 5;
    CGFloat carNoY=iconY +3;
//    CGSize carNoSize=[self sizeWithText:@"京N61389" font:HAStatusCellCarFont];
//    self.carNoViewF=(CGRect){{carNoX, carNoY},carNoSize};
    
//    CGFloat carRankX=CGRectGetMaxX(self.carNoViewF) +4;
//    CGFloat carRankY=carNoY;
//    CGSize carRankSize=[self sizeWithText:@"奥迪 A6L " font:HAStatusCellCarFont];
//    self.carRankViewF=(CGRect){{carRankX, carRankY},carRankSize};
    
    CGFloat carRankX=CGRectGetMaxX(self.wxbyViewF) +5;
    CGFloat carRankY=carNoY;
    CGSize carRankSize=[self sizeWithText:@"阿斯顿马丁Gremega" font:HAStatusCellCarFont];
    self.carRankViewF=(CGRect){{carRankX, carRankY},carRankSize};
    
    
    CGFloat timeY=carRankY;
    CGSize timeSize=[self sizeWithText:@"24:00 PM" font:HAStatusCellCarFont];
    CGFloat timeX=ScreenWidth - timeSize.width -5;
    self.timeViewF=(CGRect){{timeX, timeY},timeSize};
    
    //是否解答
    CGFloat questionFlagY=CGRectGetMaxY(self.timeViewF) +3;
    CGFloat questionFlagX=timeX;
//    CGSize questionSize=[self sizeWithText:@"未解答" font:HAStatusCellCarFont];
    CGFloat questionFlagH=14;
    CGFloat questionFlagW=37;
    
    self.questionFlagViewF=CGRectMake(questionFlagX, questionFlagY, questionFlagW, questionFlagH);
    
    CGFloat questionNoteX=wxbyX;
    CGFloat questionNoteY=MAX(CGRectGetMaxY(self.wxbyViewF),CGRectGetMaxY(self.carNoViewF))+ 3;
    CGFloat questionMaxW=ScreenWidth -questionNoteX -timeSize.width - 2 * HAquestionCellBorderW;
    NSString *questionNoteText=_questionModel.questionDescription;

    CGSize questionNoteSize=[self sizeWithText:questionNoteText font:HAStatusCellCarFont maxW:questionMaxW];
    
    self.questionNoteViewF=(CGRect){{questionNoteX, questionNoteY},questionNoteSize};
    
    self.cellHeight=MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.questionNoteViewF)) + HAquestionCellPadding;
}
@end

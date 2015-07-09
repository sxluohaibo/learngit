//
//  UIImage+StrethImage.m
//  气泡
//
//  Created by zzy on 14-5-13.
//  Copyright (c) 2014年 zzy. All rights reserved.
//

#import "UIImage+StrethImage.h"

@implementation UIImage (StrethImage)

+(id)strethImageWith:(NSString *)imageName
{
    UIImage *image=[UIImage imageNamed:imageName];
    
    image=[image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    
    return image;
}
+ (UIImage *)resizeWithImageName:(NSString *)name
{
    UIImage *normal = [UIImage imageNamed:name];
    
    //    CGFloat w = normal.size.width * 0.5f ;
    //    CGFloat h = normal.size.height *0.5f ;
    
    CGFloat w = normal.size.width*0.5;
    CGFloat h = normal.size.height*0.5;
    //传入上下左右不需要拉升的边距，只拉伸/填铺中间部分
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(h, w, h, w)];
    
    //    [normal resizableImageWithCapInsets:UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)]
    
    // 1 = width - leftCapWidth  - right
    // 1 = height - topCapHeight  - bottom
    
    //传入上下左右不需要拉升的编剧，只拉伸中间部分，并且传入模式（平铺/拉伸）
    //    [normal :<#(UIEdgeInsets)#> resizingMode:<#(UIImageResizingMode)#>]
    
    //只用传入左边和顶部不需要拉伸的位置，系统会算出右边和底部不需要拉升的位置。并且中间有1X1的点用于拉伸或者平铺
    // 1 = width - leftCapWidth  - right
    // 1 = height - topCapHeight  - bottom
    //    return [normal stretchableImageWithLeftCapWidth:w topCapHeight:h];
}
@end

//
//  CommonMode.m
//  Example_Category
//
//  Created by MCL on 16/9/3.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "CommonMode.h"

@implementation CommonMode

/*根据传过来的文字内容、字体大小、宽度和最大尺寸动态计算文字所占用的size
 * text 文本内容
 * fontSize 字体大小
 * maxSize  size（宽度，1000）
 * return  size （计算的size）
 */
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize
{
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary* attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelSize;
    //如果是IOS6.0
    if (![text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]){
        labelSize = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    }else{
        //如果系统为iOS7.0 iOS7中用以下方法替代过时的iOS6中的sizeWithFont:constrainedToSize:lineBreakMode:方法
        labelSize = [text boundingRectWithSize: maxSize
                                       options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine
                                    attributes:attributes
                                       context:nil].size;
    }
    labelSize.height=ceil(labelSize.height);
    labelSize.width=ceil(labelSize.width);
    return labelSize;
}


//字符宽度
+ (CGFloat)getWidthSize:(NSString *)text andFontOfSize:(CGFloat)sizeFont andFontName:(FontName)type{
    
    CGSize sizeText = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:sizeFont]}];
    CGSize statuseStrSize = CGSizeMake(ceilf(sizeText.width), ceilf(sizeText.height));
    return statuseStrSize.width;
    
}
//字符所占行数
+ (int)getLineNumber:(NSString *)text andFontOfSize:(CGFloat)sizeFont andWidth:(CGFloat)widthSize andFontName:(FontName)type{
    
    CGSize sizeLabel = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:sizeFont]}];
    CGSize statuseStrSize = CGSizeMake(ceilf(sizeLabel.width), ceilf(sizeLabel.height));
    return statuseStrSize.width / widthSize +1;
}

/*
 有两种方法，希望可以有所帮助：
 
 一、使用NSString的方法：
 
     1.字符串加百分号转义使用编码 (这个方法会把参数里面的东西转义)
     NSString *str1 = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     
     2.字符串替换百分号转义使用编码
     NSString *str1 = [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 
 二、使用CFStringRef的方法：
 
     url = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)url, nil, nil, kCFStringEncodingUTF8));
 */

//Unicode encode
+ (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString *outputStr = (NSString *)CFBridgingRelease
    (CFURLCreateStringByAddingPercentEscapes
     (kCFAllocatorDefault,
      (CFStringRef)input,
      NULL,
      (CFStringRef)@"!*'();:@&=+$,/?%#[]",
      kCFStringEncodingUTF8));
    return outputStr;
    
}
//Unicode decode
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


@end

//
//  CommonMode.h
//  Example_Category
//
//  Created by MCL on 16/9/3.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    systemFont =0,
}FontName;

@interface CommonMode : NSObject

/**根据传过来的文字内容、字体大小、宽度和最大尺寸动态计算文字所占用的size
 * text 文本内容
 * fontSize 字体大小
 * maxSize  size（宽度，1000）
 * return  size （计算的size）
 */
+ (CGSize)labelAutoCalculateRectWith:(NSString*)text FontSize:(CGFloat)fontSize MaxSize:(CGSize)maxSize;

/**根据传过来的文字内容、字体大小、字体类型动态计算文字所占用的size
 * text 文本内容
 * fontSize 字体大小
 * FontName  字体类型
 * return  size （计算文本的size.width）
 */
+ (CGFloat)getWidthSize:(NSString *)text andFontOfSize:(CGFloat)sizeFont andFontName:(FontName)type;

+ (int)getLineNumber:(NSString *)text andFontOfSize:(CGFloat)sizeFont andWidth:(CGFloat)widthSize andFontName:(FontName)type; // lineNum * 20

/**
 *  iOS中webView加载URL需要处理特殊字符
 */
+ (NSString *)encodeToPercentEscapeString: (NSString *) input;

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;


@end

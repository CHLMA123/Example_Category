//
//  CommonMode.m
//  Example_Category
//
//  Created by MCL on 16/9/3.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "CommonMode.h"

@implementation CommonMode

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

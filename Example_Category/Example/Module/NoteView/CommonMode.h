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

+ (CGFloat)getWidthSize:(NSString *)text andFontOfSize:(CGFloat)sizeFont andFontName:(FontName)type;


+ (int)getLineNumber:(NSString *)text andFontOfSize:(CGFloat)sizeFont andWidth:(CGFloat)widthSize andFontName:(FontName)type;

+ (NSString *)encodeToPercentEscapeString: (NSString *) input;

+ (NSString *)decodeFromPercentEscapeString: (NSString *) input;


@end

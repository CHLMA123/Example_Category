//
//  NSString+Additions.h
//  Additions
//
//  Created by Johnil on 13-6-15.
//  Copyright (c) 2013年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@interface NSString (Additions)

#pragma mark - java api
// 字符串比较
- (NSUInteger) compareTo: (NSString*) comp;
// 忽略大小写，字符串比较
- (NSUInteger) compareToIgnoreCase: (NSString*) comp;
// 字符串包含
- (bool) contains: (NSString*) substring;
// 字符串以substring结尾
- (bool) endsWith: (NSString*) substring;
// 字符串以substring开头
- (bool) startsWith: (NSString*) substring;

- (NSUInteger) indexOf: (NSString*) substring;
- (NSUInteger) indexOf:(NSString *)substring startingFrom: (NSUInteger) index;
- (NSUInteger) lastIndexOf: (NSString*) substring;
- (NSUInteger) lastIndexOf:(NSString *)substring startingFrom: (NSUInteger) index;
- (NSString *) substringFromIndex:(NSUInteger)from toIndex: (NSUInteger) to;

- (NSString *) trim;
- (NSArray  *) split: (NSString*) token;
- (NSString *) replace: (NSString*) target withString: (NSString*) replacement;
- (NSArray  *) split: (NSString*) token limit: (NSUInteger) maxResults;

// (CGSize)= (width, ?);
- (CGSize)sizeWithConstrainedToWidth:(float)width fromFont:(UIFont *)font1 lineSpace:(float)lineSpace;
- (CGSize)sizeWithConstrainedToSize:(CGSize)size fromFont:(UIFont *)font1 lineSpace:(float)lineSpace;

- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height andWidth:(float)width;
- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height;

@end

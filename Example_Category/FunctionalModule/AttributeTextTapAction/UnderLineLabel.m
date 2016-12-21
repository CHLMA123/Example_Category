//
//  UnderLineLabel.m
//  Example_Category
//
//  Created by MCL on 2016/11/9.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "UnderLineLabel.h"

@implementation UnderLineLabel

- (instancetype)initWithFrame:(CGRect)frame withLableText:(NSString *)lbltext withAttributedString:(NSString *)attstring{

    self = [self initWithFrame:frame];
    if (self) {
        
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:lbltext];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 10;// 设置行高，默认是0
        [content addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, lbltext.length)];
        NSRange underLineRange = NSMakeRange(0, lbltext.length);
        if (![attstring isEqualToString:@""]) {
            underLineRange = [lbltext rangeOfString:attstring];
        }
        NSDictionary * dict = @{
                                NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleThick],
                                NSForegroundColorAttributeName:RGBCOLOR(253, 212, 9),
                                };
        [content setAttributes:dict range:underLineRange];
        self.attributedText = content;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        self.numberOfLines = 0;
//        self.textColor = [UIColor blueColor];
        self.font = [UIFont systemFontOfSize:17.0f];
        
        UITapGestureRecognizer *tapGres = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)];
        [self addGestureRecognizer:tapGres];
    }
    return self;
}

- (void)clicked:(UITapGestureRecognizer *)tapGes
{
    if ([_delegate respondsToSelector:@selector(lineLabelClicked:)]) {
        [_delegate lineLabelClicked:self];
    }
}

//- (void)drawRect:(CGRect)rect
//{
//    [super drawRect:rect];
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    
//    CGContextSetStrokeColorWithColor(ctx, self.textColor.CGColor);  // set as the text's color
//    CGContextSetLineWidth(ctx, 2.0f);
//    
//    CGPoint leftPoint = CGPointMake(0,
//                                    self.frame.size.height);
//    CGPoint rightPoint = CGPointMake(self.frame.size.width,
//                                     self.frame.size.height);
//    CGContextMoveToPoint(ctx, leftPoint.x, leftPoint.y);
//    CGContextAddLineToPoint(ctx, rightPoint.x, rightPoint.y);
//    CGContextStrokePath(ctx);
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

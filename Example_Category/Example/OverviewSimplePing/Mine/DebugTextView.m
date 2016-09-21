//
//  DebugTextView.m
//  Example_Category
//
//  Created by MCL on 16/9/21.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "DebugTextView.h"

@implementation DebugTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.textColor = [UIColor greenColor];
        if ([self respondsToSelector:@selector(layoutManager)]) {
            self.layoutManager.allowsNonContiguousLayout = NO;
        }
        self.font = [UIFont systemFontOfSize:14];
        self.editable = NO;
    }
    return self;
}

- (void)appendText:(NSString *)text {
    if (text.length == 0) {
        return;
    }
    if (self.text.length == 0) {
        self.text = text;
    } else {
        self.text = [NSString stringWithFormat:@"%@\n%@" , self.text, text];
        [self scrollToBottomAnimated:YES];
    }
}

- (void)scrollToBottomAnimated:(BOOL)animated {
    [self scrollRangeToVisible:NSMakeRange(self.text.length, 0)];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    NSString *selectorName = NSStringFromSelector(action);
    return [selectorName hasPrefix:@"copy"] || [selectorName hasPrefix:@"select"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

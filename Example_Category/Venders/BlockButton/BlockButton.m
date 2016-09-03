//
//  BlockButton.m
//  Category_Additions_SET
//
//  Created by MCL on 16/7/23.
//  Copyright © 2016年 CHLMA. All rights reserved.
//

#import "BlockButton.h"

@implementation BlockButton

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
    
}

-(void)clickAction
{
#warning _block是一个代码块，self是一个button,点击按钮的时候，就会调用按钮实例中相应的_block的实现。
    _block(self);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

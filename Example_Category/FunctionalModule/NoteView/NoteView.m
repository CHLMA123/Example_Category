//
//  NoteView.m
//  Example_Category
//
//  Created by MCL on 16/9/3.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "NoteView.h"
#import "CommonMode.h"

@interface NoteView ()

@property (nonatomic, assign) BOOL bRepeateRemaind;

@end

@implementation NoteView

- (id)init
{
    if (self = [super  init])
    {
    }
    return self;
}

- (void)setUpView{
    
    _bRepeateRemaind = YES;//默认是重复提示
    
    //黑色遮罩
    UIView *bgView =[[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:bgView];
    bgView.backgroundColor =[UIColor blackColor];
    bgView.alpha =0.45;
    
    //白色背景Note框
    UIView *activeView =[[UIView alloc]init];
    [self addSubview:activeView];
    activeView.backgroundColor = [UIColor whiteColor];
    
    UILabel *noteLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 250, 40)];
    noteLable.font = [UIFont systemFontOfSize:18];
    noteLable.textColor = RGBCOLOR(100, 100, 100);
    noteLable.text = @"Note";
    noteLable.textAlignment = NSTextAlignmentCenter;
    [activeView addSubview:noteLable];
    
    CGFloat ox = 15;
    CGFloat sw = 220;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ox, CGRectGetMaxY(noteLable.frame), sw, 1)];
    lineView.backgroundColor = RGBCOLOR(150, 150, 150);
    [activeView addSubview:lineView];
    
    NSString *noti1 = @"Motion detection switch has been closed.";
    NSString *noti2 = @"You will be losing important event footages in the cloud if the switch is closed!";
    NSString *noti3 = @"We recommend you turn it on.";
    
    int num1 = [CommonMode getLineNumber:noti1 andFontOfSize:16 andWidth:sw andFontName:0];
    int num2 = [CommonMode getLineNumber:noti2 andFontOfSize:16 andWidth:sw andFontName:0];
    int num3 = [CommonMode getLineNumber:noti3 andFontOfSize:16 andWidth:sw andFontName:0];
    
    UILabel *notify1 = [[UILabel alloc] initWithFrame:CGRectMake(ox, CGRectGetMaxY(lineView.frame)+7, sw, num1 *20)];
    UILabel *notify2 = [[UILabel alloc] initWithFrame:CGRectMake(ox, CGRectGetMaxY(notify1.frame)+15, sw, num2 *20)];
    UILabel *notify3 = [[UILabel alloc] initWithFrame:CGRectMake(ox, CGRectGetMaxY(notify2.frame)+15, sw, num3 *20)];
    notify1.textColor = RGBCOLOR(150, 150, 150);
    notify2.textColor = RGBCOLOR(255, 120, 0);
    notify3.textColor = RGBCOLOR(150, 150, 150);
    
    notify1.text = noti1;
    notify2.text = noti2;
    notify3.text = noti3;
    
    notify1.numberOfLines = 0;
    notify2.numberOfLines = 0;
    notify3.numberOfLines = 0;
    
    notify1.font = [UIFont systemFontOfSize:16];
    notify2.font = [UIFont systemFontOfSize:16];
    notify3.font = [UIFont systemFontOfSize:16];
    
    notify1.textAlignment = NSTextAlignmentLeft;
    notify2.textAlignment = NSTextAlignmentLeft;
    notify3.textAlignment = NSTextAlignmentLeft;
    
    [activeView addSubview:notify1];
    [activeView addSubview:notify2];
    [activeView addSubview:notify3];
    
    NSString *remind = @"Dont'not remaind again";
    CGFloat w = [CommonMode getWidthSize:remind andFontOfSize:16 andFontName:0];
    
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [checkBtn setImage:[UIImage imageNamed:@"checkbox_nor"] forState:UIControlStateNormal];
    [checkBtn setImage:[UIImage imageNamed:@"checkbox_pay"] forState:UIControlStateSelected];
    [checkBtn setTitle:remind forState:UIControlStateNormal];
    [checkBtn setTitleColor:RGBCOLOR(100, 100, 100) forState:UIControlStateNormal];
    [checkBtn addTarget:self action:@selector(remindAction:) forControlEvents:UIControlEventTouchUpInside];
    checkBtn.frame = CGRectMake(235 - w - 40, CGRectGetMaxY(notify3.frame)+10, w+40, 20);
    checkBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    checkBtn.tag = refuseRemindAction;
    [checkBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, w-10)];
    [checkBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [activeView addSubview:checkBtn];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(checkBtn.frame) + 15, 250, 1)];
    lineView2.backgroundColor = RGBCOLOR(150, 150, 150);
    [activeView addSubview:lineView2];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(0, CGRectGetMaxY(lineView2.frame), 124.5, 40);
    closeButton.tag = closeAction;
    NSString *closeTitle = @"close";
    [closeButton setTitle:closeTitle forState:UIControlStateNormal];
    [closeButton setTitleColor:RGBCOLOR(5.f, 175.f, 235.f) forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(NoteViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [activeView addSubview:closeButton];
    
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.frame = CGRectMake(124.5, CGRectGetMaxY(lineView2.frame), 1, 40);
    lineView3.backgroundColor = RGBCOLOR(150, 150, 150);
    [activeView addSubview:lineView3];
    
    UIButton *turnOnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    turnOnButton.frame = CGRectMake(125.5, CGRectGetMaxY(lineView2.frame), 124.5, 40);
    turnOnButton.tag = turnOnAction;
    [turnOnButton setTitle:@"Turn it on" forState:UIControlStateNormal];
    [turnOnButton setTitleColor:RGBCOLOR(5.f, 175.f, 235.f) forState:UIControlStateNormal];
    [turnOnButton addTarget:self action:@selector(NoteViewAction:) forControlEvents:UIControlEventTouchUpInside];
    [activeView addSubview:turnOnButton];
    
    activeView.frame = CGRectMake(35, 100, 250, CGRectGetMaxY(closeButton.frame));
    
    activeView.center = CGPointMake(self.bounds.size.width *0.5, self.bounds.size.height *0.5);
//    // 实现1️⃣
//    activeView.layer.masksToBounds = YES;
//    activeView.layer.cornerRadius = 6.0f;
    // 实现2️⃣
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:activeView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(6, 6)];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc] init];
    masklayer.frame = activeView.bounds;
    masklayer.path = maskPath.CGPath;
    activeView.layer.mask = masklayer;
}

- (void)remindAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        _bRepeateRemaind = NO;
    }
}

- (void)NoteViewAction:(UIButton *)sender{
    NSLog(@"--- NoteViewAction : %ld", (long)sender.tag);
    sender.selected = !sender.selected;
    
    if (_noteViewDelegate && [_noteViewDelegate respondsToSelector:@selector(noteViewActionIndex:withRemindProperty:)])
    {
        [_noteViewDelegate noteViewActionIndex:(NoteViewAction)sender.tag withRemindProperty:_bRepeateRemaind];
    }
    
}

#pragma mark - Action Methods
-(void)show{
    
    self.backgroundColor = [UIColor whiteColor];
    self.alpha = 0.f;
    self.hidden = NO;
    [UIView animateWithDuration:0.35f animations:^{
        
        self.alpha = 1.0f;
        self.backgroundColor = [UIColor clearColor];
        
    } completion:NULL];
    
}

- (void)dismiss
{
    [UIView animateWithDuration:0.35f animations:^{
        
        self.backgroundColor = [UIColor whiteColor];
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        self.hidden =YES;
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

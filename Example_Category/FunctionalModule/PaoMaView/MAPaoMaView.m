//
//  MALable.m
//  UILableDemo
//
//  Created by MACHUNLEI on 16/3/27.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "MAPaoMaView.h"

@interface MAPaoMaView (){
    CGRect currentFrame;        //左侧label的frame
    CGRect behindFrame;         //右侧label的frame
    NSMutableArray *labelArray; //存放左右label的数组
    CGFloat labelHeight;        //label的高度
    BOOL isStop;                //是否为暂停状态
    NSInteger time;             //单次循环的时间
    UIView *showContentView;    //展示的内容视图
}
@end

@implementation MAPaoMaView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        showContentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        showContentView.clipsToBounds = YES;
        [self addSubview: showContentView];
        
        CGFloat viewHeight = frame.size.height;
        labelHeight = viewHeight;
        
        //循环的时间这里取的是4 此数越大速度越快
        time = title.length/4;
        
        UILabel *myLable = [[UILabel alloc]init];
        myLable.text = title;
        myLable.font = [UIFont systemFontOfSize:16.0f];
        myLable.backgroundColor = [UIColor orangeColor];
        
        //计算文本的宽度
        CGFloat calcuWidth = [self widthForTextString:title height:labelHeight fontSize:16.0f];
        
        //这两个frame很重要 分别记录的是左右两个label的frame 而且后面也会需要到这两个frame
        currentFrame = CGRectMake(0, 0, calcuWidth, labelHeight);
        behindFrame = CGRectMake(currentFrame.origin.x+currentFrame.size.width, 0, calcuWidth, labelHeight);
        
        myLable.frame = currentFrame;
        
        [showContentView addSubview:myLable];
        
        labelArray  = [NSMutableArray arrayWithObject:myLable];
        
        //如果文本的宽度大于视图的宽度才开始跑
        if (calcuWidth>frame.size.width) {
            UILabel *behindLabel = [[UILabel alloc]init];
            behindLabel.frame = behindFrame;
            behindLabel.text = title;
            behindLabel.font = [UIFont systemFontOfSize:16.0f];
            behindLabel.backgroundColor = [UIColor orangeColor];
            [labelArray addObject:behindLabel];
            [showContentView addSubview:behindLabel];
        }
    }
    return self;
}

/**
 1.CGAffineTransformMakeTranslation(CGFloat tx, CGFloat ty)（平移:设置平移量）
 
 2.CGAffineTransformMakeScale(CGFloat sx, CGFloat sy)（缩放:设置缩放比例）仅通过设置缩放比例就可实现视图扑面而来和缩进频幕的效果。
 
 3.CGAffineTransformMakeRotation(CGFloat angle)（旋转:设置旋转角度）
 
 以上3个都是针对视图的原定最初位置的中心点为起始参照进行相应操作的，在操作结束之后可对设置量进行还原：
 
 view.transform＝CGAffineTransformIdentity;
 */

- (void)doAnimation
{
    if (isStop) {//如果退出当前PAOMAVIEW所在界面，那么停止递归，否则内存消耗很大
        return;
    }
    
    //UIViewAnimationOptionCurveLinear是为了让lable做匀速动画
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        //取到两个label
        UILabel *lableOne = labelArray[0];
        UILabel *lableTwo = labelArray[1];
        
        //让两个label向左平移
        lableOne.transform = CGAffineTransformMakeTranslation(-currentFrame.size.width, 0);
        lableTwo.transform = CGAffineTransformMakeTranslation(-currentFrame.size.width, 0);
        
    } completion:^(BOOL finished) {
        //两个label水平相邻摆放 内容一样 label1为初始时展示的 label2位于界面的右侧，未显示出来
        //当完成动画时，即第一个label在界面中消失，第二个label位于第一个label的起始位置时，把第一个label放置到第二个label的初始位置
        UILabel *lableOne = labelArray[0];
        lableOne.transform = CGAffineTransformIdentity;
        lableOne.frame = behindFrame;
        
        UILabel *lableTwo = labelArray[1];
        lableTwo.transform = CGAffineTransformIdentity;
        lableTwo.frame = currentFrame;
        
        //在数组中将第一个label放置到右侧，第二个label放置到左侧（因为此时展示的就是labelTwo）
        [labelArray replaceObjectAtIndex:1 withObject:lableOne];
        [labelArray replaceObjectAtIndex:0 withObject:lableTwo];
        
        //递归调用
        [self doAnimation];
    }];
}

- (CGFloat) widthForTextString:(NSString *)tStr height:(CGFloat)tHeight fontSize:(CGFloat)tSize{
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:tSize]};
    CGRect rect = [tStr boundingRectWithSize:CGSizeMake(MAXFLOAT, tHeight) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width+5;
    
}

- (void)start
{
    if (labelArray.count < 2) {//要显示的文本没有超出屏幕范围，就不做滚动显示。
        return;
    }
    
    UILabel *lableOne = labelArray[0];
    [self resumeLayer:lableOne.layer];
    
    UILabel *lableTwo = labelArray[1];
    [self resumeLayer:lableTwo.layer];
    
    isStop = NO;
    [self doAnimation];
    
}

- (void)stop
{
    if (labelArray.count < 2) {
        return;
    }
    
    UILabel *lableOne = labelArray[0];
    [self pauseLayer:lableOne.layer];
    
    UILabel *lableTwo = labelArray[1];
    [self pauseLayer:lableTwo.layer];
    
    isStop = YES;
}

//暂停动画
- (void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    layer.speed = 0;
    
    layer.timeOffset = pausedTime;
}

//恢复动画
- (void)resumeLayer:(CALayer*)layer
{
    //当你是停止状态时，则恢复
    if (isStop) {
        
        CFTimeInterval pauseTime = [layer timeOffset];
        
        layer.speed = 1.0;
        
        layer.timeOffset = 0.0;
        
        layer.beginTime = 0.0;
        
        CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil]-pauseTime;
        
        layer.beginTime = timeSincePause;
    }
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

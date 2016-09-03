//
//  NoteView.h
//  Example_Category
//
//  Created by MCL on 16/9/3.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    refuseRemindAction = 0,
    closeAction,
    turnOnAction,
    
}NoteViewAction;

@class NoteView;

@protocol NoteViewDelegate <NSObject>

- (void)noteViewActionIndex:(NoteViewAction)vType withRemindProperty:(BOOL)bRemind;

@end

@interface NoteView : UIView

@property (nonatomic, weak) id<NoteViewDelegate> noteViewDelegate;

//设置属性
- (void)setUpView;
//显示
-(void)show;
//隐藏
- (void)dismiss;

@end

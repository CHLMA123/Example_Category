//
//  NoteViewController.m
//  Example_Category
//
//  Created by MCL on 16/9/3.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "NoteViewController.h"
#import "NoteView.h"

@interface NoteViewController ()<NoteViewDelegate>

@property (nonatomic, strong) NoteView *noteView;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(_noteView ==nil){
        [self setUpNoteView];
    }else{
        [_noteView show];
    }

}

- (void)setUpNoteView{
    
    _noteView = [[NoteView alloc] init];
    _noteView.frame = [UIScreen mainScreen].bounds;
    _noteView.noteViewDelegate = self;
    [[AppDelegate appDelegate].window addSubview:_noteView];
    [_noteView setUpView];
    [_noteView show];
}

#pragma mark - FSNoteViewDelegate
- (void)noteViewActionIndex:(NoteViewAction)vType withRemindProperty:(BOOL)bRemind{
    
    if (vType == closeAction) {
        
        [_noteView dismiss];
        
    }else if (vType == turnOnAction) {
        
        [_noteView dismiss];
        //...
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

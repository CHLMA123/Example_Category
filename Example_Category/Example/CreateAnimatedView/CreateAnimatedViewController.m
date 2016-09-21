//
//  CreateAnimatedViewController.m
//  Example_Category
//
//  Created by MCL on 16/9/3.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "CreateAnimatedViewController.h"

@interface CreateAnimatedViewController ()

@property (nonatomic, strong) UIImageView *imageView; // 动画

@end

@implementation CreateAnimatedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Add Camera";
    [self.view addSubview:self.imageView];
    self.imageView.frame = CGRectMake(15, 60, 330, 270);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.imageView startAnimating];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.imageView stopAnimating];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        NSMutableArray *animationImages = [NSMutableArray new];
        for (NSInteger i = 1; i != 14; ++ i) {
            UIImage *temp = [UIImage imageNamed:[NSString stringWithFormat:@"addcamera_loading%ld", (long)i]];
            [animationImages addObject:temp];
        }
        
        _imageView = [[UIImageView alloc] init];
        _imageView.animationImages = animationImages;
        _imageView.animationDuration = 1.3;
        _imageView.animationRepeatCount = 0;
        
    }
    return _imageView;
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

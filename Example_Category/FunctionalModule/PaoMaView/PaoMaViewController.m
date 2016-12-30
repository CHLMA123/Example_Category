//
//  ViewController.m
//  UILableDemo
//
//  Created by MCL on 16/3/22.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "PaoMaViewController.h"
#import "MAPaoMaView.h"

@interface PaoMaViewController ()

@property (nonatomic, strong)MAPaoMaView *paoma;

@end

@implementation PaoMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupView];
}

- (void)setupView {
    _paoma = [[MAPaoMaView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50) withTitle:@"全场卖两块，买啥都两块，两块钱，你买不了吃亏，两块钱，你买不了上当，真正的物有所值。拿啥啥便宜 买啥啥不贵，都两块，买啥都两块，全场卖两块，随便挑，随便选，都两块～～ "];
//    _paoma = [[MAPaoMaView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50) withTitle:@"全场卖两块,都两块～～ "];
    [self.view addSubview:_paoma];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width-100)/2, 200, 100, 50);
    [button addTarget:self action:@selector(stopPaoma:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"停止" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:button];
    
    
    UIButton *buttona = [UIButton buttonWithType:UIButtonTypeCustom];
    buttona.frame = CGRectMake((self.view.frame.size.width-100)/2, 300, 100, 50);
    [buttona addTarget:self action:@selector(startPaoMa:) forControlEvents:UIControlEventTouchUpInside];
    [buttona setTitle:@"开始" forState:UIControlStateNormal];
    [buttona setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:buttona];
}

- (void)stopPaoma:(UIButton*)sender
{
    [_paoma stop];
}

- (void)startPaoMa:(UIButton*)sender
{
    [_paoma start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

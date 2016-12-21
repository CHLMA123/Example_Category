//
//  QRCodeCreateViewController.m
//  QRCodeDemo
//
//  Created by puxj on 16/9/12.
//  Copyright © 2016年 bcinfo. All rights reserved.
//

#import "QRCodeCreateViewController.h"
#import "XJQRCodeModel.h"
@interface QRCodeCreateViewController ()

@property (nonatomic, strong) UITextField *tfContent;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *btnClick;

@end

@implementation QRCodeCreateViewController

- (UITextField *)tfContent {
    if (!_tfContent) {
        _tfContent = [[UITextField alloc]init];
        _tfContent.bounds = CGRectMake(0, 0, 250, 40);
        _tfContent.borderStyle = UITextBorderStyleRoundedRect;
        _tfContent.center = CGPointMake(self.view.center.x, 60);
        _tfContent.font = [UIFont systemFontOfSize:14];
        _tfContent.placeholder = @"请输入你想要生成的二维码内容";
    }
    return _tfContent;
}


- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.bounds = CGRectMake(0, 0, 200, 200);
        _imageView.center = CGPointMake(self.view.center.x, SCREEN_HEIGHT-220);
    }
    return _imageView;
}
- (UIButton *)btnClick {
    if (!_btnClick) {
        _btnClick = [[UIButton alloc]init];
        _btnClick.bounds = CGRectMake(0, 0, 100, 40);
        _btnClick.center = CGPointMake(self.view.center.x, 160);
        _btnClick.titleLabel.font = [UIFont  boldSystemFontOfSize:17];
        _btnClick.backgroundColor = [UIColor redColor];
        [_btnClick setTitle:@"生成" forState:UIControlStateNormal];
        [_btnClick addTarget:self action:@selector(onBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnClick;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"生成二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tfContent];
    [self.view addSubview:self.btnClick];
    [self.view addSubview:self.imageView];
}


- (void)onBtnClick {
    
    [self.tfContent resignFirstResponder];
    if (!_isHaveLogo) {
        
        self.imageView.image = [XJQRCodeModel createQRCodeWithString:self.tfContent.text ViewController:self];

    }else {
        
        UIImage *image  = [XJQRCodeModel createQRCodeWithString:self.tfContent.text ViewController:self];
      self.imageView.image = [XJQRCodeModel addIconToQRCodeImage:image withIcon:[UIImage imageNamed:@"add_f_img"] withIconSize:CGSizeMake(50, 50)];
        
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.tfContent resignFirstResponder];

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

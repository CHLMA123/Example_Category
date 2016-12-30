//
//  KeyChainViewController.m
//  MAPayPalDemo
//
//  Created by MCL on 16/3/19.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "KeyChainViewController.h"
#import "MUserDataManager.h"
#import "MTableViewCell.h"

@interface KeyChainViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIButton *showBtn;
@property (nonatomic,strong) UITextField *passwordTextField;
@property (nonatomic,strong) UILabel *strLbl;
@property (nonatomic,strong) UILabel *resultLbl;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) MTableViewCell *tableViewCell;

@end

@implementation KeyChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"1",@"2",@"3",@"4",@"5"];
    [self setupView];
    
    [MUserDataManager savePassWord:@"123" usrname:@"1"];
    [MUserDataManager savePassWord:@"123" usrname:@"12"];
    [MUserDataManager savePassWord:@"123" usrname:@"123"];
    [MUserDataManager savePassWord:@"111" usrname:@"123"];
    [MUserDataManager readPassWordwithAccount:@"1"];
}

- (void)setupView{
    
    self.strLbl = [[UILabel alloc] initWithFrame:(CGRect){10,80,100,44}];
    self.strLbl.backgroundColor = [UIColor magentaColor];
    self.strLbl.alpha = 0.5;
    self.strLbl.textColor = [UIColor blackColor];
    self.strLbl.text = @"PassWord:";

    self.resultLbl = [[UILabel alloc] initWithFrame:(CGRect){111,80,200,44}];
    self.resultLbl.backgroundColor = [UIColor whiteColor];
    self.resultLbl.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.resultLbl.layer.borderWidth = 2;
    self.resultLbl.textColor = [UIColor blackColor];

    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(10, 130, 300, 44)];
    self.passwordTextField.backgroundColor = [UIColor whiteColor];
    self.passwordTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.passwordTextField.layer.borderWidth = 2;
    self.passwordTextField.delegate = self;
    self.passwordTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
    self.passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.passwordTextField.tag = 100;
    
    self.showBtn = [[UIButton alloc] initWithFrame:CGRectMake(55, 180, 200, 44)];
    self.showBtn.backgroundColor = [UIColor yellowColor];
    [self.showBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.showBtn setTitle:@"设置并显示" forState:UIControlStateNormal];
    [self.showBtn addTarget:self action:@selector(SettingAndShow) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_strLbl];
    [self.view addSubview:_resultLbl];
    [self.view addSubview:_passwordTextField];
    [self.view addSubview:_showBtn];
    
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(10, 230, 300, 200)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithRed:255/255 green:25/255 blue:255/255 alpha:0.5];
    [self.view addSubview:self.tableView];
}

- (void)SettingAndShow{
    [MUserDataManager savePassWord:self.passwordTextField.text];
    //    [MAUserDataManager savePassWord:self.passwordTextField.text usrname:@"chlma"];
    self.resultLbl.text = [MUserDataManager readPassWord];
}

# pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

# pragma mark - cell 的长按菜单定制
# pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"cell";
    self.tableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!_tableViewCell) {
        _tableViewCell = [[MTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    self.tableViewCell.backgroundColor = [UIColor lightGrayColor];
    self.tableViewCell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    self.tableViewCell.textLabel.textColor = [UIColor blackColor];
    //cell 的长按菜单定制
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
    [_tableViewCell addGestureRecognizer:longPressGesture];
    return _tableViewCell;
}

- (void)cellLongPress:(UIGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint location = [recognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
        MTableViewCell *cell = (MTableViewCell *)recognizer.view;
        //这里把cell做为第一响应(cell默认是无法成为responder,需要重写canBecomeFirstResponder方法)
        [cell becomeFirstResponder];
        
        UIMenuItem *itCopy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(handleCopyCell:)];
        UIMenuItem *itDelete = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(handleDeleteCell:)];
        UIMenuController *menu = [UIMenuController sharedMenuController];
        [menu setMenuItems:[NSArray arrayWithObjects:itCopy, itDelete,  nil]];
        [menu setTargetRect:cell.frame inView:self.tableView];
        [menu setMenuVisible:YES animated:YES];
    }
}

- (void)handleCopyCell:(id)sender{//复制cell
    NSLog(@"handle copy cell");
}

- (void)handleDeleteCell:(id)sender{//删除cell
    NSLog(@"handle delete cell");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/**
 
 通常情况下，我们用NSUserDefaults存储数据信息，但是对于一些私密信息，比如密码、证书等等，就需要使用更为安全的keychain了。
 keychain里保存的信息不会因App被删除而丢失，在用户重新安装App后依然有效，数据还在。
 
 使用苹果官方发布的KeychainItemWrapper或者SFHFKeychainUtils很方便
 
 需要导入Security.framework
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

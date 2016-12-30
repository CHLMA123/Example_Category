//
//  RootViewController.m
//  Example_Category
//
//  Created by MCL on 2016/12/12.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "RootViewController.h"
#import "Reachability.h"
#import "ModuleViewController.h"
#import "LoadHtmlDocController.h"
#import "AttributeTextTapController.h"
#import "SingleClass.h"
#import "AVFoundationController.h"
#import "OverviewStructureController1.h"
#import "NoteViewController.h"
#import "PaoMaViewController.h"
#import "NSURLSessionController.h"
#import "STDDebugPingViewController.h"
#import "OverviewNSDateController.h"
#import "RegularViewController.h"
#import "SGNetObserver.h"
#import "WebViewController.h"

#import "XTPopView.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface RootViewController ()<UITableViewDelegate, UITableViewDataSource, XTPopViewDelegate>

@property (nonatomic, strong) UIButton      *customRNavBtn;

@property (nonatomic, strong) Reachability  *hostReachability;
@property (nonatomic, strong) NSString      *hostReachTag;

@property (nonatomic, strong) UITableView   *tableview;
@property (nonatomic, strong) NSArray       *datasource;
@property (nonatomic, assign) NSInteger     currentSelIndex;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Demo";
    self.view.backgroundColor = RGBCOLOR(48.f, 48.f, 64.f);
    
    [self initNavView];
    
    [self setupData];
    [self setupView];
    
    //[self networkMonitoringAction];             // 0『iOS应用networkMonitoring』
    SGNetObserver *oberver = [SGNetObserver defultObsever];
    [oberver startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStatusChanged:) name:SGReachabilityChangedNotification object:nil];
    //[self lldbDebugTest];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SGReachabilityChangedNotification object:nil];
}

- (void)networkStatusChanged:(NSNotification *)notify{
    NSLog(@"notify-------%@",notify.userInfo);
}

- (void)lldbDebugTest{
    static NSInteger i = 0;
    while (1) {
        NSLog(@"%ld", (long)i++);
    }
}

#pragma mark - Private Methods
- (void)setupView{
    
    [self.view addSubview:self.tableview];
}

- (void)setupData{
    
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    // 0 ~ 9
    [mArr addObject:@"LoadModuleView"];
    [mArr addObject:@"LoadHtmlDocView"];
    [mArr addObject:@"attributeTextTapAction"];
    [mArr addObject:@"overviewSingletonMode"];
    [mArr addObject:@"overviewAVFoundation"];
    [mArr addObject:@"overviewStructure"];
    [mArr addObject:@"overviewNoteView"];
    [mArr addObject:@"overviewPaoMaView"];
    [mArr addObject:@"LoadNSURLSessionRequest"];
    [mArr addObject:@"overviewSimplePing"];
    // 10 ~ ..
    [mArr addObject:@"overviewNSDate"];
    [mArr addObject:@"OverviewRegularExpression"];
    [mArr addObject:@"BackBarWebBrowser"];
    self.datasource = mArr;
}

- (void)responseCellAction:(NSIndexPath *)indexpath{

    switch (indexpath.row) {
        case 0:{ [self LoadModuleView]; }
            break;
        case 1:{ [self LoadHtmlDocView]; }
            break;
        case 2:{ [self attributeTextTapAction]; }
            break;
        case 3:{ [self overviewSingletonMode]; }
            break;
        case 4:{ [self overviewAVFoundation]; }
            break;
        case 5:{ [self overviewStructure]; }
            break;
        case 6:{ [self overviewNoteView]; }
            break;
        case 7:{ [self overviewPaoMaView]; }
            break;
        case 8:{ [self LoadNSURLSessionRequest]; }
            break;
        case 9:{ [self overviewSimplePing]; }
            break;
        case 10:{ [self overviewNSDate]; }
            break;
        case 11:{ [self OverviewRegularExpression]; }
            break;
        case 12:{ [self BackBarWebBrowser]; }
            break;
            
        default:
            break;
    }
}

#pragma mark ----------------------------initNavView---------------------------------------
- (void)initNavView{
    
    _customRNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _customRNavBtn.frame = CGRectMake(0, 0, 40, 40);
    [_customRNavBtn setTitle:@"➕" forState:UIControlStateNormal];
    [_customRNavBtn addTarget:self action:@selector(mCustomRNavBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:_customRNavBtn];
    self.navigationItem.rightBarButtonItem = btn;
}

- (void)mCustomRNavBtnClick:(UIButton *)btn{
    
    CGPoint point = CGPointMake(_customRNavBtn.center.x,_customRNavBtn.frame.origin.y + 64);
    XTPopView *view1 = [[XTPopView alloc] initWithOrigin:point Width:130 Height:40 * 4 Type:XTTypeOfUpRight Color:[UIColor colorWithRed:0.2737 green:0.2737 blue:0.2737 alpha:1.0]];
    view1.dataArray = @[@"11111",@"22222", @"33333", @"44444"];
    view1.images = @[@"发起群聊",@"添加朋友", @"扫一扫", @"付款"];
    view1.fontSize = 13;
    view1.row_height = 40;
    view1.titleTextColor = [UIColor whiteColor];
    view1.delegate = self;
    [view1 popView];
}
- (void)selectIndexPathRow:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            NSLog(@"Click 0 ......");
        }
            break;
        case 1:
        {
            NSLog(@"Clikc 1 ......");
        }
            break;
        case 2:
        {
            NSLog(@"Clikc 2 ......");
        }
            break;
        case 3:
        {
            NSLog(@"Clikc 3 ......");
        }
            break;
        default:
            break;
    }
}
#pragma mark ------------------------------------------------------------------------

#pragma mark - BackBarWebBrowser
- (void)BackBarWebBrowser{
    
    WebViewController *push = [[WebViewController alloc] init];
    push.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:push animated:YES];
}

#pragma mark - OverviewNSDate
- (void)OverviewRegularExpression{
    
    RegularViewController *push = [[RegularViewController alloc] init];
    push.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:push animated:YES];
}

#pragma mark - OverviewNSDate
- (void)overviewNSDate{
    
    OverviewNSDateController *push = [[OverviewNSDateController alloc] init];
    push.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:push animated:YES];
}
#pragma mark - OverviewSimplePing
- (void)overviewSimplePing{
    
    STDDebugPingViewController *push = [[STDDebugPingViewController alloc] init];
    push.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:push animated:YES];
}

#pragma mark - NSURLSessionController
- (void)LoadNSURLSessionRequest{
    
    NSURLSessionController *push = [[NSURLSessionController alloc] init];
    push.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:push animated:YES];
}

#pragma mark - OverviewPaoMaView
- (void)overviewPaoMaView{

    PaoMaViewController *push = [[PaoMaViewController alloc] init];
    push.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:push animated:YES];
}

#pragma mark - addNoteView
- (void)overviewNoteView{
    
    NoteViewController *push = [[NoteViewController alloc] init];
    push.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:push animated:YES];
}

#pragma mark - OverviewStructure
- (void)overviewStructure{
    
    OverviewStructureController1 *push = [[OverviewStructureController1 alloc] init];
    push.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:push animated:YES];
}

#pragma mark - OverviewAVFoundation
- (void)overviewAVFoundation{
    
    AVFoundationController *push = [[AVFoundationController alloc] init];
    push.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:push animated:YES];
}

#pragma mark - Objective-c单例模式详解
- (void)overviewSingletonMode{
    
    NSLog(@"开始《《《");
    SingleClass *obj1 = [SingleClass shareInstance] ;
    NSLog(@"obj1 = %@.", obj1) ;
    
    SingleClass *obj2 = [SingleClass shareInstance] ;
    NSLog(@"obj2 = %@.", obj2) ;
    
    SingleClass *obj3 = [[SingleClass alloc] init] ;
    NSLog(@"obj3 = %@.", obj3) ;
    
    SingleClass* obj4 = [[SingleClass alloc] init] ;
    NSLog(@"obj4 = %@.", [obj4 copy]) ;
    
    NSLog(@"结束》》》");
    
    /*
     2016-09-07 17:55:11.601 Example_Category[3267:638012] 开始《《《
     2016-09-07 17:55:11.605 Example_Category[3267:638012] obj1 = <SingleClass: 0x16586be0; frame = (0 0; 0 0); layer = <CALayer: 0x165565a0>>.
     2016-09-07 17:55:11.605 Example_Category[3267:638012] obj2 = <SingleClass: 0x16586be0; frame = (0 0; 0 0); layer = <CALayer: 0x165565a0>>.
     2016-09-07 17:55:11.606 Example_Category[3267:638012] obj3 = <SingleClass: 0x16586be0; frame = (0 0; 0 0); layer = <CALayer: 0x165565a0>>.
     2016-09-07 17:55:11.606 Example_Category[3267:638012] obj4 = <SingleClass: 0x16586be0; frame = (0 0; 0 0); layer = <CALayer: 0x165565a0>>.
     2016-09-07 17:55:11.606 Example_Category[3267:638012] 结束》》》
     */
}

#pragma mark -  label中的文字添加点击事件 + 计算label的Size的方法总结
// https://github.com/lyb5834/YBAttributeTextTapAction
- (void)attributeTextTapAction{
    
    AttributeTextTapController *vc = [[AttributeTextTapController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - LoadHtmlDocView
- (void)LoadHtmlDocView{
    
    LoadHtmlDocController *vc = [[LoadHtmlDocController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - LoadModuleView
- (void)LoadModuleView{
    
    ModuleViewController *vc = [[ModuleViewController alloc] init];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - reachability
- (void)networkMonitoringAction{
    
//    // 监测网络情况
//    [[NSNotificationCenter defaultCenter] addObserver: self
//                                             selector: @selector(reachabilityChanged:)
//                                                 name: kReachabilityChangedNotification
//                                               object: nil];
//    NSString *remoteHostName = @"www.apple.com";
//    NSString *remoteHostLabelFormatString = NSLocalizedString(@"Remote Host: %@", @"Remote host label format string");
//    UILabel *remoteHostLabel = [[UILabel alloc] init];
//    remoteHostLabel.text = [NSString stringWithFormat:remoteHostLabelFormatString, remoteHostName];
//    self.hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
//    [self.hostReachability startNotifier];
    
}

//- (void)reachabilityChanged:(NSNotification *)no{
//    Reachability* curReach = [no object];
//    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
//    NetworkStatus status = [curReach currentReachabilityStatus];
//    switch (status)
//    {
//            
//        case NotReachable:
//            NSLog(@"====当前网络状态不可达=======");
//            //其他处理
//            self.hostReachTag = @"当前网络状态不可达";
//            break;
//            
//        case ReachableViaWiFi:
//            NSLog(@"====当前网络状态为Wifi=======");
//            self.hostReachTag = @"ReachableViaWiFi";
//            //其他处理
//            break;
//        case kReachableVia2G:
//            NSLog(@"====当前网络状态为2G=======");
//            self.hostReachTag = @"kReachableVia2G";
//            break;
//        case kReachableVia3G:
//            NSLog(@"====当前网络状态为3G=======");
//            //其他处理
//            self.hostReachTag = @"kReachableVia3G";
//            break;
//        case kRaeachableVia4G:
//            NSLog(@"====当前网络状态为4G=======");
//            self.hostReachTag = @"kRaeachableVia4G";
//            //其他处理
//            break;
//        default:
//            NSLog(@"你是外星来的吗？");
//            //其他处理
//            self.hostReachTag = @"你是外星来的吗？";
//            break;
//    }
//    
//    NSLog(@"### self.hostReachTag = %@", self.hostReachTag);
//}
//
#pragma mark ------------------------------------------------------------------------

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"MZCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%ld: %@",(long)indexPath.row, [_datasource objectAtIndex:indexPath.row]];
    cell.textLabel.textColor = RGBCOLOR(187.f, 190.f, 199.f);
    cell.textLabel.highlightedTextColor = RGBCOLOR(9.f, 235.f, 255.f);
    UIView *cellBgView = [[UIView alloc] initWithFrame:cell.frame];
    cellBgView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = cellBgView;
    if (self.currentSelIndex == 0) {
        // Do Nothing...
    }else{
    
        if (self.currentSelIndex == indexPath.row + 1) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.textLabel.textColor = RGBCOLOR(9.f, 235.f, 255.f);
            cell.backgroundColor = RGBCOLOR(57.f, 57.f, 66.f);
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.currentSelIndex = indexPath.row +1;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView reloadData];
    NSLog(@"Inter %ld Page", (long)indexPath.row);
    
    [self responseCellAction:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
}

#pragma mark - Setter && Getter

- (UITableView *)tableview{

    if (_tableview == nil) {
        
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableview.backgroundColor = [UIColor clearColor];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

- (NSArray *)datasource{

    if (_datasource == nil) {
        _datasource = [[NSArray alloc] init];
    }
    return _datasource;
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

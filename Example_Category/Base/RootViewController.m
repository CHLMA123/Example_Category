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
#import "UITapImageView.h"

#import "LocationViewController.h"
#import "KeyChainViewController.h"
#import "JS_OC_ControlViewController.h"
#import "MyRuntimeViewController.h"
#import "GestureRecognizerController.h"

#import "NSThread+Externsion.h"

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

typedef NS_ENUM(NSInteger, TableviewCellIndex) {
    LoadModuleViewCellIndex =0,
    LoadHtmlDocViewCellIndex,
    attributeTextTapActionCellIndex,
    overviewSingletonModeCellIndex,
    overviewAVFoundationCellIndex,
    overviewStructureCellIndex,
    overviewNoteViewCellIndex,
    overviewPaoMaViewCellIndex,
    LoadNSURLSessionRequestCellIndex,
    overviewSimplePingCellIndex,
    overviewNSDateCellIndex,
    OverviewRegularExpressionCellIndex,
    BackBarWebBrowserCellIndex,
    LocationViewCellIndex,
    KeyChainViewCellIndex,
    JS_OC_ControlCellIndex,
    RuntimeMethodTestCellIndex,
    GestureMethodTestCellIndex,
    
    TableviewCellIndexCount,		  // Cell 总个数
};

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
    //[self testLocalizedString];
    //[self printfSandBoxPaths];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        BOOL b = [[NSThread currentThread] isMainQueue];
        NSLog(@"111 %d", b);
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            BOOL b1 = [[NSThread currentThread] isMainQueue];
            NSLog(@"222 %d", b1);
        });
    });
    
    
    
//    // Objective-C 中self 和 super
//    NSLog(@"self ' class is %@", [self class]);
//    NSLog(@"super' class is %@", [super class]);
    /*
     2017-02-09 15:35:10.424 Example_Category[11607:159962] self ' class is RootViewController
     2017-02-09 15:35:10.425 Example_Category[11607:159962] super' class is RootViewController
     真相
     
     self 是类的隐藏的参数，指向当前当前调用方法的类，另一个隐藏参数是 _cmd，代表当前类方法的 selector。这里只关注这个 self。super 是个啥？super 并不是隐藏的参数，它只是一个“编译器指示符”，它和 self 指向的是相同的消息接收者，拿上面的代码为例，不论是用 [self viewDidLoad] 还是 [super viewDidLoad]，接收“viewDidLoad”这个消息的接收者都是 同一个对象。不同的是，super 告诉编译器，当调用 viewDidLoad 的方法时，要去调用父类的方法，而不是本类里的。
     
     当使用 self 调用方法时，会从当前类的方法列表中开始找，如果没有，就从父类中再找；而当使用 super 时，则从父类的方法列表中开始找，然后调用父类的这个方法。
     http://blog.csdn.net/yhawaii/article/details/6991127
     */
    
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SGReachabilityChangedNotification object:nil];
}

- (void)networkStatusChanged:(NSNotification *)notify{
    NSLog(@"notify-------%@",notify.userInfo);
}

//- (void)printfSandBoxPaths{
//
//    NSLog(@"%@",[self documentPath]);
//    NSLog(@"%@",[self tempPath]);
//    NSLog(@"%@",[self cachesPath]);
//    /*
//     2017-02-09 11:07:18.840644 Example_Category[2789:1053770] /var/mobile/Containers/Data/Application/2B3FFF02-BD8C-42D3-BD88-6D46AF9F9FB5/Documents
//     2017-02-09 11:07:18.840723 Example_Category[2789:1053770] /private/var/mobile/Containers/Data/Application/2B3FFF02-BD8C-42D3-BD88-6D46AF9F9FB5/tmp/
//     2017-02-09 11:07:18.840869 Example_Category[2789:1053770] /var/mobile/Containers/Data/Application/2B3FFF02-BD8C-42D3-BD88-6D46AF9F9FB5/Library/
//     */
//}
//
//- (NSString *)documentPath
//{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    return documentsDirectory;
//}
//
//- (NSString *)tempPath
//{
//    NSString *tempDirectory = NSTemporaryDirectory();
//    return tempDirectory;
//}
//
//- (NSString *)cachesPath
//{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
//    NSString *cachesDirectory = [paths objectAtIndex:0];
//    return cachesDirectory;
//}

- (void)testLocalizedString{

    NSArray *languages = [[NSUserDefaults standardUserDefaults] valueForKey:@"AppleLanguages"];
    NSString *currentLanguage = languages.firstObject;
    NSLog(@"模拟器当前语言：%@",currentLanguage);
    
    //多人开发使用自定义命名的本地字符串文件table
    self.title = NSLocalizedStringFromTable(@"CustomLocalizableString", @"CustomLocalizable", nil);
    //本地化字符串文件table
    NSString *navTitle = NSLocalizedString(@"LocalizableString", nil);
    [_customRNavBtn setTitle:navTitle forState:UIControlStateNormal];
}

- (void)testGCDFlowing{

    /*
     对于重度磁盘I/O依赖的后台任务，如果对实时性要求不高，放到DISPATCH_QUEUE_PRIORITY_BACKGROUND Queue中是个好习惯，对系统更友好。
     实际上I/O Throttle还分为好几种，有Disk I/O Throttle，Memory I/O Throttle，和Network I/O Throttle。语义类似只不过场景不同。
     */
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        
        NSLog(@"iOS编程中throttle那些事:http://www.cocoachina.com/ios/20170106/18525.html");
        NSLog(@"实现iOS中的函数节流和函数防抖:https://satanwoo.github.io/2015/09/30/Debounce-and-Throttle-in-iOS/");
        /*
         首先是函数节流（Throttling），意思就是说一个函数在一定时间内，只能执行有限次数。比如，一个函数在100毫秒呢，最多只能执行一次。当然，也可以不执行！
         函数防抖的意思就是，一个函数被执行过一次以后，在一段时间内不能再次执行。比如，一个函数执行完了之后，100毫秒之内不能第二次执行。
         这两玩意有啥区别啊？这么解释吧，函数防抖可能会被无限延迟。用现实乘坐公交车中的例子来说，Throttle就是准点就发车（比如15分钟一班公交车）；Debounce就是黑车，上了一个人以后，司机说，再等一个人，等不到，咱么10分钟后出发。但是呢，如果在10分钟内又有一个人上车，这个10分钟自动延后直到等待的10分钟内没人上车了。换句话说，Debounce可以理解成merge一段时间的一系列相同函数调用。
         */
    });
}

/**
 lldbDebugTest
 */
- (void)lldbDebugTest{
    static NSInteger i = 0;
    while (1) {
        NSLog(@"%ld", (long)i++);
    }
}

#pragma mark - Private Methods
#pragma mark ----------------------------initNavView---------------------------------------
- (void)initNavView{
    
    _customRNavBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _customRNavBtn.frame = CGRectMake(0, 0, 40, 40);
    [_customRNavBtn setTitle:@"➕" forState:UIControlStateNormal];
    [_customRNavBtn addTarget:self action:@selector(mCustomRNavBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *RNavBtn = [[UIBarButtonItem alloc] initWithCustomView:_customRNavBtn];
    //    self.navigationItem.rightBarButtonItem = btn;
    
    UITapImageView *tapImgV = [[UITapImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    tapImgV.image = [UIImage imageNamed:@"Icon-120"];
//    tapImgV.image = [UIImage imageNamed:@"添加朋友"];
    [tapImgV addTapBlock:^(id obj) {
        
        NSLog(@"添加朋友被点击了。。。");
    }];
    UIBarButtonItem *RNavBtn2 = [[UIBarButtonItem alloc] initWithCustomView:tapImgV];
    
    self.navigationItem.rightBarButtonItems = @[RNavBtn, RNavBtn2];
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
            NSLog(@"Click 0 ...");
        }
            break;
        case 1:
        {
            NSLog(@"Click 1 ...");
        }
            break;
        case 2:
        {
            NSLog(@"Click 2 ...");
        }
            break;
        case 3:
        {
            NSLog(@"Click 3 ...");
        }
            break;
        default:
            break;
    }
}

- (void)setupView{
    
    [self.view addSubview:self.tableview];
    @synchronized (self) {
//        NSLog(@"iOS 中线程同步：使用@synchronized解决线程同步问题相比较NSLock要简单一些，日常开发中也更推荐使用此方法。首先选择一个对象作为同步对象（一般使用self），然后将”加锁代码”（争夺资源的读取、修改代码）放到代码块中。@synchronized中的代码执行时先检查同步对象是否被另一个线程占用，如果占用该线程就会处于等待状态，直到同步对象被释放。http://www.cnblogs.com/kenshincui/p/3983982.html#synchronized");
    }
}

- (void)setupData{
    
    NSMutableArray *mArr = [[NSMutableArray alloc] init];
    // 0 ~ 4
    [mArr addObject:@"LoadModuleView"];
    [mArr addObject:@"LoadHtmlDocView"];
    [mArr addObject:@"attributeTextTapAction"];
    [mArr addObject:@"overviewSingletonMode"];
    [mArr addObject:@"overviewAVFoundation"];
    // 5 ~ 9
    [mArr addObject:@"overviewStructure"];
    [mArr addObject:@"overviewNoteView"];
    [mArr addObject:@"overviewPaoMaView"];
    [mArr addObject:@"LoadNSURLSessionRequest"];
    [mArr addObject:@"overviewSimplePing"];
    // 10 ~ 14
    [mArr addObject:@"overviewNSDate"];
    [mArr addObject:@"OverviewRegularExpression"];
    [mArr addObject:@"BackBarWebBrowser"];
    [mArr addObject:@"LocationView"];
    [mArr addObject:@"KeyChainView"];
    
    // 15 ~ 19
    [mArr addObject:@"JS_OC_Control"];
    [mArr addObject:@"RuntimeMethodTest"];
    [mArr addObject:@"GestureMethodTest"];
    
    self.datasource = mArr;
}

- (void)responseCellAction:(NSIndexPath *)indexpath{

    switch (indexpath.row) {
        case LoadModuleViewCellIndex:
            [self LoadModuleView];
            break;
        case LoadHtmlDocViewCellIndex:
            [self LoadHtmlDocView];
            break;
        case attributeTextTapActionCellIndex:
            [self attributeTextTapAction];
            break;
        case overviewSingletonModeCellIndex:
            [self overviewSingletonMode];
            break;
        case overviewAVFoundationCellIndex:
            [self overviewAVFoundation];
            break;
            
        case overviewStructureCellIndex:
            [self overviewStructure];
            break;
        case overviewNoteViewCellIndex:
            [self overviewNoteView];
            break;
        case overviewPaoMaViewCellIndex:
            [self overviewPaoMaView];
            break;
        case LoadNSURLSessionRequestCellIndex:
            [self LoadNSURLSessionRequest];
            break;
        case overviewSimplePingCellIndex:
            [self overviewSimplePing];
            break;
            
        case overviewNSDateCellIndex:
            [self overviewNSDate];
            break;
        case OverviewRegularExpressionCellIndex:
            [self OverviewRegularExpression];
            break;
        case BackBarWebBrowserCellIndex:
            [self BackBarWebBrowser];
            break;
        case LocationViewCellIndex:
            [self LocationView];
            break;
        case KeyChainViewCellIndex:
            [self KeyChainView];
            break;
            
        case JS_OC_ControlCellIndex:
            [self JS_OC_Control];
            break;
        case RuntimeMethodTestCellIndex:
            [self MyRuntimeMethodTest];
            break;
        case GestureMethodTestCellIndex:
            [self GestureMethodTest];
            break;
            
        default:
            break;
    }
}

#pragma mark ------------------------------------------------------------------------

#pragma mark -
- (void)GestureMethodTest{
    
    GestureRecognizerController *push = [[GestureRecognizerController alloc] init];
    push.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:push animated:YES];
}

#pragma mark - RuntimeMethodTest
- (void)MyRuntimeMethodTest{
    
    MyRuntimeViewController *push = [[MyRuntimeViewController alloc] init];
    push.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:push animated:YES];
}

#pragma mark - JS_OC_Control
- (void)JS_OC_Control{
    
    JS_OC_ControlViewController *push = [[JS_OC_ControlViewController alloc] init];
    [self.navigationController pushViewController:push animated:YES];
}

#pragma mark - KeyChainView
- (void)KeyChainView{
    
    KeyChainViewController *push = [[KeyChainViewController alloc] init];
    push.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:push animated:YES];
}

#pragma mark - LocationView
- (void)LocationView{
    
    LocationViewController *push = [[LocationViewController alloc] init];
    push.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:push animated:YES];
}

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

    return TableviewCellIndexCount;
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

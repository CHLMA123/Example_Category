# Example_Category


[/**
    0 利用symbollicatecrash工具查看crash文件

    1.打开终端输入以下命令：
    find /Applications/Xcode.app -name symbolicatecrash -type f 

    APP210deMacBook-Pro:~ APP210$ find /Applications/Xcode-beta.app -name symbolicatecrash -type f
    /Applications/Xcode-beta.app/Contents/Developer/Platforms/AppleTVSimulator.platform/Developer/Library/PrivateFrameworks/DVTFoundation.framework/symbolicatecrash
    /Applications/Xcode-beta.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Library/PrivateFrameworks/DVTFoundation.framework/symbolicatecrash
    /Applications/Xcode-beta.app/Contents/Developer/Platforms/WatchSimulator.platform/Developer/Library/PrivateFrameworks/DVTFoundation.framework/symbolicatecrash
    /Applications/Xcode-beta.app/Contents/SharedFrameworks/DVTFoundation.framework/Versions/A/Resources/symbolicatecrash

    2）设置Xcode DEVELOPER_DIR:
    export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer" 

    APP210deMacBook-Pro:crash8 APP210$ export DEVELOPER_DIR=/Applications/Xcode-beta.app/Contents/developer

    3) 然后执行命令：
    ./symbolicatecrash ./*.crash ./*.app.dSYM>symbolic.crash

    APP210deMacBook-Pro:crash8 APP210$ ./symbolicatecrash ./*.crash ./*.app.dSYM>symbolic.crash

*/]

[/**让按钮无法点击的2种方法

•	button.enabled = NO;
◦	【会】进入UIControlStateDisabled状态
•	button.userInteractionEnabled = NO;
◦	【不会】进入UIControlStateDisabled状态，继续保持当前状态
*/]

<!--**设置特殊字段的大小，颜色，字体-->
<!--NSInteger leght = [pLabel.text length];-->
<!--NSMutableAttributedString *richText = [[NSMutableAttributedString alloc] initWithString:pLabel.text];-->
<!--//设置特殊字段的大小，颜色，字体-->
<!-- -->
<!--[richText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16.0] range:NSMakeRange(0, leght)];//设置字体大小-->
<!--[richText addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, leght)];//设置字体颜色-->
<!---->
<!--[richText addAttribute:NSObliquenessAttributeName value:@1 range:NSMakeRange(0, leght)];//设置的是斜体-->
<!--[richText addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleDouble] range:NSMakeRange(0, leght)];//设置下划线-->
<!-- -->
<!--[richText addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0,leght)];//设置删除线-->
<!-- -->
<!--[richText addAttribute:NSStrikethroughColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, leght)];//设置删除线的颜色-->
<!--//属性参数-->
<!--NSFontAttributeName //字体 默认是12号-->
<!--NSParagraphStyleAttributeName//段落样式-->
<!--NSForegroundColorAttributeName//指定字体颜色-->
<!--NSBackgroundColorAttributeName//字体背景颜色-->
<!--NSLigatureAttributeName//连体字符-->
<!--NSKernAttributeName//字距的像素-->
<!--NSStrikethroughStyleAttributeName//指定字上加删除线-->
<!--NSUnderlineStyleAttributeName//指定字加下划线-->
<!--NSStrokeColorAttributeName//填充部分颜色-->
<!--NSStrokeWidthAttributeName//填充宽度-->
<!--NSShadowAttributeName//阴影-->
<!--NSUnderlineColorAttributeName//下划线颜色-->

[/** 1 MAC 电脑如果新建txt文本文档:

    第一:  打开: 文本编辑 -- 新建  (此时默认的新建格式是rtf格式的)
    第二:  shift⇧+command⌘+T  这样rtf格式的文本就变为txt格式的了

MAC怎么获取文件路径？
1> 打开浏览器，将文件拖动到浏览器的地址栏。(这样即可获得文件路径，但此方法不能直接获得文件夹路径，即拖动文件夹获取不到路径。)
2> 和浏览器一样，先打开终端，将文件或文件夹拖入到终端。这样就可以获得文件或者文件夹的路径。

option进入资源库

清Xcode的缓存: option进入资源库->Developer->Xcode->DerivedData, 删掉目录下文件
~/Library/MobileDevice/Provisioning Profiles  
*/]

[/** 2 实现iOS语言本地化/国际化

    App名称本地化
    代码中字符串本地化
    多人开发情况下的字符串本地化
    图片本地化（两种方式）
    查看/切换本地语言
*/]

[/** 3 App迭代开发版本号的规则

    1> 如果修复Bug或者优化功能, 我们只修改叠加第三位数字, 其他不变

    2> 如果有了新的需求, 在原来的基础上增加了一个新功能, 那么我们的版本号变为1.1.0, 需要清空第三位数字为0, 来叠加修改第二位数字

    3> 如果App需求功能大改, 更新量非常大, 那我们的版本号变为2.0.0, 需要叠加修改第一位数字, 清空其他数字为0

    为什么发布之前要屏蔽NSLog?(在Release版本下禁止输出NSLog内容)
    1> NSLog 消耗系统资源(暴力调试)
    2> 输出数据可能暴露app保密数据
*/]

[/**
    4. View的生命周期 —— 只要是View开头的都是View的生命周期方法 

        loadView：第一次使用view的时候调用
        viewDidLoad：控制器的view加载完成的时候调用
        viewWillAppear：控制器的view即将显示的时候调用
        viewDidAppear：控制器的view完全显示的时候调用
        viewWillDisappear：控制器的view即将消失的时候调用
        viewDidDisappear：控制器的view完全消失的时候调用
        viewWillLayoutSubviews：控制器的view即将布局的时候调用
        viewDidLayoutSubviews：控制器的view完全布局的时候调用
        viewWillUnload：控制器的view即将销毁
        viewDidUnload：控制器的view完全销毁

    a. 处理过程

        有内存警告 -> 调用didReceiveMemoryWarning方法 -> 判断控制器的View存不存在 -> 存在就判断能不能被释放(判断是不是正在显示在界面上) -> 能释放就调用ViewWillUnload -> 完全释放后就调用ViewDidUnload
    b. 注意

        内存警告处理时，ViewWillUnload和ViewDidUnload不一定被调用，因为这是系统自动判断的
***
1、iOS7新增加了导航控制器侧滑手势，当触发侧滑返回时，会调用系统的viewWillDisappear:方法，取消侧滑返回时又会调用viewWillAppear:方法。
2、在做手势和通知等一系列操作之时尽量在dealloc方法中执行，添加通知尽量在viewDidLoad等一次性方法中执行。
3、在viewWillAppear:、viewWillDisappear:、viewDidAppear:、viewDidDisappear:等类似于这种会多次调用的系统方法中添加代码时，一定要多考虑业务逻辑，以免出现不必要的麻烦。

*/]


[/** 5 iOS Crash 总结

    a. NSInvalidArgumentException 异常：

        1> NSDictionary插入nil的对象。NSMutableDictionary也是同样的道理。
        2> NSJSONSerialization序列化的时候，传入data为nil。
        3> an unrecognized selector 无法识别的方法

    b. SIGSEGV 异常：（SIGSEGV是当SEGV发生的时候，让代码终止的标识。当去访问没有被开辟的内存或者已经被释放的内存时，就会发生这样的异常。另外，在低内存的时候，也可能会产生这样的异常。）
    
        1> 在使用C语言对象的时候，一定要记得在不使用的时候给释放掉，ARC并不能释放掉这块内存。

    c. NSRangeException 异常:
    
        经常碰到的越界异常有两种，一种是数组越界，一种字符串截取越界.怎么解决呢？

        方案一：在对数组取数据的时候，要判断一下数组的长度大于取的index，这个要在平时写代码的时候给规范起来。同样在对字符串进行截取的时候，也需要做类似的判断。但现实的情况是，有时我们会忘了写这样的逻辑判断，就会有潜在的崩溃问题。如何做一下统一的判断呢？即使开发人员忘了写这样的逻辑判断也不会造成崩溃，从框架层面来杜绝这类的崩溃，方案二给出了答案。

        方案二：利用runtime的Swizzle Method特性，可以实现从框架层面杜绝这类的崩溃问题，这样做的好处有两点：

        开发人员忘了写判断越界的逻辑，也不会造成app的崩溃，对开发人员来说是透明的。

        不需要修改现有的代码，对现有代码的侵入性降低到最低，不需要添加大量重复的逻辑判断代码。

     **详细参见：http://www.cocoachina.com/ios/20170122/18602.html 或者 /Users/machunlei/Desktop/DEMO/MayerWorkSpace_OC/CrashDemo-master
*/]

[/** 6 appledoc的使用：

    1.在终端中使用
        a 打开终端，进入项目所在目录，使用如下命令即可：
        MACHUNLEIdeMacBook-Pro:Example_Category machunlei$ cd Example_Category/
        MACHUNLEIdeMacBook-Pro:Example_Category machunlei$ appledoc --output ./doc --project-name Example_Category --project-company mayer --company-id 029 .

        appledoc 会扫描当前路径下的所有文件，然后生成好文档放到 doc 目录下。
        编译出的Docset
        默认会放在~/Library/Developer/Shared/Documentation/DocSets路径下，里面包含html的文档。首先显示生成的Docset的包内容，然后在Contents/Resources/Documents路径下，双击打开里面的index.html可以在浏览器中查看文档了。

        并且生成的Docset已经安装到Xcode中。重启Xcode后，在Help—Documentation and API Reference菜单下也可以看到生成的文档

        b 如果不想生成Docset，而是想生成html，就需要加一个--no-create-docset，这里我使用命令：
        MACHUNLEIdeMacBook-Pro:Example_Category machunlei$ appledoc --no-create-docset --output ./doc --project-name Example_Category --project-company mayer --company-id 029 .
        则会在doc目录下生成一个html文件夹，也是双击里面的index.html就可以在浏览器中查看文档了。


    2.在Xcode里使用
        2.1 首先创建一个Target，取名Document
        2.2 选择Build Phases，点击左边的小加号，选择New Run Script Phase，建好了以后打开刚刚建立的Run Script，在框里输入命令，命令与终端一样，这里我们输入：
            appledoc --output ./doc --project-name Example_Category --project-company mayer --company-id 029 .
        2.3 然后点左上角选择Document，编译一下，成功后文档就生成在doc目录下了。
*/]

[/** 7 Xcode 左边导航栏中，类文件后面的标记“A”,"M","?"……等符号的含义:

    "M" = Locally modified   
    "U" = Updated in repository 
    "A" = Locally added   
    "D" = Locally deleted   
    "I" = Ignored 
    "R" = Replaced in the repository 
    “–” "=" The contents of the folder have mixed status; display the contents to see individual status 
    "?" = Not under source control 

    'A'  新增
    'D'  删除
    'M'  修改
    'R'  替代
    'C'  冲突
    'I'  忽略
    '?'  未受控
    '!'  丢失，一般是将受控文件直接删除导致

    这些标记跟你使用的代码托管工具或者Xcode自带的svn代码托管工具有关，怎样消除：

    1、代码中 某文件后面有 “M” 标记，表示该文件已被修改，需要 commit.
    （右键该文件 -> source control -> commit selected file...）
    2、代码中 某文件后面有 “A” 标记，表示该文件是新添加的，已受SVN管理，需要 commit.
    （右键该文件 -> source control -> commit selected file...）
    3、代码中 某文件后面有 “?” 标记，表示该文件是新添加的，并且脱离了SVN的管理，首先需要add，然后 commit.
    （右键该文件 -> source control -> Add，这样该文件的标记就变为 “A”，然后在 commit）
    4、代码中 某文件后面有 “D” 标记，表示该文件在服务器上已被删除，这时update的话，可删除本地的文件。
    5、代码中 某文件后面有 “C” 标记，表示该文件与服务器的文件冲突。
*/]

[/**8 ObjC中的键值编码（KVC）、键值监听（KVO）特性 

键值编码KVC
    下面是KVC最为重要的四个方法：

    - (nullable id)valueForKey:(NSString *)key;                          //直接通过Key来取值
    - (void)setValue:(nullable id)value forKey:(NSString *)key;          //通过Key来设值
    - (nullable id)valueForKeyPath:(NSString *)keyPath;                  //通过KeyPath来取值
    - (void)setValue:(nullable id)value forKeyPath:(NSString *)keyPath;  //通过KeyPath来设值

    iOS开发中KVC的使用场景：

    1. 动态地取值和设值
    2. 用KVC来访问和修改私有变量
    3. Model和字典转换
    4. 修改一些控件的内部属性, 最常用的就是个性化UITextField中的placeHolderText：
     /**/[textfield setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"]; */]

[/** 键值监听KVO
    KVO其实是一种观察者模式，在ObjC中使用KVO操作常用的方法如下：

    注册指定Key路径的监听器： addObserver: forKeyPath: options:  context:
    删除指定Key路径的监听器： removeObserver: forKeyPath、removeObserver: forKeyPath: context:
    回调监听： observeValueForKeyPath: ofObject: change: context:

    KVO的使用步骤也比较简单：

    通过addObserver: forKeyPath: options: context:为被监听对象（它通常是数据模型）注册监听器
    重写监听器的observeValueForKeyPath: ofObject: change: context:方法
*/]

[/**9 iOS 中MVC和MVVM软件架构模式

把一个应用中的实体分为以下三类：

    Model: 负责主要的数据或者操作数据的数据访问层，可以想象 Perspn 和 PersonDataProvider 类。

    View: 负责展示层（GUI），对于iOS环境可以联想一下以 UI 开头的所有类。

    Controller/ViewModel: 负责协调 Model 和 View，通常根据用户在View上的动作在Model上作出对应的更改，同时将更改的信息返回到View上。

    Model是应用逻辑层的对象，负责应用的逻辑计算和诸多与业务相关的方法和操作。首先Model将未处理的数据转化成Model后，再传给ViewController，ViewController再将处理好的Model数据显示到View上去。相反View产生的数据可也可以转化为Model，通过ViewConroller传到Model层处理后再保存&更新。

1、Model就是MVC和MVVM最前面的M，Model做好数据加工，负责封装数据、存储和处理数据运算等工作,才能更好地服务ViewController和View。
2、view应该提供简洁的构造方法，确保view的初始化工作完全封闭在view中，代码重用性高，分工明确！负责数据展示、监听用户触摸等工作.
3、控制器Controller：负责业务逻辑、事件响应、数据加工等工作.

MVC（Model-View-Controller）是最常见的软件架构

•	视图（View）：用户界面。
•	控制器（Controller）：业务逻辑
•	模型（Model）：数据保存

1.	View 传送指令到 Controller
2.	Controller 完成业务逻辑后，要求 Model 改变状态
3.	Model 将新的数据发送到 View，用户得到反馈

Controller 里面就只应该存放这些不能复用的代码，这些代码包括：
•	在初始化时，构造相应的 View 和 Model。
•	监听 Model 层的事件，将 Model 层的数据传递到 View 层。
•	监听 View 层的事件，并且将 View 层的事件转发到 Model 层。

MVVM

1. Model与View
这一层和 MVC 中的 Model、View 含义相同。
2. ViewModel
这一层主要作用是将以前写在 ViewController 中的数据处理放在 ViewModel 中，如：网络请求、数据缓存、无法直接展示的数据处理(如 NSNumber 这类的，就在 VM 中处理成 NSString，然后 V 层直接用，而不是在 V 层中处理)，从而有效的减轻了 ViewController 的负担。
*/]

[/**11 __weak 和 __block 关键字的区别 

对于 static 变量，全局变量，在 block 中是有读写权限的，因为在 block 的内部实现中，拷贝的是指向这些变量的指针。
总结一下就是：

    1、在MRC 时代，__block 修饰，可以避免循环引用；ARC时代，__block 修饰，同样会引起循环引用问题；
    2、__block不管是ARC还是MRC模式下都可以使用，可以修饰对象，还可以修饰基本数据类型；
    3、__weak只能在ARC模式下使用，也只能修饰对象，不能修饰基本数据类型；
    4、__block对象可以在block中被重新赋值，__weak不可以；
    5、__unsafe_unretained修饰符可以被视为iOS SDK 4.3以前版本的__weak的替代品，不过不会被自动置空为nil。所以尽可能不要使用这个修饰符。(__weak 会自动置为nil)
*/]

[/**12 Cocoa框架
iOS中，Cocoa众多框架中最重要最基本的两个框架是：Foundation 和 UIKit。
Foundation 和界面无关，也可以说和界面无关的类基本是Foundation框架的，和界面相关的是UIKit框架。

Objective-C的优点是它是动态的。动态能力有三种：
    动态类--运行时确定类的对象
    动态绑定--运行时确定要调用的方法
    动态加载--运行时为程序加载新的模块

iOS 生成不重复随机数 

    常用方法：arc4random
    例： 获取一个随机整数范围在：[0,100)包括0，不包括100
    int x = arc4random() % 100;


*/]

[self networkMonitoringAction];             // 0『iOS应用networkMonitoring』
#pragma mark - Examples (1 - 15)

[self familyNameAction];                    // 1 获取设备中的所有字体
[self waterMarkImageAction];                // 2 图片加水印
[self NSRecursiveLockAction];               // 3 递归锁使用
[self getWIFINameAction];                   // 4 wifiName
[self getContentTypeOfImage];               // 5 判断是否为gif/png图片的正确姿势
[self getstartOfToday];                     // 6 凌晨时间获取
[self otherNSStringTestAction];             // 7 NSString使用stringWithFormat拼接的相关知识
[self getCurrentTimeZone];                  // 8 getCurrentTimeZone
[self compareStringTest];                   // 9 compareStringTest
[self blockTestAction];                     // 10 block 可以作为参数传递
[self testDictonaryAction];                 // 11 testDictonaryAction
[self pushAnimatedImage];                   // 12 AnimatedImageViewController gif动画加载
[self cutCircleImageAction];                // 13 iOS开发中设置圆角的几种方法
[self createAnimatedImage];                 // 14 使用图片实现GIF动画
[self createButtonRectCorner];              // 15 控件的局部圆角问题: 图层蒙版(一个button或者label，只要右边的两个角圆角，或者只要一个圆角)。

#pragma mark - Examples (16 - 30)

[self GetContendImageView];                 // 16 图片处理只拿到图片的一部分
[self setImageforUIView];                   // 17 给UIView设置图片
[self buildBarButtonItem];                  // 18 旋转动画
[self Screenshots];                         // 19 截屏 iOS点亮手机屏幕
[self tableViewContentInset];               // 20 指定滚动条在scrollview的位置
[self testArraySum];                        // 21 array快速求总和, 最大值, 最小值和平均值
[self addNoteView];                         // 22 NoteView组件化
[self OverviewOfAVFoundation];              // 23 OverviewOfAVFoundation & iOS从App跳转至系统设置菜单各功能项
[self SingletonUITest];                     // 24 Objective-c单例模式详解
[self createButtonView];                    // 25 左右结构的button fsKeepPasswordButton
[[UIScreen mainScreen]setBrightness:0.5];   // 26 点亮手机屏幕 取值范围从0.0到1.0
[self OverviewSimplePing];                  // 27 OverviewSimplePing
[self OverviewSimplePing2];                 // 28 OverviewSimplePing
[self OverviewNSDate];                      // 29 OverviewNSDate
[self OverviewRegularExpression];           // 30 OverviewRegularExpression

#pragma mark - Examples (31 - 45)
[self attributeTextTapAction];              // 31 attributeTextTapAction
[self openScheme:@"tweetbot://timeline"];   // 32『iOS应用间相互跳转』
[self LoadHtmlDocView];                     // 33 LoadHtmlDocView

#pragma mark - iOS中nil 、NULL、 Nil 、NSNull

nil，定义一个空的实例，指向OC中对象的空指针。

    示例代码：
    NSString *someString = nil;
    NSURL *someURL = nil;
    id someObject = nil;
    if (anotherObject == nil) // do something

    用法讲解：
    　当对某个对象release 的同时最好把他们赋值为nil，这样可以确保安全性，如果不赋值nil，可能导致程序
    崩溃.
    　　    NSArray * array = [NSArray arrayWithObjects:@"test",@"test1" ,nil];
    　　    [array release];
    　　    
    　　    if (array)
    　　    {
    　　　　　　//仅仅对数组release，并没有赋值为nil，在程序某个地方如果继续对数组操作，程序直接崩溃
    　　        NSString * string = [array objectAtIndex:0];
    　　        NSLog(@"%@",string);
    　　    }

NULL，NULL可以用在C语言的各种指针上。

    #define __DARWIN_NULL 
    #define__DARWIN_NULLConstants
    示例代码：
    int *pointerToInt = NULL;　　　　
    char *pointerToChar = NULL;　　
    struct TreeNode *rootNode = NULL;

    用法讲解：
    在Objective-C里，nil对象被设计来跟NULL空指针关联的。他们的区别就是nil是一个对象，而NULL只是一个
    值。而且我们对于nil调用方法，不会产生crash或者抛出异常。

Nil，定义一个空的类

    示例代码：　　
    Class someClass = Nil;　
    Class anotherClass = [NSString class];

NSNull，NSNull是一个类，它定义了一个单例对象用于表示集合对象的空值

    集合对象无法包含nil作为其具体值，如NSArray、NSSet和NSDictionary。相应地，nil值用一个特定的对象
    NSNull来表示。NSNull提供了一个单一实例用于表示对象属性中的的nil值。默认的实现方法中，
    dictionaryWithValuesForKeys:和setValuesForKeysWithDictionary:自动地将        NSNull和nil相互转换，因此您的对象不需要进行NSNull的测试操作。



#pragma mark - tableview刷新某个区域（section）或者某一行（row）

//一个section刷新

NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
[tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

//一个cell刷新

NSIndexPath *indexPath=[NSIndexPath indexPathForRow:3 inSection:0];
[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationRight];


//正则表达式语法：

首先，特殊符号'^'和'$'。他们的作用是分别指出一个字符串的开始和结束。eg：
“^one”：表示所有以”one”开始的字符串（”one cat”，”one123″，·····）；
类似于:- (BOOL)hasPrefix:(NSString *)aString;
“a dog$”：表示所以以”a dog”结尾的字符串（”it is a dog”，·····）；
类似于:- (BOOL)hasSuffix:(NSString *)aString;
“^apple$”：表示开始和结尾都是”apple”的字符串，这个是唯一的~；
“banana”：表示任何包含”banana”的字符串。
类似于 iOS8的新方法- (BOOL)containsString:(NSString *)aString,搜索子串用的。
‘*'，'+'和'?'这三个符号，表示一个或N个字符重复出现的次数。它们分别表示“没有或更多”（[0,+∞]取整），“一次或更多”（[1,+∞]取整），“没有或一次”（[0,1]取整）。下面是几个例子：
“ab*”：表示一个字符串有一个a后面跟着零个或若干个b（”a”, “ab”, “abbb”,……）；
“ab+”：表示一个字符串有一个a后面跟着至少一个b或者更多（ ”ab”, “abbb”,……）；
“ab?”：表示一个字符串有一个a后面跟着零个或者一个b（ ”a”, “ab”）；
“a?b+$”：表示在字符串的末尾有零个或一个a跟着一个或几个b（ ”b”, “ab”,”bb”,”abb”,……）。
可以用大括号括起来（{}），表示一个重复的具体范围。例如
“ab{4}”：表示一个字符串有一个a跟着4个b（”abbbb”）；
“ab{1,}”：表示一个字符串有一个a跟着至少1个b（”ab”,”abb”,”abbb”,……)；
“ab{3,4}”：表示一个字符串有一个a跟着3到4个b（”abbb”,”abbbb”)。
那么，“*”可以用{0，}表示，“+”可以用{1，}表示，“?”可以用{0，1}表示
注意：可以没有下限，但是不能没有上限！例如“ab{,5}”是错误的写法
“ | ”表示“或”操作：
“a|b”：表示一个字符串里有”a”或者”b”；
“(a|bcd)ef”：表示”aef”或”bcdef”；
“(a|b)*c”：表示一串”a”"b”混合的字符串后面跟一个”c”；
方括号”[ ]“表示在括号内的众多字符中，选择1-N个括号内的符合语法的字符作为结果，例如
“[ab]“：表示一个字符串有一个”a”或”b”（相当于”a|b”）；
“[a-d]“：表示一个字符串包含小写的'a'到'd'中的一个（相当于”a|b|c|d”或者”[abcd]“）；
“^[a-zA-Z]“：表示一个以字母开头的字符串；
“[0-9]a”：表示a前有一位的数字；
“[a-zA-Z0-9]$”：表示一个字符串以一个字母或数字结束。
“.”匹配除“\r\n”之外的任何单个字符：
“a.[a-z]“：表示一个字符串有一个”a”后面跟着一个任意字符和一个小写字母；
“^.{5}$”：表示任意1个长度为5的字符串；
“\num” 其中num是一个正整数。表示”\num”之前的字符出现相同的个数，例如
“(.)\1″：表示两个连续的相同字符。
“10\{1,2\}” : 表示数字1后面跟着1或者2个0 (“10″,”100″)。
” 0\{3,\} ” 表示数字为至少3个连续的0 （“000”，“0000”，······）。
在方括号里用'^'表示不希望出现的字符，'^'应在方括号里的第一位。
“@[^a-zA-Z]4@”表示两个”@”中不应该出现字母）。
常用的还有：
“ \d ”匹配一个数字字符。等价于[0-9]。
“ \D”匹配一个非数字字符。等价于[^0-9]。
“ \w ”匹配包括下划线的任何单词字符。等价于“[A-Za-z0-9_]”。
“ \W ”匹配任何非单词字符。等价于“[^A-Za-z0-9_]”。
iOS中书写正则表达式，碰到转义字符，多加一个“\”,例如：
全数字字符：@”^\\d\+$”

/*
正则表达式全部符号解释
字符 	描述
\ 	将下一个字符标记为一个特殊字符、或一个原义字符、或一个 向后引用、或一个八进制转义符。例如，'n' 匹配字符 "n"。'\n' 匹配一个换行符。序列 '\\' 匹配 "\" 而 "\(" 则匹配 "("。
^ 	匹配输入字符串的开始位置。如果设置了 RegExp 对象的 Multiline 属性，^ 也匹配 '\n' 或 '\r' 之后的位置。
$ 	匹配输入字符串的结束位置。如果设置了RegExp 对象的 Multiline 属性，$ 也匹配 '\n' 或 '\r' 之前的位置。
* 	匹配前面的子表达式零次或多次。例如，zo* 能匹配 "z" 以及 "zoo"。* 等价于{0,}。
+ 	匹配前面的子表达式一次或多次。例如，'zo+' 能匹配 "zo" 以及 "zoo"，但不能匹配 "z"。+ 等价于 {1,}。
? 	匹配前面的子表达式零次或一次。例如，"do(es)?" 可以匹配 "do" 或 "does" 中的"do" 。? 等价于 {0,1}。
{n} 	n 是一个非负整数。匹配确定的 n 次。例如，'o{2}' 不能匹配 "Bob" 中的 'o'，但是能匹配 "food" 中的两个 o。
{n,} 	n 是一个非负整数。至少匹配n 次。例如，'o{2,}' 不能匹配 "Bob" 中的 'o'，但能匹配 "foooood" 中的所有 o。'o{1,}' 等价于 'o+'。'o{0,}' 则等价于 'o*'。
{n,m} 	m 和 n 均为非负整数，其中n <= m。最少匹配 n 次且最多匹配 m 次。例如，"o{1,3}" 将匹配 "fooooood" 中的前三个 o。'o{0,1}' 等价于 'o?'。请注意在逗号和两个数之间不能有空格。
? 	当该字符紧跟在任何一个其他限制符 (*, +, ?, {n}, {n,}, {n,m}) 后面时，匹配模式是非贪婪的。非贪婪模式尽可能少的匹配所搜索的字符串，而默认的贪婪模式则尽可能多的匹配所搜索的字符串。例如，对于字符串 "oooo"，'o+?' 将匹配单个 "o"，而 'o+' 将匹配所有 'o'。
. 	匹配除 "\n" 之外的任何单个字符。要匹配包括 '\n' 在内的任何字符，请使用象 '[.\n]' 的模式。
(pattern) 	匹配 pattern 并获取这一匹配。所获取的匹配可以从产生的 Matches 集合得到，在VBScript 中使用 SubMatches 集合，在JScript 中则使用 $0…$9 属性。要匹配圆括号字符，请使用 '\(' 或 '\)'。
(?:pattern) 	匹配 pattern 但不获取匹配结果，也就是说这是一个非获取匹配，不进行存储供以后使用。这在使用 "或" 字符 (|) 来组合一个模式的各个部分是很有用。例如， 'industr(?:y|ies) 就是一个比 'industry|industries' 更简略的表达式。
(?=pattern) 	正向预查，在任何匹配 pattern 的字符串开始处匹配查找字符串。这是一个非获取匹配，也就是说，该匹配不需要获取供以后使用。例如，'Windows (?=95|98|NT|2000)' 能匹配 "Windows 2000" 中的 "Windows" ，但不能匹配 "Windows 3.1" 中的 "Windows"。预查不消耗字符，也就是说，在一个匹配发生后，在最后一次匹配之后立即开始下一次匹配的搜索，而不是从包含预查的字符之后开始。
(?!pattern) 	负向预查，在任何不匹配 pattern 的字符串开始处匹配查找字符串。这是一个非获取匹配，也就是说，该匹配不需要获取供以后使用。例如'Windows (?!95|98|NT|2000)' 能匹配 "Windows 3.1" 中的 "Windows"，但不能匹配 "Windows 2000" 中的 "Windows"。预查不消耗字符，也就是说，在一个匹配发生后，在最后一次匹配之后立即开始下一次匹配的搜索，而不是从包含预查的字符之后开始
x|y 	匹配 x 或 y。例如，'z|food' 能匹配 "z" 或 "food"。'(z|f)ood' 则匹配 "zood" 或 "food"。
[xyz] 	字符集合。匹配所包含的任意一个字符。例如， '[abc]' 可以匹配 "plain" 中的 'a'。
[^xyz] 	负值字符集合。匹配未包含的任意字符。例如， '[^abc]' 可以匹配 "plain" 中的'p'。
[a-z] 	字符范围。匹配指定范围内的任意字符。例如，'[a-z]' 可以匹配 'a' 到 'z' 范围内的任意小写字母字符。
[^a-z] 	负值字符范围。匹配任何不在指定范围内的任意字符。例如，'[^a-z]' 可以匹配任何不在 'a' 到 'z' 范围内的任意字符。
\b 	匹配一个单词边界，也就是指单词和空格间的位置。例如， 'er\b' 可以匹配"never" 中的 'er'，但不能匹配 "verb" 中的 'er'。
\B 	匹配非单词边界。'er\B' 能匹配 "verb" 中的 'er'，但不能匹配 "never" 中的 'er'。
\cx 	匹配由 x 指明的控制字符。例如， \cM 匹配一个 Control-M 或回车符。x 的值必须为 A-Z 或 a-z 之一。否则，将 c 视为一个原义的 'c' 字符。
\d 	匹配一个数字字符。等价于 [0-9]。
\D 	匹配一个非数字字符。等价于 [^0-9]。
\f 	匹配一个换页符。等价于 \x0c 和 \cL。
\n 	匹配一个换行符。等价于 \x0a 和 \cJ。
\r 	匹配一个回车符。等价于 \x0d 和 \cM。
\s 	匹配任何空白字符，包括空格、制表符、换页符等等。等价于 [ \f\n\r\t\v]。
\S 	匹配任何非空白字符。等价于 [^ \f\n\r\t\v]。
\t 	匹配一个制表符。等价于 \x09 和 \cI。
\v 	匹配一个垂直制表符。等价于 \x0b 和 \cK。
\w 	匹配包括下划线的任何单词字符。等价于'[A-Za-z0-9_]'。
\W 	匹配任何非单词字符。等价于 '[^A-Za-z0-9_]'。
\xn 	匹配 n，其中 n 为十六进制转义值。十六进制转义值必须为确定的两个数字长。例如，'\x41' 匹配 "A"。'\x041' 则等价于 '\x04' & "1"。正则表达式中可以使用 ASCII 编码。.
\num 	匹配 num，其中 num 是一个正整数。对所获取的匹配的引用。例如，'(.)\1' 匹配两个连续的相同字符。
\n 	标识一个八进制转义值或一个向后引用。如果 \n 之前至少 n 个获取的子表达式，则 n 为向后引用。否则，如果 n 为八进制数字 (0-7)，则 n 为一个八进制转义值。
\nm 	标识一个八进制转义值或一个向后引用。如果 \nm 之前至少有 nm 个获得子表达式，则 nm 为向后引用。如果 \nm 之前至少有 n 个获取，则 n 为一个后跟文字 m 的向后引用。如果前面的条件都不满足，若 n 和 m 均为八进制数字 (0-7)，则 \nm 将匹配八进制转义值 nm。
\nml 	如果 n 为八进制数字 (0-3)，且 m 和 l 均为八进制数字 (0-7)，则匹配八进制转义值 nml。
\un 	匹配 n，其中 n 是一个用四个十六进制数字表示的 Unicode 字符。例如， \u00A9 匹配版权符号 (?)。
*/
　　
三、iOS中正则表达式的3种使用

1.正则表达式与NSPredicate连用，eg：

- (BOOL)validateNumber:(NSString *) textString
{
NSString* number=@"^[0-9]+$";
NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
return [numberPre evaluateWithObject:textString];
}

2.NSString方法

- (NSRange)rangeOfString:(NSString *)aString options:
(NSStringCompareOptions)mask;
NSString *searchText = @"rangeOfString";
NSRange range = [searchText rangeOfString:@"^[0-9]+$" 
options:NSRegularExpressionSearch];
if (range.location != NSNotFound) {
NSLog(@"range ：%@", [searchText substringWithRange:range]);
}

3.正则表达式类（NSRegularExpression）

NSString *searchText = @"you want to match"; 
NSError *error = NULL;
NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^[0-9]+$" options:NSRegularExpressionCaseInsensitive error:&error];
NSTextCheckingResult *result = [regex firstMatchInString:searchText options:0 range:NSMakeRange(0, [searchText length])];
if (result) {
NSLog(@"%@", [searchText substringWithRange:result.range]);
}

四、常用的正则表达式

1.验证用户名和密码：”^[a-zA-Z]\w{5,15}$”
2.验证电话号码：（”^(\\d{3,4}-)\\d{7,8}$”）
eg：021-68686868  0511-6868686；
3.验证手机号码：”^1[3|4|5|7|8][0-9]\\d{8}$”；
4.验证身份证号（15位或18位数字）：”\\d{14}[[0-9],0-9xX]”；
5.验证Email地址：(“^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\.\\w+([-.]\\w+)*$”)；
6.只能输入由数字和26个英文字母组成的字符串：(“^[A-Za-z0-9]+$”) ;
7.整数或者小数：^[0-9]+([.]{0,1}[0-9]+){0,1}$
8.只能输入数字：”^[0-9]*$”。
9.只能输入n位的数字：”^\\d{n}$”。
10.只能输入至少n位的数字：”^\\d{n,}$”。
11.只能输入m~n位的数字：”^\\d{m,n}$”。
12.只能输入零和非零开头的数字：”^(0|[1-9][0-9]*)$”。
13.只能输入有两位小数的正实数：”^[0-9]+(.[0-9]{2})?$”。
14.只能输入有1~3位小数的正实数：”^[0-9]+(\.[0-9]{1,3})?$”。
15.只能输入非零的正整数：”^\+?[1-9][0-9]*$”。
16.只能输入非零的负整数：”^\-[1-9][]0-9″*$。
17.只能输入长度为3的字符：”^.{3}$”。
18.只能输入由26个英文字母组成的字符串：”^[A-Za-z]+$”。
19.只能输入由26个大写英文字母组成的字符串：”^[A-Z]+$”。
20.只能输入由26个小写英文字母组成的字符串：”^[a-z]+$”。
21.验证是否含有^%&',;=?$\”等字符：”[^%&',;=?$\x22]+”。
22.只能输入汉字：”^[\u4e00-\u9fa5]{0,}$”。
23.验证URL：”^http://([\\w-]+\.)+[\\w-]+(/[\\w-./?%&=]*)?$”。
24.验证一年的12个月：”^(0?[1-9]|1[0-2])$”正确格式为：”01″～”09″和”10″～”12″。
25.验证一个月的31天：”^((0?[1-9])|((1|2)[0-9])|30|31)$”正确格式为；”01″～”09″、”10″～”29″和“30”~“31”。
26.获取日期正则表达式：\\d{4}[年|\-|\.]\\d{\1-\12}[月|\-|\.]\\d{\1-\31}日?
评注：可用来匹配大多数年月日信息。
27.匹配双字节字符(包括汉字在内)：[^\x00-\xff]
评注：可以用来计算字符串的长度（一个双字节字符长度计2，ASCII字符计1）
28.匹配空白行的正则表达式：\n\s*\r
评注：可以用来删除空白行
29.匹配HTML标记的正则表达式：<(\S*?)[^>]*>.*?</>|<.*? />
评注：网上流传的版本太糟糕，上面这个也仅仅能匹配部分，对于复杂的嵌套标记依旧无能为力
30.匹配首尾空白字符的正则表达式：^\s*|\s*$
评注：可以用来删除行首行尾的空白字符(包括空格、制表符、换页符等等)，非常有用的表达式
31.匹配网址URL的正则表达式：[a-zA-z]+://[^\s]*
评注：网上流传的版本功能很有限，上面这个基本可以满足需求
32.匹配帐号是否合法(字母开头，允许5-16字节，允许字母数字下划线)：^[a-zA-Z][a-zA-Z0-9_]{4,15}$
评注：表单验证时很实用
33.匹配腾讯QQ号：[1-9][0-9]\{4,\}
评注：腾讯QQ号从10 000 开始
34.匹配中国邮政编码：[1-9]\\d{5}(?!\d)
评注：中国邮政编码为6位数字
35.匹配ip地址：((2[0-4]\\d|25[0-5]|[01]?\\d\\d?)\.){3}(2[0-4]\\d|25[0-5]|[01]?\\d\\d?)。










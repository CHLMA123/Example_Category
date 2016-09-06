# Example_Category

App迭代开发版本号的规则
/*
1 如果修复Bug或者优化功能, 我们只修改叠加第三位数字, 其他不变

2.如果有了新的需求, 在原来的基础上增加了一个新功能, 那么我们的版本号变为1.1.0, 需要清空第三位数字为0, 来叠加修改第二位数字

3.如果App需求功能大改, 更新量非常大, 那我们的版本号变为2.0.0, 需要叠加修改第一位数字, 清空其他数字为0
*/

#pragma mark - Examples1

[self familyNameAction];                    // 获取设备中的所有字体
[self waterMarkImageAction];                // 图片加水印
[self NSRecursiveLockAction];               // 递归锁使用
[self getWIFINameAction];                   // wifiName
[self getContentTypeOfImage];               // 判断是否为gif/png图片的正确姿势
[self getstartOfToday];                     // 凌晨时间获取
[self otherNSStringTestAction];             // NSString使用stringWithFormat拼接的相关知识
[self getCurrentTimeZone];                  // getCurrentTimeZone
[self compareStringTest];                   // compareStringTest
[self blockTestAction];                     // block 可以作为参数传递
[self testDictonaryAction];                 // testDictonaryAction
[self pushAnimatedImage];                   // AnimatedImageViewController gif动画加载
[self cutCircleImageAction];                // iOS开发中设置圆角的几种方法
[self createAnimatedImage];                 // 使用图片实现GIF动画
[self createButtonRectCorner];              // 控件的局部圆角问题: 图层蒙版(一个button或者label，只要右边的两个角圆角，或者只要一个圆角)。

#pragma mark - Examples2

[self GetContendImageView];                 // 图片处理只拿到图片的一部分
[self setImageforUIView];                   // 给UIView设置图片
[self buildBarButtonItem];                  // 旋转动画
[self Screenshots];                         // 截屏
[self tableViewContentInset];               // 指定滚动条在scrollview的位置
[self testArraySum];                        // array快速求总和, 最大值, 最小值和平均值

#pragma mark - Examples3

[self addNoteView];                         // NoteView组件化


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















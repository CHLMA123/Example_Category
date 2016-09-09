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
[self OverviewOfAVFoundation];              //OverviewOfAVFoundation & iOS从App跳转至系统设置菜单各功能项
[self SingletonUITest];                     // Objective-c单例模式详解



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










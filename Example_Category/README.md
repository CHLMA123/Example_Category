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
















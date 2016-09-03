# FLAnimatedImage


http://www.cnblogs.com/YouXianMing/p/4567081.html

FLAnimatedImage is a performant animated GIF engine for iOS:

FLAnimatedImage是一个播放gif图片的引擎:

Plays multiple GIFs simultaneously with a playback speed comparable to desktop browsers 可以异步播放多个gif图片,不会降低速度,与电脑上面播放的效果一致.
Honors variable frame delays 支持帧率的不同
Behaves gracefully under memory pressure 内存占用率小
Eliminates delays or blocking during the first playback loop 重复播放时,不会有延时阻塞感
Interprets the frame delays of fast GIFs the same way modern browsers do 

It's a well-tested component that powers all GIFs in Flipboard. To understand its behavior it comes with an interactive demo:



Who is this for? 用在什么地方？

Apps that don't support animated GIFs yet App还不支持GIF显示的
Apps that already support animated GIFs but want a higher performance solution App已经使用了GIF图片，但是效果不好的
People who want to tinker with the code (the corresponding blog post is a great place to start; also see the To Do section below) 那些想要改进这份代码的人



Installation & Usage

FLAnimatedImage is a well encapsulated drop-in component. Simply replace your UIImageView instances with instances of FLAnimatedImageView to get animated GIF support. There is no central cache or state to manage.

FLAnimatedImage是一个继承与UIImageView的子类，你只需要简单的用FLAnimatedImage替换UIImageView即可支持GIF图片的显示。没有中心缓存或者是状态管理操作。

If using CocoaPods, the quickest way to try it out is to type this on the command line:

如果你使用CocoaPods，你可以用以下一句话来集成：

$ pod try FLAnimatedImage

To add it to your app, copy the two classes FLAnimatedImage.h/.m and FLAnimatedImageView.h/.minto your Xcode project or add via CocoaPods by adding this to your Podfile:

你也可以将FLAnimatedImage.h/.m 与 FLAnimatedImageView.h/.m拷贝到你的项目中即可。

pod 'FLAnimatedImage', '~> 1.0'

In your code, #import "FLAnimatedImage.h", create an image from an animated GIF, and setup the image view to display it:

在你的代码中，导入 #import "FLAnimatedImage.h"，然后创建出GIF图片，加载出来显示即可：

FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://raphaelschaad.com/static/nyan.gif"]]];
FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
imageView.animatedImage = image;
imageView.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
[self.view addSubview:imageView];

It's flexible to integrate in your custom image loading stack and backwards compatible to iOS 6.

兼容性很好，即时是iOS6也能跑的很顺畅。

It uses ARC and the Apple frameworks QuartzCore, ImageIO, MobileCoreServices, andCoreGraphics.

使用ARC，以及QuartzCore，ImageIO，MobileCoreServices，andCoreGraphics框架

It has fine-grained logging. By default, it uses NSLog. However, if your project usesCocoaLumberjack, it automatically can detect that and use CocoaLumberjack to send logs to the configured output.

Since FLAnimatedImage is licensed under MIT, it's compatible with the terms of using it for any app on the App Store.
//
//  AttributeTextTapController.m
//  Example_Category
//
//  Created by MCL on 2016/10/29.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "AttributeTextTapController.h"
#import "UILabel+YBAttributeTextTapAction.h"

@interface AttributeTextTapController ()<YBAttributeTapActionDelegate>

@end

@implementation AttributeTextTapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *lable = [[UILabel alloc] init];
    // lable.backgroundColor = [UIColor redColor];
    [self.view addSubview:lable];
    
    NSString *reasonstring = [NSString stringWithFormat:@"%@\n%@",
                              @"Failed to fine camera information.",
                              @"There has been problem registering the camera. Please send an email to ipcamreset@yale.co.uk including a photo of the sticker on the back of your camera, with the MAC ID clearly visible, and we will reset the connection."];
    CGSize textsize = [self sizeWithText:reasonstring font:[UIFont systemFontOfSize:17] maxWidth:kScreenWidth - 20];
    lable.frame = CGRectMake(10, 100, kScreenWidth - 20, textsize.height);
    lable.numberOfLines = 0;
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:reasonstring];
    // 设置行高，默认是0
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 0;
    [content addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, reasonstring.length)];
    NSRange underLineRange = [reasonstring rangeOfString:@"ipcamreset@yale.co.uk"];
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:underLineRange];
    [content addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:underLineRange];
    lable.attributedText = content;
    
    // Method 1 用代理回调
    [lable yb_addAttributeTapActionWithStrings:@[@"ipcamreset@yale.co.uk"] delegate:self];
    
    // Method 2 用block回调
//        [lable yb_addAttributeTapActionWithStrings:@[@"ipcamreset@yale.co.uk"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
//    
//            NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),(long)index];
//            NSLog(@"点击了邮箱 %@", message);
//            [self launchMailApp];
//    
//        }];
    
//    //设置是否有点击效果，默认是YES
//    lable.enabledTapEffect = NO;
    
    // Method 3 伪方法 给整个lable加了点击事件
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(launchMailApp:)];
//    self.reasonLabel.userInteractionEnabled = YES;
//    [self.reasonLabel addGestureRecognizer:tapGesture];
}

#pragma mark - 计算label的Size的方法总结
// a sizeWithAttributes:方法 适用于不换行的情况,宽度不受限制的情况
//- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
//{
//    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
//    attrDict[NSFontAttributeName] = font;
//    return [text sizeWithAttributes:attrDict];
//}

// b boundingRectWithSize:方法,适用于换行的情况,同时适用于不换行的情况,为了兼容两者,代码如下:
/// 根据指定文本和字体计算尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxWidth:MAXFLOAT];
}
/// 根据指定文本,字体和最大宽度计算尺寸
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)width
{
    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
    attrDict[NSFontAttributeName] = font;
    CGSize size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrDict context:nil].size;
    return size;
}
/**
 *  YBAttributeTapActionDelegate
 *
 *  @param string  点击的字符串
 *  @param range   点击的字符串range
 *  @param index 点击的字符在数组中的index
 */
- (void)yb_attributeTapReturnString:(NSString *)string
                              range:(NSRange)range
                              index:(NSInteger)index{

    NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),(long)index];
    NSLog(@"点击了邮箱 %@", message);
    [self launchMailApp];
}

#pragma mark - 使用系统邮件客户端发送邮件
-(void)launchMailApp
{
    NSMutableString *mailUrl = [[NSMutableString alloc] init];
    //添加收件人
    NSArray *toRecipients = [NSArray arrayWithObject: @"software82@foscam.com"];
    [mailUrl appendFormat:@"mailto:%@", [toRecipients componentsJoinedByString:@","]];
    //    //添加抄送
    //    NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
    //    [mailUrl appendFormat:@"?cc=%@", [ccRecipients componentsJoinedByString:@","]];
    //    //添加密送
    //    NSArray *bccRecipients = [NSArray arrayWithObjects:@"fourth@example.com", nil];
    //    [mailUrl appendFormat:@"&bcc=%@", [bccRecipients componentsJoinedByString:@","]];
    //    //添加主题
    //    [mailUrl appendString:@"&subject=my email"];
    //    //添加邮件内容
    //    [mailUrl appendString:@"&body=<b>email</b> body!"];
    NSString* email = [mailUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
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

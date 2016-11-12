//
//  AttributeTextTapController.m
//  Example_Category
//
//  Created by MCL on 2016/10/29.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import "AttributeTextTapController.h"
#import "UILabel+YBAttributeTextTapAction.h"
#import "UnderLineLabel.h"

@interface AttributeTextTapController ()<YBAttributeTapActionDelegate, UnderLineLabelDelegate>

@end

@implementation AttributeTextTapController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *lable = [[UILabel alloc] init];
    [self.view addSubview:lable];
    NSString *reasonstring = [NSString stringWithFormat:@"%@\n%@",
                              @"Failed to fine camera information.",
                              @"This camera is already registered by another account, if you forget the old account, please send Email with your camera Mac sticker picture to ipcamreset@yale.co.uk"];
    CGSize textsize = [self sizeWithText:reasonstring font:[UIFont systemFontOfSize:17] maxWidth:kScreenWidth - 20];
    lable.frame = CGRectMake(10, 65, kScreenWidth - 20, textsize.height * 2);
    lable.numberOfLines = 0;
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:reasonstring];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 10;
    [content addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, reasonstring.length)];
    NSRange underLineRange = [reasonstring rangeOfString:@"ipcamreset@yale.co.uk"];
    NSDictionary * dict = @{
                            NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleThick],
                            NSForegroundColorAttributeName:RGBCOLOR(253, 212, 9),
                            NSFontAttributeName:[UIFont systemFontOfSize:19],
                            };
    [content setAttributes:dict range:underLineRange];
    lable.attributedText = content;
    
    //    //设置是否有点击效果，默认是YES
    //    lable.enabledTapEffect = NO;
    
    // Method 1 用代理回调
    [lable yb_addAttributeTapActionWithStrings:@[@"ipcamreset@yale.co.uk"] delegate:self];
    
//    // Method 2 用block回调
//    [lable yb_addAttributeTapActionWithStrings:@[@"ipcamreset@yale.co.uk"] tapClicked:^(NSString *string, NSRange range, NSInteger index) {
//        
//        NSString *message = [NSString stringWithFormat:@"点击了“%@”字符\nrange: %@\nindex: %ld",string,NSStringFromRange(range),(long)index];
//        NSLog(@"点击了邮箱 %@", message);
//        [self launchMailApp];
//        
//    }];
    
    // 2. 重绘UILabel添加下划线
    CGRect rect = CGRectMake(10, CGRectGetMaxY(lable.frame), kScreenWidth - 20, 200);
    NSString *lblContent = @"This camera is already registered by another account, if you forget the old account, please send Email with your camera Mac sticker picture to ipcamreset@yale.co.uk" ;
    NSString *attributeStr = @"ipcamreset@yale.co.uk";
    UnderLineLabel *lable2 = [[UnderLineLabel alloc] initWithFrame:rect withLableText:lblContent withAttributedString:attributeStr];
    lable2.font = [UIFont systemFontOfSize:17];
    lable2.delegate = self;
    [self.view addSubview:lable2];
    
//    UnderLineLabel*lable3 = [[UnderLineLabel alloc] initWithFrame:rect withLableText:lblContent withAttributedString:@""];
//    lable3.font = [UIFont systemFontOfSize:17];
//    lable3.delegate = self;
//    [self.view addSubview:lable3];
}

#pragma mark - UnderLineLabelDelegate
- (void)lineLabelClicked:(UnderLineLabel *)label{

    [self launchMailApp];
}

#pragma mark - 计算label的Size的方法
/**
 *  根据指定文本和字体计算尺寸
 *
 *  @param text  文本text
 *  @param font  字体font
 *
 *  boundingRectWithSize:方法,适用于换行的情况,同时适用于不换行的情况,为了兼容两者,代码如下:
 */

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

// a sizeWithAttributes:方法 适用于不换行的情况,宽度不受限制的情况
//- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
//{
//    NSMutableDictionary *attrDict = [NSMutableDictionary dictionary];
//    attrDict[NSFontAttributeName] = font;
//    return [text sizeWithAttributes:attrDict];
//}

#pragma mark - YBAttributeTapActionDelegate
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

//
//  UnderLineLabel.h
//  Example_Category
//
//  Created by MCL on 2016/11/9.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UnderLineLabel;

@protocol UnderLineLabelDelegate <NSObject>

@optional
- (void)lineLabelClicked:(UnderLineLabel *)label;

@end

@interface UnderLineLabel : UILabel

@property (nonatomic, assign) id <UnderLineLabelDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withLableText:(NSString *)lbltext withAttributedString:(NSString *)attstring;

@end

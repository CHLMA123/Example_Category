//
//  UITapImageView.h
//  Example_Category
//
//  Created by MCL on 2016/12/30.
//  Copyright © 2016年 MCL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITapImageView : UIImageView

- (void)addTapBlock:(void(^)(id obj))tapAction;

-(void)setImageWithUrl:(NSURL *)imgUrl placeholderImage:(UIImage *)placeholderImage tapBlock:(void(^)(id obj))tapAction;

@end

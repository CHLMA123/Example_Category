//
//  UIImage+Rotate_Flip.h
//  UIImage分类实现各种旋转
//
//  Created by == on 15/7/5.
//  Copyright (c) 2015年 ==. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rotate_Flip)
/*
 * @brief rotate image 90 withClockWise 顺时针
 */
- (UIImage*)rotate90Clockwise;

/*
 * @brief rotate image 90 counterClockwise 逆时针
 */
- (UIImage*)rotate90CounterClockwise;

/*
 * @brief rotate image 180 degree 图像旋转180度
 */
- (UIImage*)rotate180;

/*
 * @brief rotate image to default orientation
 */
- (UIImage*)rotateImageToOrientationUp;

/*
 * @brief flip horizontal 水平翻转
 */
- (UIImage*)flipHorizontal;

/*
 * @brief flip vertical 垂直翻转
 */
- (UIImage*)flipVertical;

/*
 * @brief flip horizontal and vertical
 */
- (UIImage*)flipAll;
@end

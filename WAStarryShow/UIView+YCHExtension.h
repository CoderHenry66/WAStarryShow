//
//  UIView+Extension.h
//  快捷更改flame
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 flame. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YCHExtension)
@property (nonatomic, assign) CGFloat x_ych;
@property (nonatomic, assign) CGFloat y_ych;
@property (nonatomic, assign) CGFloat centerX_ych;
@property (nonatomic, assign) CGFloat centerY_ych;
@property (nonatomic, assign) CGFloat width_ych;
@property (nonatomic, assign) CGFloat height_ych;
@property (nonatomic, assign) CGSize size_ych;
@property (nonatomic, assign) CGPoint origin_ych;
@property (nonatomic, assign) CGFloat maxX_ych;
@property (nonatomic, assign) CGFloat maxY_ych;


@property (nonatomic , assign) CGSize rotateSize;
// 毛玻璃效果view(默认透明效果)
+ (UIView *)ych_blurViewWithFrame:(CGRect)frame;
// 毛玻璃效果view（自定义效果）
+ (UIView *)ych_blurViewWithFrame:(CGRect)frame style:(UIBlurEffectStyle)style;

// 添加圆角
- (void)ych_cornerRadius:(CGSize)size location:(UIRectCorner)corner;
/**
 *  获取某个点上的角度
 *
 *  @param point 点
 *
 *  @return 弧度
 */
- (CGFloat)ych_angleWithPoint:(CGPoint)point;

/**
 *  获取view某点上
 *
 */
- (CGPoint)ych_pointWithAngel:(CGFloat)angle radius:(CGFloat)radius;

/**
 *  获取view某点上的颜色
 *
 *  @param point 坐标
 */
- (UIColor *)ych_colorWithPoint:(CGPoint)point;

//找到自己的vc
- (UIViewController *)ych_viewController;

@end

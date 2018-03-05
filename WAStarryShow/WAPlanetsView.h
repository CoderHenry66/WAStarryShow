//
//  WAPlanetsView.h
//  WAStarryShow
//
//  Created by 黄锐灏 on 2018/3/5.
//  Copyright © 2018年 黄锐灏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WAStarryScrollDelegate.h"
typedef NS_ENUM(NSUInteger,WAPlanet) {
    WAPlanetMessage,
    WAPlanetMeet,
    WAPlanetSearch,
    WAPlanetFriend,
};

@protocol WAPlanetsViewDelegate <NSObject>

- (void)WAPlanetsViewSelect:(UIView *)planet type:(WAPlanet)planetType;

@end

@interface WAPlanetsView : UIView <WAStarryScrollDelegate>

- (instancetype)initWithWidth:(CGFloat)width heigh:(CGFloat)heigh inlaySize:(CGSize)size;

// 代理
@property (nonatomic , assign) id<WAPlanetsViewDelegate> delegate;


// 当前x速率
@property (nonatomic , assign) CGFloat speedX;


// 当前y速率
@property (nonatomic , assign) CGFloat speedY;

@end

@interface WAPlanetView : UIView

// 建背景图片
- (instancetype)initWithImage:(UIImage *)image frame:(CGRect)frame inlaySize:(CGSize)size;

// 添加光晕
- (void)addLightView:(UIImage *)image frame:(CGRect)frame;

// 添加文字线
- (void)addLableLine:(UIImage *)image frame:(CGRect)frame;

// 添加文字
- (void)addLable:(UIImage *)labelImage frame:(CGRect)frame;

// 开始移动移除前动画
- (void)beganDrag;

// 停止移动开始衰减动画
- (void)endDragWithSpeedX:(CGFloat)x speedY:(CGFloat)y;
// 主星球
@property (nonatomic , weak) UIImageView *imageView;
// 光晕
@property (nonatomic , weak) UIImageView *lightView;
// 文字线
@property (nonatomic , weak) UIImageView *lineView;
// 文字
@property (nonatomic , weak) UIImageView *nameView;

// 比例
@property (nonatomic , assign) CGFloat scale;

// 原始位置
@property (nonatomic , assign) CGPoint origiPoint;

// maxSize
@property (nonatomic , assign) CGSize maxSize;

// 加浮动动画
- (void)addSkyAnimationWithclockwise:(BOOL)clockWise angle:(CGFloat)angle;

// 加旋转动画
- (void)addRotationAnimationWithclockwise:(BOOL)clockWise;

- (void)resetAnimation;

@end

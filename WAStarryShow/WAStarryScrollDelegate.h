//
//  WAStarryScrollDelegate.h
//  WAStarryShow
//
//  Created by 黄锐灏 on 2018/3/5.
//  Copyright © 2018年 黄锐灏. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WAStarryScrollDelegate <NSObject>

- (void)setXGap:(CGFloat)gap;

- (void)setYGap:(CGFloat)gap;

- (CGFloat)validateX:(CGFloat)x;

- (CGFloat)validateY:(CGFloat)y;

//  边界
- (CGFloat)maxX;

- (CGFloat)maxY;

- (CGFloat)minX;

- (CGFloat)minY;



// 开始移动移除前动画
- (void)beganDrag;

- (void)buildBGSubview;

// 停止移动开始衰减动画
- (void)endDrag;

- (void)resetAnimation;

@end


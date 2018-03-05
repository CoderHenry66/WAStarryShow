//
//  WAStarrySkyView.h
//  WAStarryShow
//
//  Created by 黄锐灏 on 2018/3/5.
//  Copyright © 2018年 黄锐灏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WAStarryScrollDelegate.h"


@interface WAStarrySkyView : UIImageView <WAStarryScrollDelegate>

- (instancetype)initWithImage:(UIImage *)image width:(CGFloat)width heigh:(CGFloat)heigh;


// 当前x速率
@property (nonatomic , assign) CGFloat speedX;


// 当前y速率
@property (nonatomic , assign) CGFloat speedY;

- (BOOL)touchInNoOpenStar:(CGPoint)point;


@end

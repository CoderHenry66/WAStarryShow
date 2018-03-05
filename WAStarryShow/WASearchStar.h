//
//  WASearchStar.h
//  WAStarryShow
//
//  Created by 黄锐灏 on 2018/3/5.
//  Copyright © 2018年 黄锐灏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WASearchStar : UIView

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image icon:(UIImage *)icon title:(NSString *)title;


- (void)firstLogin;
// 用于多次加载动画被打乱
- (void)resetAnimation;

@end

//
//  WASearchStar.m
//  WAStarryShow
//
//  Created by 黄锐灏 on 2018/3/5.
//  Copyright © 2018年 黄锐灏. All rights reserved.
//

#import "WASearchStar.h"
#import "UIView+YCHExtension.h"
@interface WASearchStar ()

@property (nonatomic , weak) UIImageView *bgView;

@property (nonatomic , weak) UIImageView *icon;

@property (nonatomic , weak) UILabel *titleView;


@end

@implementation WASearchStar

- (instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image icon:(UIImage *)icon title:(NSString *)title{
    if (self = [super initWithFrame:frame]) {
        UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgView.image = image;
        self.bgView = bgView;
        [self addSubview:bgView];
        
        UIImageView *iconView = [UIImageView new];
        iconView.image = icon;
        self.icon = iconView;
        [iconView sizeToFit];
        iconView.centerX_ych = self.width_ych * 0.5 ;
        iconView.centerY_ych = self.height_ych * 0.5;
        [self addSubview:iconView];
        
        UILabel *label = [UILabel new];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:10];
        label.size_ych = CGSizeMake(100, 20);
        label.centerX_ych = self.width_ych * 0.5 ;
        label.centerY_ych = self.height_ych + 6;
        self.titleView = label;
        self.titleView.alpha = 0;
        [self addSubview:label];

    }
    return self;
}

- (void)dealloc{
    
}


- (void)firstLogin{
    self.icon.alpha = 0;
    self.titleView.alpha = 1;
    [UIView animateWithDuration:0.5 delay:0.8 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.icon.alpha = 1;
    } completion:nil];
    
    [UIView animateWithDuration:0.3 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.titleView.alpha = 0;
    } completion:nil];
}

- (void)resetAnimation{
    [self.bgView.layer removeAllAnimations];
    
    CABasicAnimation *bAnimation = [CABasicAnimation animation];
    bAnimation.keyPath = @"transform.rotation.z";
    bAnimation.toValue = @(M_PI * 2);
    bAnimation.duration = 7;
    bAnimation.cumulative = YES;
    bAnimation.repeatCount = INT_MAX;
    bAnimation.removedOnCompletion = NO;
    
    [self.bgView.layer addAnimation:bAnimation forKey:@""];
}

@end

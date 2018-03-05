//
//  WAStartsShineView.m
//  WAStarryShow
//
//  Created by 黄锐灏 on 2018/3/5.
//  Copyright © 2018年 黄锐灏. All rights reserved.
//

#import "WAStartsShineView.h"
#import "CALayer+YCHExtension.h"
#import "UIView+YCHExtension.h"
@implementation WAStartsShineView

- (void)startAnimation:(CALayer *)layer
{
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = arc4random()%(200) / 100.0 + 1;
    animationGroup.animations = @[[self scaleAnimationWithDuration:animationGroup.duration],[self alphaAnimationWithDuration:animationGroup.duration]];
    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = INT_MAX;
    animationGroup.removedOnCompletion = NO;
    [layer addAnimation:animationGroup forKey:nil];
}

- (CAAnimation *)scaleAnimationWithDuration:(CGFloat)duration{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@(1),@(0.8),@(0.6),@(0.8),@(1)];
    animation.duration = duration;
    animation.repeatCount = INT_MAX;
    animation.removedOnCompletion = NO;
    return animation;
}

- (CAAnimation *)alphaAnimationWithDuration:(CGFloat)duration{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"opacity";
    animation.values = @[@1,@0.5,@0.2,@0.5,@0.8,@1];
    animation.removedOnCompletion = NO;
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = INFINITY;
    return animation;
}


- (CGPoint)randomPosition
{
    return CGPointMake(arc4random()%(int)self.width_ych, arc4random()%(int)self.height_ych);
}

- (void)buildBGSubview{
    
    for (int index = 1; index < kWAStartsShineBasicCount; index ++) {
        
        int count = arc4random()% 5 + 3;
        
        for (int i = 1; i <= count; i++) {
            CALayer *layer =[CALayer layer];
            layer.size_ych = CGSizeMake(30, 30);
            layer.contents = (__bridge id) [UIImage imageNamed:[NSString stringWithFormat:@"home_x%d",index]].CGImage;
            layer.position = [self randomPosition];
            [self.layer addSublayer:layer];
            [self startAnimation:layer];
        }
    }
}

@end

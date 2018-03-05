//
//  WAStarrySkyView.m
//  WAStarryShow
//
//  Created by 黄锐灏 on 2018/3/5.
//  Copyright © 2018年 黄锐灏. All rights reserved.
//

#import "WAStarrySkyView.h"
#import <POP.h>
#import "UIView+YCHExtension.h"
#import "CALayer+YCHExtension.h"
#define kYCHStarrySkyViewAnimation @"kYCHStarrySkyViewAnimation"

@interface WAStarrySkyView ()


@property (nonatomic , weak) CALayer *blackHole;

@property (nonatomic , weak) CALayer *saturn;

@property (nonatomic , weak) CALayer *bubble;

@end

@implementation WAStarrySkyView


- (instancetype)initWithImage:(UIImage *)image width:(CGFloat)width heigh:(CGFloat)heigh{
    
    if (self = [super init]) {
        CGFloat planetsW = width ;
        CGFloat planetsH = heigh ;
        CGFloat planetsX = - (planetsW - [UIScreen mainScreen].bounds.size.width) * 0.5;
        CGFloat planetsY = [UIScreen mainScreen].bounds.size.height - planetsH;
        self.frame = CGRectMake(planetsX, planetsY, planetsW, planetsH);
        
        if (image) {
            self.image = image;
        }else{
            self.backgroundColor = [UIColor clearColor];
        }
    }
    return self;
}

- (void)setX_ych:(CGFloat)x_ych{
    CGRect frame = self.frame;
    frame.origin.x = [self validateX:x_ych];
    self.frame = frame;
}

- (void)setY_ych:(CGFloat)y_ych{
    CGRect frame = self.frame;
    frame.origin.y = [self validateY:y_ych];
    self.frame = frame;
}


- (CGFloat)minX{
    return  [UIScreen mainScreen].bounds.size.width - self.width_ych;
}

- (CGFloat)minY{
    return [UIScreen mainScreen].bounds.size.height - self.height_ych;
}

- (CGFloat)maxY{
    return 0;
}

- (CGFloat)maxX {
    return 0;
}

- (void)beganDrag{
    [self pop_removeAllAnimations];
}

- (void)endDrag{
    
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    CGFloat newX = [self validateX:(self.x_ych + self.speedX * 0.3)];
    CGFloat newY = [self validateY:(self.y_ych + self.speedY * 0.3)];
    animation.fromValue = [NSValue valueWithCGRect:self.frame];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(newX, newY, self.width_ych, self.height_ych)];
    animation.duration = 1;
    animation.removedOnCompletion = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self pop_addAnimation:animation forKey:kYCHStarrySkyViewAnimation];
    
}

// 不超过边界
- (CGFloat)validateX:(CGFloat)x{
    if (x > self.maxX) {
        return self.maxX;
    }
    if (x < self.minX) {
        return self.minX;
    }
    return x;
}

// 不超过边界
- (CGFloat)validateY:(CGFloat)y{
    if (y > self.maxY) {
        return self.maxY;
    }
    if (y < self.minY) {
        return self.minY;
    }
    return y;
}


- (void)buildBGSubview{
    
    CALayer *bubble = [CALayer layer];
    bubble.contents = (__bridge id) [UIImage imageNamed:@"home_bubble"].CGImage;
    bubble.size_ych = CGSizeMake(125, 134);
    bubble.position = CGPointMake(self.width_ych - 79 - 67, 146);
    [self.layer addSublayer:bubble];
    
    
    self.bubble = bubble;
    
    CALayer *blackHole = [CALayer layer];
    blackHole.contents = (__bridge id) [UIImage imageNamed:@"home_vortex66"].CGImage;
    blackHole.size_ych = CGSizeMake(160, 160);
    blackHole.position = CGPointMake(80, 202);
    self.blackHole = blackHole;
    [self.layer addSublayer:blackHole];
    
    
    CALayer *littleStar = [CALayer layer];
    littleStar.contents = (__bridge id) [UIImage imageNamed:@"home_star4"].CGImage;
    littleStar.size_ych = CGSizeMake(62, 38);
    littleStar.position = CGPointMake(self.width_ych - 3 - 31, 231);
    self.saturn = littleStar;
    [self.layer addSublayer:littleStar];
    
    CALayer *ship = [CALayer layer];
    ship.contents = (__bridge id) [UIImage imageNamed:@"home_ship"].CGImage;
    ship.size_ych = CGSizeMake(199, 172);
    ship.position = CGPointMake(99.5, self.height_ych - 86);
    [self.layer addSublayer:ship];
    
}



- (BOOL)touchInNoOpenStar:(CGPoint)point{
    if( CGRectContainsPoint(self.bubble.frame, point) || CGRectContainsPoint(self.saturn.frame, point) || CGRectContainsPoint(self.blackHole.frame, point)){
        return YES;
    }
    return NO;
}

- (void)resetAnimation{
    [self.bubble removeAllAnimations];
    [self.blackHole removeAllAnimations];
    
    CABasicAnimation *blackHoleAnimation = [CABasicAnimation animation];
    blackHoleAnimation.keyPath = @"transform.rotation.z";
    blackHoleAnimation.fromValue = @0;
    blackHoleAnimation.toValue = @(M_PI * 2);
    blackHoleAnimation.removedOnCompletion = NO;
    blackHoleAnimation.duration = 3;
    blackHoleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    blackHoleAnimation.repeatCount = INFINITY;
    [self.blackHole addAnimation:blackHoleAnimation forKey:@"test"];
    
    CAKeyframeAnimation *buffLeAnimation = [CAKeyframeAnimation animation];
    buffLeAnimation.keyPath = @"opacity";
    buffLeAnimation.values = @[@1,@0.5,@0.2,@0.5,@0.8,@1];
    buffLeAnimation.removedOnCompletion = NO;
    buffLeAnimation.duration = 3;
    buffLeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    buffLeAnimation.repeatCount = INFINITY;
    [self.bubble addAnimation:buffLeAnimation forKey:@"test"];
}


@end

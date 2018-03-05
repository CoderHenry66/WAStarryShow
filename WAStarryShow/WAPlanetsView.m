//
//  WAPlanetsView.m
//  WAStarryShow
//
//  Created by 黄锐灏 on 2018/3/5.
//  Copyright © 2018年 黄锐灏. All rights reserved.
//

#import "WAPlanetsView.h"
#import "UIView+YCHExtension.h"
#import <POP.h>

#define kYCHPlanetViewMoveAnimationKey  @"kYCHPlanetViewMoveAnimationKey"

@interface WAPlanetsView ()

@property (nonatomic , assign) CGSize inlaySize;

@property (nonatomic , weak) WAPlanetView *firstPlanet;

@property (nonatomic , weak) WAPlanetView *secondPlanet;

@property (nonatomic , weak) WAPlanetView *thirdPlanet;

@property (nonatomic , weak) WAPlanetView *fourthPlanet;

@property (nonatomic , assign) CGFloat sum;

@end

@implementation WAPlanetsView

- (void)setXGap:(CGFloat)gap{
    self.firstPlanet.x_ych += gap  * self.firstPlanet.scale;
    self.secondPlanet.x_ych += gap  * self.secondPlanet.scale;
    self.thirdPlanet.x_ych += gap  * self.thirdPlanet.scale;
    self.fourthPlanet.x_ych += gap  * self.fourthPlanet.scale;
}

- (void)setYGap:(CGFloat)gap{
    
    self.firstPlanet.y_ych += gap  * self.firstPlanet.scale;
    self.secondPlanet.y_ych += gap  * self.secondPlanet.scale;
    self.thirdPlanet.y_ych += gap  * self.thirdPlanet.scale;
    self.fourthPlanet.y_ych += gap  * self.fourthPlanet.scale;
}

- (instancetype)initWithWidth:(CGFloat)width heigh:(CGFloat)heigh inlaySize:(CGSize)size{
    if (self = [super init]) {
        
        CGFloat planetsW = width ;
        CGFloat planetsH = heigh ;
        CGFloat planetsX = -(planetsW - [UIScreen mainScreen].bounds.size.width) * 0.5;
        CGFloat planetsY = [UIScreen mainScreen].bounds.size.height - planetsH;
        self.frame = CGRectMake(planetsX, planetsY, planetsW, planetsH);
        self.inlaySize = size;
        
        [self buildPlanetWithImage:[UIImage imageNamed:@"home_maillist"] frame:CGRectMake(160, 391, 125, 125) inSize:CGSizeMake(125, 125) planet:WAPlanetMessage];
        
        [self buildPlanetWithImage:[UIImage imageNamed:@"home_qiuti"] frame:CGRectMake(60, 210, 170, 170)  inSize:CGSizeMake(170, 170) planet:WAPlanetMeet];
        
        [self buildPlanetWithImage:[UIImage imageNamed:@"home_rankingList"] frame:CGRectMake(145, 99, 155, 155) inSize:CGSizeMake(155, 155) planet:WAPlanetFriend];
        
        [self buildPlanetWithImage:[UIImage imageNamed:@"home_star"] frame:CGRectMake(70, 49, 80, 80) inSize:CGSizeMake(80, 80) planet:WAPlanetSearch];
    }
    return self;
}

- (CGRect)ych_convertRect:(CGRect)rect
{
    CGFloat x = (self.width_ych - [UIScreen mainScreen].bounds.size.width) * 0.5 + rect.origin.x - (self.inlaySize.width - rect.size.width) * 0.5;
    CGFloat y = (self.height_ych - [UIScreen mainScreen].bounds.size.height)  + rect.origin.y - (self.inlaySize.height - rect.size.width) * 0.5;
    return CGRectMake(x, y, self.inlaySize.width, self.inlaySize.height);
}


- (void)buildPlanetWithImage:(UIImage *)image frame:(CGRect)frame inSize:(CGSize)size planet:(WAPlanet)planet
{
    CGRect planetFrame = [self ych_convertRect:frame];
    
    WAPlanetView *planetView = [[WAPlanetView alloc] initWithImage:image frame:planetFrame inlaySize:size];
    
    planetView.userInteractionEnabled = YES;
    planetView.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPlanet:)];
    [planetView.imageView addGestureRecognizer:ges];
    ges.view.tag = planet;
    
    planetView.origiPoint = planetFrame.origin;
    [self addSubview:planetView];
    
    switch (planet) {
            case WAPlanetMessage:
            self.firstPlanet = planetView;
            self.firstPlanet.scale = 1;
            [self.firstPlanet addLableLine:[UIImage imageNamed:@"home_line"] frame:CGRectMake(self.inlaySize.width * 0.5 + 20, self.inlaySize.height * 0.5 + 44, 19, 9)];
            [self.firstPlanet addLable:[UIImage imageNamed:@"home_seek"] frame:CGRectMake(self.inlaySize.width * 0.5 + 38, self.inlaySize.height * 0.5 + 38 , 60, 19)];
            
            break;
            
            case WAPlanetMeet:
        {       self.secondPlanet = planetView;
            self.secondPlanet.scale = 0.7;
            [self.secondPlanet addLightView:[UIImage imageNamed:@"home_qiuguang"] frame:[self ych_convertRect:CGRectMake(150, 391, 125, 125)]];
            [self.secondPlanet addLableLine:[UIImage imageNamed:@"home_line"] frame:CGRectMake(self.inlaySize.width * 0.5 + 19, self.inlaySize.height * 0.5 + 32, 19, 9)];
            [self.secondPlanet addLable:[UIImage imageNamed:@"home_meet"] frame:CGRectMake(self.inlaySize.width * 0.5 + 38, self.inlaySize.height * 0.5 + 27 , 30, 17.5)];
            break;
        }
            case WAPlanetFriend:
            self.thirdPlanet = planetView;
            self.thirdPlanet.scale = 0.5;
            [self.thirdPlanet addSkyAnimationWithclockwise:YES angle:M_PI * 0.06];
            [self.thirdPlanet addLableLine:[UIImage imageNamed:@"home_line"] frame:CGRectMake(self.inlaySize.width * 0.5 + 20, self.inlaySize.height * 0.5 + 22, 16, 7)];
            [self.thirdPlanet addLable:[UIImage imageNamed:@"home_friendL"] frame:CGRectMake(self.inlaySize.width * 0.5 + 37, self.inlaySize.height * 0.5 + 20 , 20, 12)];
            break;
            
            case WAPlanetSearch:
            self.fourthPlanet = planetView;
            self.fourthPlanet.scale = 0.3;
            [self.fourthPlanet addLightView:[UIImage imageNamed:@"home_halo"] frame:CGRectMake(0, 0, 68, 68)];

            break;
        default:
            break;
    }
}

- (void)beganDrag{
    [self.firstPlanet beganDrag];
    [self.secondPlanet beganDrag];
    [self.thirdPlanet beganDrag];
    [self.fourthPlanet beganDrag];
}

- (void)endDrag{
    [self.firstPlanet endDragWithSpeedX:self.speedX speedY:self.speedY];
    [self.secondPlanet endDragWithSpeedX:self.speedX speedY:self.speedY];
    [self.thirdPlanet endDragWithSpeedX:self.speedX speedY:self.speedY];
    [self.fourthPlanet endDragWithSpeedX:self.speedX speedY:self.speedY];
}

- (void)selectPlanet:(UITapGestureRecognizer *)ges{
    
    CGRect touchFrame = CGRectMake(ges.view.width_ych * 0.15, ges.view.height_ych * 0.15, ges.view.width_ych * 0.7, ges.view.height_ych * 0.7);
    // 缩小因光圈放大的点击范围
    if (CGRectContainsPoint(touchFrame, [ges locationInView:ges.view])) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(WAPlanetsViewSelect:type:)]) {
            [self.delegate WAPlanetsViewSelect:ges.view type:ges.view.tag];
        }
        
    }
    
}


- (void)resetAnimation{
    [self.firstPlanet.layer removeAllAnimations];
    [self.secondPlanet.layer removeAllAnimations];
    [self.thirdPlanet.layer removeAllAnimations];
    [self.fourthPlanet.layer removeAllAnimations];
    
    [self.firstPlanet addRotationAnimationWithclockwise:YES];
    
    [self.secondPlanet addSkyAnimationWithclockwise:NO angle:M_PI * 0.06];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[[self scaleAnimationWithDuration:5],[self alphaAnimationWithDuration:5]];
    animationGroup.duration = 5.0f;
    animationGroup.autoreverses = YES;
    animationGroup.repeatCount = INT_MAX;
    animationGroup.removedOnCompletion = NO;
    [self.secondPlanet.lightView.layer addAnimation:animationGroup forKey:nil];
    
    [self.thirdPlanet addSkyAnimationWithclockwise:YES angle:M_PI * 0.06];
    
    [self.fourthPlanet addRotationAnimationWithclockwise:NO];
    [self.fourthPlanet.lightView.layer addAnimation:[self rotationAnimationWithDuration:15 clockWise:YES] forKey:nil];
    
}

- (CAAnimation *)rotationAnimationWithDuration:(CGFloat)duration clockWise:(BOOL)clockWise{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    animation.toValue = clockWise ? @(M_PI * 2) : @(-M_PI * 2);
    animation.duration = duration;
    animation.repeatCount = INT_MAX;
    animation.removedOnCompletion = NO;
    return animation;
}

- (CAAnimation *)scaleAnimationWithDuration:(CGFloat)duration{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@(1),@(1.2),@(1.4),@(1.2),@(1)];
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

@end


@interface WAPlanetView ()

@property (nonatomic , assign) CGSize outlaySize;

@property (nonatomic , assign) CGSize inlaySize;

@property (nonatomic , assign) CGSize lightSize;

//  边界
@property (nonatomic , assign ) CGFloat maxX;

@property (nonatomic , assign ) CGFloat maxY;

@property (nonatomic , assign) CGFloat minX;

@property (nonatomic , assign) CGFloat minY;

// 消息提醒
@property (nonatomic , weak) UILabel *unreadCountLabel;
@end

@implementation WAPlanetView
- (instancetype)initWithImage:(UIImage *)image frame:(CGRect)frame inlaySize:(CGSize)size{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        UIImageView *imageView = [UIImageView new];
        imageView.size_ych = size;
        imageView.centerX_ych = self.width_ych * 0.5;
        imageView.centerY_ych = self.height_ych * 0.5;
        imageView.image = image;
        self.imageView = imageView;
        self.inlaySize = size;
        self.outlaySize = frame.size;
        [self addSubview:imageView];
    }
    return self;
}

- (void)addLightView:(UIImage *)image frame:(CGRect)frame{
    
    UIImageView *imageView = [UIImageView new];
    imageView.size_ych = frame.size;
    imageView.centerX_ych = self.width_ych * 0.5;
    imageView.centerY_ych = self.height_ych * 0.5;
    imageView.image = image;
    self.lightView = imageView;
    self.lightSize = frame.size;
    [self insertSubview:_lightView belowSubview:self.imageView];
}

- (void)addLable:(UIImage *)image frame:(CGRect)frame{
    UIImageView *imageView = [UIImageView new];
    imageView.frame = frame;
    imageView.image = image;
    self.nameView = imageView;
    [self insertSubview:self.nameView belowSubview:self.imageView];
}

- (void)addLableLine:(UIImage *)image frame:(CGRect)frame{
    UIImageView *imageView = [UIImageView new];
    imageView.frame = frame;
    imageView.image = image;
    self.lineView = imageView;
    [self insertSubview:self.lineView belowSubview:self.imageView];
}

- (void)addUnreadCountLableWithFrame:(CGRect)frame{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.layer.cornerRadius = frame.size.width * 0.5;
    label.layer.masksToBounds = YES;
    label.layer.shouldRasterize = YES;
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"1";
    self.unreadCountLabel = label;
    self.unreadCountLabel.hidden = YES;
    [self addSubview:label];
}

- (void)setScale:(CGFloat)scale{
    _scale = scale;
    
    self.maxX = self.origiPoint.x + (self.superview.width_ych - self.outlaySize.width) * scale * 0.5;
    self.minX = self.origiPoint.x - (self.superview.width_ych - self.outlaySize.width) * scale * 0.5;
    self.minY = self.origiPoint.y ;
    self.maxY = self.origiPoint.y + (self.superview.height_ych - self.outlaySize.height) * scale;
    
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

- (void)beganDrag{
    [self pop_removeAnimationForKey:kYCHPlanetViewMoveAnimationKey];
}

- (void)endDragWithSpeedX:(CGFloat)x speedY:(CGFloat)y{
    
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewFrame];
    CGFloat newX = [self validateX:(self.x_ych + x * 0.3 * self.scale) ];
    CGFloat newY = [self validateY:(self.y_ych + y * 0.3 * self.scale) ];
    animation.fromValue = [NSValue valueWithCGRect:self.frame];
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(newX, newY, self.width_ych, self.height_ych)];
    animation.duration = 1;
    animation.removedOnCompletion = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self pop_addAnimation:animation forKey:kYCHPlanetViewMoveAnimationKey];
    
}

- (void)setX_ych:(CGFloat)x_ych{
    CGRect frame = self.frame;
    frame.origin.x = [self validateX:x_ych];
    self.frame = frame;
    self.imageView.centerX_ych = self.width_ych * 0.5;
    if (self.lightView) {
        self.lightView.centerX_ych = self.imageView.centerX_ych;
    }
}

- (void)setY_ych:(CGFloat)y_ych{
    CGRect frame = self.frame;
    frame.origin.y = [self validateY:y_ych];
    
    CGFloat scale = (frame.origin.y - self.origiPoint.y) / [UIScreen mainScreen].bounds.size.height * 3 + 1;
    
    if (scale > 1.6) {
        self.lineView.hidden = YES;
        self.nameView.hidden = YES;
        self.unreadCountLabel.hidden = YES;
    }else{
        if (self.lineView) {
            self.lineView.hidden = NO;
            self.lineView.alpha = 1 - (scale - 1) / 0.6;
        }
        
        if (self.nameView) {
            self.nameView.hidden = NO;
            self.nameView.alpha = 1 - (scale - 1) / 0.6;
        }
    }

    
    self.imageView.width_ych = scale  * self.inlaySize.width ;
    self.imageView.height_ych = scale * self.inlaySize.height;
    
    self.imageView.centerY_ych = self.height_ych * 0.5;
    if (self.lightView) {
        self.lightView.width_ych = (frame.origin.y - self.origiPoint.y) / [UIScreen mainScreen].bounds.size.height  * self.inlaySize.width  * 3 + self.lightSize.width;
        self.lightView.height_ych = (frame.origin.y - self.origiPoint.y) / [UIScreen mainScreen].bounds.size.height  * self.inlaySize.height * 3 + self.lightSize.height;
        self.lightView.center = self.imageView.center;
    }
    self.frame = frame;
}

- (void)addRotationAnimationWithclockwise:(BOOL)clockWise{
    
    CABasicAnimation *bAnimation = [CABasicAnimation animation];
    bAnimation.keyPath = @"transform.rotation.z";
    bAnimation.toValue = clockWise ? @(M_PI * 2) : @(-M_PI * 2);
    bAnimation.duration = 15;
    bAnimation.repeatCount = INT_MAX;
    bAnimation.removedOnCompletion = NO;
    [self.imageView.layer addAnimation:bAnimation forKey:@""];
}

- (void)addSkyAnimationWithclockwise:(BOOL)clockWise angle:(CGFloat)angle{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.rotation.z";
    if (clockWise) {
        animation.values = @[@(0),@(angle),@(0),@(-angle),@(0)];
        
    }else{
        animation.values = @[@(0),@(-angle),@(0),@(angle),@(0)];
    }
    animation.duration = 7;
    animation.repeatCount = INT_MAX;
    animation.removedOnCompletion = NO;
    [self.imageView.layer addAnimation:animation forKey:@""];
}

- (void)resetAnimation{
    
}


@end

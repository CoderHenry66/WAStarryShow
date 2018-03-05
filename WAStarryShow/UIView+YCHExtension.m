//
//  UIView+Extension.h
//  快捷更改flame
//
//  Created by apple on 14-10-7.
//  Copyright (c) 2014年 flame. All rights reserved.
//

#import "UIView+YCHExtension.h"

@implementation UIView (YCHExtension)

- (void)setX_ych:(CGFloat)x_ych
{
    CGRect frame = self.frame;
    frame.origin.x = x_ych;
    self.frame = frame;
}

- (void)setY_ych:(CGFloat)y_ych{
    CGRect frame = self.frame;
    frame.origin.y = y_ych;
    self.frame = frame;
}

- (CGFloat)x_ych
{
    return self.frame.origin.x;
}

- (CGFloat)y_ych
{
    return self.frame.origin.y;
}

- (void)setCenterX_ych:(CGFloat)centerX_ych
{
    CGPoint center = self.center;
    center.x = centerX_ych;
    self.center = center;
}

- (CGFloat)centerX_ych
{
    return self.center.x;
}

- (void)setCenterY_ych:(CGFloat)centerY_ych
{
    CGPoint center = self.center;
    center.y = centerY_ych;
    self.center = center;
}

- (CGFloat)centerY_ych
{
    return self.center.y;
}

- (void)setWidth_ych:(CGFloat)width_ych
{
    CGRect frame = self.frame;
    frame.size.width = width_ych;
    self.frame = frame;
}

- (void)setHeight_ych:(CGFloat)height_ych
{
    CGRect frame = self.frame;
    frame.size.height = height_ych;
    self.frame = frame;
}

- (CGFloat)height_ych
{
    return self.frame.size.height;
}

- (CGFloat)width_ych
{
    return self.frame.size.width;
}

- (void)setSize_ych:(CGSize)size_ych
{
    CGRect frame = self.frame;
    frame.size = size_ych;
    self.frame = frame;
}

- (CGSize)size_ych
{
    return self.frame.size;
}

- (void)setOrigin_ych:(CGPoint)origin_ych
{
    CGRect frame = self.frame;
    frame.origin = origin_ych;
    self.frame = frame;
}

- (CGPoint)origin_ych
{
    return self.frame.origin;
}

- (void)setMaxX_ych:(CGFloat)maxX_ych {
    CGRect frame = self.frame;
    frame.origin.x = maxX_ych - frame.size.width;
    self.frame = frame;
}

- (CGFloat)maxX_ych {
    return self.x_ych + self.width_ych;
}

- (void)setMaxY_ych:(CGFloat)maxY_ych {
    CGRect frame = self.frame;
    frame.origin.y = maxY_ych - frame.size.height;
    self.frame = frame;
}

- (CGFloat)maxY_ych {
    return self.y_ych + self.height_ych;
}

- (CGSize)rotateSize{
    return CGSizeMake(self.size_ych.height, self.size_ych.width);
}

+ (UIView *)ych_blurViewWithFrame:(CGRect)frame
{
        return [self ych_blurViewWithFrame:frame style:UIBlurEffectStyleLight];
}

+ (UIView *)ych_blurViewWithFrame:(CGRect)frame style:(UIBlurEffectStyle)style {
    UIView *BlurView;
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (version >= 8.0f) {
        
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:style];
        BlurView = [[UIVisualEffectView alloc] initWithEffect:blur];
        ((UIVisualEffectView *)BlurView).frame = frame;
        
    }else if(version >= 7.0f){
        
        BlurView = [[UIToolbar alloc] initWithFrame:frame];
        ((UIToolbar *)BlurView).barStyle = UIBarStyleDefault;
        
    }else{
        
        BlurView = [[UIView alloc] initWithFrame:frame];
        [BlurView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.9f]];
    }
    return BlurView;
}

- (void)ych_cornerRadius:(CGSize)size location:(UIRectCorner)corner
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds      byRoundingCorners:corner  cornerRadii:size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (UIColor *)ych_colorWithPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    CGFloat cgR = pixel[0];
    CGFloat cgG = pixel[1];
    CGFloat cgB = pixel[2];
    CGFloat cgA = pixel[3];
    /**
     *  led灯无法显示浅颜色的值
     */
    if (cgG > 200 && cgB < 180 && cgB > 50) {
        cgB = cgB * 0.5 / 255.0;
    }
    else if (cgG > 200 && cgR < 180 && cgR > 50)
    {
        cgR = cgR * 0.5 / 255.0;
    }
    cgR = cgR / 255.0;
    cgG = cgG / 255.0;
    cgB = cgB / 255.0;
    cgA = cgA / 255.0;
    
    
    UIColor *color = [UIColor colorWithRed:cgR green:cgG blue:cgB alpha:cgA];
    
    return color;
}
- (CGFloat)ych_angleWithPoint:(CGPoint)point
{
    CGFloat distance = sqrt(pow(point.x - self.width_ych * 0.5, 2) + pow(point.y - self.height_ych * 0.5 , 2));
    if (point.x < self.width_ych * 0.5) {
        CGFloat sinf = (self.width_ych * 0.5 - point.x) / distance;
        return  point.y > self.height_ych * 0.5 ?  (M_PI  +  asinf(sinf)) : (M_PI * 2 - asinf(sinf)) ;
    }
    else if (point.x == self.width_ych * 0.5)
    {
        return point.y > self.height_ych * 0.5 ?  M_PI : 0;
    }
    else
    {
        CGFloat sinf = (point.x - self.width_ych * 0.5) / distance;
        return point.y > self.width_ych * 0.5 ?  (M_PI_2 + acosf(sinf)) : asinf(sinf);
    }
}
- (CGPoint)ych_pointWithAngel:(CGFloat)angle radius:(CGFloat)radius
{
    return  CGPointMake(self.width_ych * 0.5 + radius * sin(angle), self.height_ych * 0.5 - radius * cos(angle));
}

- (UIViewController *)ych_viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end

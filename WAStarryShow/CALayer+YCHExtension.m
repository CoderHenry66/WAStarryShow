//
//  CALayer+YCHExtension.m
//  YCH
//
//  Created by 黄锐灏 on 17/4/18.
//  Copyright © 2017年 黄锐灏. All rights reserved.
//

#import "CALayer+YCHExtension.h"

@implementation CALayer (YCHExtension)

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

@end

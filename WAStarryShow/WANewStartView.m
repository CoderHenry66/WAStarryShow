//
//  WANewStartView.m
//  WAStarryShow
//
//  Created by 黄锐灏 on 2018/3/5.
//  Copyright © 2018年 黄锐灏. All rights reserved.
//

#import "WANewStartView.h"
#import "UIView+YCHExtension.h"
@implementation WANewStartView{
    NSTimer *_dismissTimer;
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self baseUI];
    }
    return self;
}

- (void)baseUI{
    
    CALayer *bgLayer = [CALayer layer];
    bgLayer.frame = self.bounds;
    bgLayer.contents = (__bridge id)[UIImage imageNamed:@"guide_tsbg"].CGImage;
    [self.layer addSublayer:bgLayer];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 14, self.width_ych, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:19];
    label.text = @"神秘星球  正在探索中...";
    label.textColor = [UIColor colorWithRed:120.0 / 255.0 green:210.0/255.0 blue:1 alpha:1];
    [self addSubview:label];
}

- (void)newStarshow{
    
    self.hidden = NO;
    
    if (_dismissTimer) {
        [_dismissTimer invalidate];
    }
    
    _dismissTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(newStarDismiss) userInfo:nil repeats:NO];
    
    [[NSRunLoop mainRunLoop] addTimer:_dismissTimer forMode:NSRunLoopCommonModes];
    
}

- (void)newStarDismiss{
    self.hidden = YES;
}

@end

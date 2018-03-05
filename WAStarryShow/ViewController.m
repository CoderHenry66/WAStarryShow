//
//  ViewController.m
//  WAStarryShow
//
//  Created by 黄锐灏 on 2018/3/5.
//  Copyright © 2018年 黄锐灏. All rights reserved.
//

#import "ViewController.h"
#import "WAPlanetsView.h"
#import "WAStarrySkyView.h"
#import "WANewStartView.h"
#import "WAMeteorSnowerView.h"
#import "WAStartsShineView.h"
#import "UIView+YCHExtension.h"
#import "WAHomeStateView.h"
#import "WASearchStar.h"

#define kYCHStarryBGScrollScale 0.5
#define kYCPlanetScrollScale 0.6
@interface ViewController () <WAPlanetsViewDelegate>

// 背景行星
@property (nonatomic , weak) WAPlanetsView *planetView;

// 背景星空
@property (nonatomic , weak) WAStarrySkyView *bgView;

// 背景星星
@property (nonatomic , weak) WAStarrySkyView *starsView;

// 闪烁星星
@property (nonatomic , weak) WAStartsShineView *shineView;

@property (nonatomic , weak) WANewStartView *newstart;

// 状态
@property (nonatomic , weak) WAHomeStateView *stateView;

// 搜索
@property (nonatomic , weak) WASearchStar *searchStar;

// 屏幕当前位置
@property (nonatomic , assign) CGPoint posision;

// 当前时间
@property (nonatomic , strong) NSDate *currentime;

@property (nonatomic , assign) CGFloat starsScrollXScale;

@property (nonatomic , assign) CGFloat starsScrollYScale;

@property (nonatomic , assign) CGFloat planetsScrollXScale;

@property (nonatomic , assign) CGFloat planetsScrollYScale;

@property (nonatomic , assign) CGFloat shineScrollXScale;

@property (nonatomic , assign) CGFloat shineScrollYScale;

@property (nonatomic , weak) UIImageView *shareView;

@property (nonatomic , weak) WAMeteorSnowerView *meteor;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self buildBaseUI];
    
    [self.bgView resetAnimation];
    [self.planetView resetAnimation];
    [self.searchStar resetAnimation];
    
    [self loginAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark BaseUI
- (void)buildBaseUI{
    
   
    [self setNeedsStatusBarAppearanceUpdate];
    // 星空
    WAStarrySkyView *bgview = [[WAStarrySkyView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[UIScreen mainScreen].scale == 3 ? @"home_background@3x" : @"home_background@2x" ofType:@"jpg"]] width:711 heigh:1188];
    _bgView = bgview;
    [bgview buildBGSubview];
    [self.view addSubview:_bgView];
    
    // 闪烁星星
    WAStartsShineView *shineView = [[WAStartsShineView alloc] initWithImage:nil width:860 heigh:1333];
    _shineView = shineView;
    [shineView buildBGSubview];
    [self.view addSubview:shineView];
    self.shineScrollXScale = [NSString stringWithFormat:@"%.3f",(860.0 - self.view.bounds.size.width) / (711.0 - self.view.bounds.size.width) ].floatValue * kYCHStarryBGScrollScale;
    self.shineScrollYScale = [NSString stringWithFormat:@"%.3f",(1333.0 -  self.view.bounds.size.height)/ (1188.0 - self.view.bounds.size.height)].floatValue * kYCHStarryBGScrollScale;
    
    // 星星
    WAStarrySkyView *starsview = [[WAStarrySkyView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[UIScreen mainScreen].scale == 3 ? @"home_xingxing@3x" : @"home_xingxing@2x" ofType:@"png"]] width:1165 heigh:1507];
    _starsView = starsview;
    [self.view addSubview:_starsView];
    
    self.starsScrollXScale = [NSString stringWithFormat:@"%.3f",(1165.0 - self.view.bounds.size.width) / (711.0 - self.view.bounds.size.width ) ].floatValue * kYCHStarryBGScrollScale;
    self.starsScrollYScale = [NSString stringWithFormat:@"%.3f",(1507.0 -  self.view.bounds.size.height)/ (1188.0 - self.view.bounds.size.height)].floatValue * kYCHStarryBGScrollScale;
    
    // 流星
    WAMeteorSnowerView *meteor = [WAMeteorSnowerView layer];
    _meteor = meteor;
    [self.view.layer addSublayer:meteor];
    _meteor.emitterPosition = CGPointMake(self.view.width_ych * 0.5, self.view.height_ych * 0.2);
    _meteor.emitterSize = CGSizeMake(self.view.width_ych, self.view.height_ych * 0.5);
    _meteor.emitterDepth = -50;
    _meteor.preservesDepth = YES;
    
    _meteor.emitterShape = kCAEmitterLayerRectangle;
    _meteor.emitterMode = kCAEmitterLayerSurface;
    _meteor.renderMode = kCAEmitterLayerOldestLast;
    [self.meteor setCellName:@"meteor"];
    
    // 行星
    WAPlanetsView *planetsview = [[WAPlanetsView alloc] initWithWidth:1800 heigh:2300 inlaySize:CGSizeMake(200, 200)];
    planetsview.delegate = self;
    _planetView = planetsview;
    [self.view addSubview:planetsview];
    
    self.planetsScrollXScale = [NSString stringWithFormat:@"%.3f",(1800 - 200)/ (711.0 - self.view.bounds.size.width)].floatValue * kYCHStarryBGScrollScale;
    self.planetsScrollYScale = [NSString stringWithFormat:@"%.3f",(2300 -  200)/ (1188.0 - self.view.bounds.size.height)].floatValue * kYCHStarryBGScrollScale;
    

    // 搜索
    WASearchStar *seachStar = [[WASearchStar alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 150, 150, 150) image:[UIImage imageNamed:@"home_sousuo_guang"] icon:[UIImage imageNamed:@"home_tongxunlu"] title:NSLocalizedString(@"寻找你的知己", nil)];
    self.searchStar = seachStar;
    [self.view addSubview:self.searchStar];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event

{
    //    [YCHProgressHUD showLoading];
    // 移动中
    UITouch *touch = [touches anyObject];
    self.posision = [touch locationInView:self.view];
    self.currentime = [NSDate date];
    [self.bgView beganDrag];
    [self.shineView beganDrag];
    [self.starsView beganDrag];
    [self.planetView beganDrag];
    
    if([self.bgView touchInNoOpenStar:[touch locationInView:self.bgView]]){
        [self newStarts];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //移动中
    UITouch *touch = [touches anyObject];
    CGPoint newPoint = [touch locationInView:self.view];
    
    static CGFloat xGap,yGap = 0;
    xGap = newPoint.x - self.posision.x;
    yGap = newPoint.y - self.posision.y;
    
    self.bgView.x_ych += xGap * kYCHStarryBGScrollScale;
    self.bgView.y_ych += yGap * kYCHStarryBGScrollScale;
    
    self.shineView.x_ych += xGap * self.shineScrollYScale;
    self.shineView.y_ych += yGap * self.shineScrollYScale;
    
    self.starsView.x_ych += xGap * self.starsScrollXScale;
    self.starsView.y_ych += yGap * self.starsScrollYScale;
    
    [self.planetView setXGap:xGap * self.planetsScrollXScale];
    [self.planetView setYGap:yGap * self.planetsScrollYScale];
    
    static double timeGap = 0;
    timeGap = [self.currentime timeIntervalSinceDate:[NSDate date]];
    self.bgView.speedX = - xGap * kYCHStarryBGScrollScale / timeGap;
    self.bgView.speedY = - yGap * kYCHStarryBGScrollScale / timeGap;
    
    self.shineView.speedX = - xGap * self.shineScrollXScale / timeGap;
    self.shineView.speedY = - yGap * self.shineScrollYScale / timeGap;
    
    self.starsView.speedX = - xGap * self.starsScrollXScale / timeGap;
    self.starsView.speedY = - yGap * self.starsScrollYScale / timeGap;
    
    self.planetView.speedX = - xGap * self.planetsScrollXScale / timeGap;
    self.planetView.speedY = - yGap * self.planetsScrollYScale / timeGap;
    
    self.posision = newPoint;
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.bgView endDrag];
    [self.shineView endDrag];
    [self.starsView endDrag];
    [self.planetView endDrag];
}


- (void)newStarts{
    [self.newstart newStarshow];
}

#pragma mark starrySky delegate
- (void)noOpenStarDelegate:(WAStarrySkyView *)skyView{
    [self newStarts];
}

#pragma mark planetsView delegate
- (void)WAPlanetsViewSelect:(UIView *)planet type:(WAPlanet)planetType{
    switch (planetType) {
            case WAPlanetSearch:
            [self newStarts];
            break;
            
        default:
            break;
    }
}

#pragma mark Target

- (void)loginAnimation{
    
    [[UIApplication sharedApplication].keyWindow  insertSubview:self.searchStar aboveSubview:self.navigationController.view];
    self.stateView.hidden = YES;
    self.shareView.hidden = YES;
    self.searchStar.centerX_ych = self.view.bounds.size.width * 0.5;
    self.searchStar.centerY_ych = self.view.bounds.size.height * 0.5;
    //        self.searchStar.origin_ych = CGPointMake(0, [UIProxy shareUIProxy].screenHeight - 150);
    self.searchStar.layer.transform = CATransform3DMakeScale(2, 2, 1);
    self.view.layer.opacity = 0;
    self.view.layer.transform = CATransform3DMakeScale(2, 2, 1);
    self.view.userInteractionEnabled = NO;
    self.searchStar.userInteractionEnabled = NO;
    [self.searchStar firstLogin];
    
    [UIView animateWithDuration:2.5 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.searchStar.layer.transform = CATransform3DMakeScale(1, 1, 1);
        self.searchStar.origin_ych = CGPointMake(0, self.view.bounds.size.height - 150);
        self.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
        self.view.layer.opacity = 1;
    } completion:^(BOOL finished) {
        [self.searchStar removeFromSuperview];
        [self.view addSubview:self.searchStar];
        self.stateView.hidden = NO;
        self.shareView.hidden = NO;
        self.searchStar.userInteractionEnabled = YES;
        self.view.userInteractionEnabled = YES;
    }];
  
}

#pragma mark getter and setter
- (WANewStartView *)newstart{
    if (!_newstart) {
        WANewStartView *new = [[WANewStartView alloc] initWithFrame:CGRectMake(45, (self.view.height_ych - 47) * 0.5, self.view.width_ych - 90, 47)];
        _newstart = new;
        new.hidden = YES;
        [self.view addSubview:_newstart];
    }
    return _newstart;
}



@end

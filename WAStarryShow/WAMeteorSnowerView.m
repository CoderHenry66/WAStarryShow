//
//  WAMeteorSnowerView.m
//  WAStarryShow
//
//  Created by 黄锐灏 on 2018/3/5.
//  Copyright © 2018年 黄锐灏. All rights reserved.
//

#import "WAMeteorSnowerView.h"

@implementation WAMeteorSnowerView

- (void)setCellName:(NSString *)cellName{
    _cellName = [cellName copy];
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    [cell setName:cellName];
    cell.contents = (id)[UIImage imageNamed:@"liuxing"].CGImage;
    
    
    cell.redRange = 0.46f;
    cell.greenRange = 0.49f;
    cell.blueRange = 0.67f;
    cell.alphaRange = 0.55f;
    
    cell.redSpeed = 0.11f;
    cell.greenSpeed = 0.07f;
    cell.blueSpeed = - 0.25f;
    cell.alphaSpeed = 0.15f;
    
    cell.scale = 0.6f;
    cell.scaleRange = 0.5f;
    
    cell.lifetime = 3.f;
    cell.lifetimeRange = .25f;
    cell.birthRate = 1.2;
    
    cell.velocity = 250.0f;
    cell.velocityRange = 75.0f;
    cell.emissionLongitude =  M_PI / 4 * 3;
    //        cell.emissionLatitude = M_PI * 0.5;
    
    self.emitterCells = @[cell];
}

@end

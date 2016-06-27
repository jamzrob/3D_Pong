//
//  paddleView.m
//  3Dpong
//
//  Created by James Raubenheimer on 2/14/15.
//  Copyright (c) 2015 Raubenblahblah. All rights reserved.
//

#import "paddleView.h"

@implementation paddleView


-(void) drawRect:(CGRect)rect
{
    
    // Drawing code
    float viewWidth,viewHeight, viewX, viewY;
    
    viewWidth=self.bounds.size.width;
    viewHeight=self.bounds.size.height;
    viewX = self.bounds.origin.x;
    viewY =self.bounds.origin.y;
    
    
    CGRect playerRect=CGRectMake(viewX, viewY, viewWidth, viewHeight);
    UIBezierPath*path=[UIBezierPath bezierPathWithRect:playerRect];
    
    [[UIColor greenColor]setFill];
    [[UIColor greenColor]setStroke];
    path.lineWidth=6.0;
    [path stroke];
    

    
    
}

@end

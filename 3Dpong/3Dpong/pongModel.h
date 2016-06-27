//
//  pongModel.h
//  3Dpong
//
//  Created by James Raubenheimer on 2/15/15.
//  Copyright (c) 2015 Raubenblahblah. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "ballView.h"


#define BLOCK_HEIGHT 20.0
#define BLOCK_WIDTH  64.0
#define BALL_SIZE 20.0
#define VIEW_WIDTH 320.0
#define VIEW_HEIGHT 500.0

@interface pongModel : NSObject {
    NSMutableArray* blocks;
    CGRect paddleRect;
    CGRect oPaddleRect;
    CGRect ballRect;
    CGPoint ballVelocity;
    CGFloat lastTime;
    CGFloat timeDelta;
    CGRect screenBound;
    CGSize screenSize;
    CGFloat screenWidth;
    CGFloat screenHeight;
  
    
    int yourScore;
    int oppScore;
    BOOL collideWithScreen;
}

@property BOOL collideWithScreen;
@property int yourScore;
@property int oppScore;



@property CGRect oPaddleRect;
@property CGRect ballRect;
@property CGRect paddleRect;
@property float timeDelta;
@property CGPoint ballVelocity;
- (void) updateModelWithTime:(CFTimeInterval) timestamp;
- (void) checkCollisionWithScreenEdges;
- (void) checkCollisionWithBlocks;
- (void) checkCollisionWithPaddle;

-(BOOL) checkCollisionWithEdge;

@end
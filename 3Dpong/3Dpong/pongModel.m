//
//  BlockerModel.m
//  Blocker
//
//  Created by Alessi Patrick on 9/9/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "pongModel.h"

@implementation pongModel
@synthesize ballRect,paddleRect, oPaddleRect;


// Override superclass implementation of init so that we can provide a properly
// initialized game model
- (id)init {
    self = [super init];
    
    if (self) {
        
       
        
        collideWithScreen=false;
        //Set Screen Size
         screenBound = [[UIScreen mainScreen] bounds];
        screenSize = screenBound.size;
        screenWidth = screenSize.width;
         screenHeight = screenSize.height;
        
        // Set the paddle rect by using the size of the paddle image
        paddleRect = CGRectMake(screenWidth/2, screenHeight-50,
                                100, 25);
        
        oPaddleRect= CGRectMake(screenWidth/2, 50, 100, 25);
        
        // Set the ball rect by using the size of the paddle image
  
        ballRect = CGRectMake(180.0, 220.0,
                              20, 20);
        
        // Set the initial velocity for the ball
        ballVelocity = CGPointMake(200.0, -200.0);
        
        // Initialize the lastTime
        lastTime = 0.0;
        
        
    }
    
    return self;
}

- (void) checkCollisionWithScreenEdges {
    // Change ball direction if it hit an edge of the screen
    // Left edge
    if (ballRect.origin.x <= 0)
    {
        // Flip the x velocity component
        ballVelocity.x = abs(ballVelocity.x);
    }
    
    // Right edge
    if (ballRect.origin.x >= screenWidth - BALL_SIZE)
    {
        // Flip the x velocity component
        ballVelocity.x = -1 * abs(ballVelocity.x);
    }
    
    if (ballRect.origin.y <=  0)
    {
        // Flip the x velocity component
        ballVelocity.y = abs(ballVelocity.y);
        
        
        yourScore=yourScore+1;
        
        
    }

    
    
    
   if(ballRect.origin.y >= screenHeight-20)
    {
        ballVelocity.y = -1*abs(ballVelocity.y);
        
        
        yourScore=yourScore+1;
     
     
    }
    

}


- (void) checkCollisionWithPaddle {
    // Check to see if the paddle has blocked the ball
    if (CGRectIntersectsRect(ballRect,paddleRect)) {
        // Flip the y velocity component
        ballVelocity.y = -1 * abs( ballVelocity.y);
        
    }
    
    if(CGRectIntersectsRect(ballRect,oPaddleRect)) {
        //Flip the y velocity componet
        ballVelocity.y=abs(ballVelocity.y);
    }
}





-(void) updateModelWithTime:(CFTimeInterval) timestamp
{
    if (lastTime == 0.0)
    {
        // First time through, initialize the lastTime
        lastTime = timestamp;
    }
    else
    {
        // Calculate time elapsed since last call
        timeDelta = timestamp - lastTime;
        
        // Update the lastTime
        lastTime = timestamp;
        
        // Calculate new position of the ball
        CGRect newBallRect= ballRect;
        newBallRect.origin.x += ballVelocity.x * timeDelta;
        newBallRect.origin.y += ballVelocity.y * timeDelta;
        ballRect= newBallRect;
        
        
        
      
        
    }
    
}

@end

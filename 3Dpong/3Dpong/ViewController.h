//
//  ViewController.h
//  3Dpong
//
//  Created by James Raubenheimer on 2/14/15.
//  Copyright (c) 2015 Raubenblahblah. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "paddleView.h"
#import "ballView.h"
#import "pongModel.h"


@interface ViewController : UIViewController
{
    paddleView* paddle;
    paddleView* oPaddle;
    ballView* ball;
    pongModel* gameModel;
    
    CGRect screenRect;
    CGFloat screenWidth;
    CGFloat screenHeight;
    CADisplayLink* gameTimer;
   
    UILabel* myLabel;
   
    
    

}

@property (nonatomic, strong) UILabel *myLabel;

-(void) updateDisplay:(CADisplayLink*)sender ;
-(void) restartApp;
@end


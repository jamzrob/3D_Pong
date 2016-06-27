//
//  ViewController.m
//  3Dpong
//
//  Created by James Raubenheimer on 2/14/15.
//  Copyright (c) 2015 Raubenblahblah. All rights reserved.
//

#import "ViewController.h"

#import <CoreMotion/CoreMotion.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //Finds the heigh and lenth of phone
     screenRect = [[UIScreen mainScreen] bounds];
     screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    NSLog(@"%f",screenHeight);
    
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    gameModel=[[pongModel alloc] init];
    
    
    //Creates a paddle Rect Change values
  
    paddle= [[paddleView alloc]
             initWithFrame:gameModel.paddleRect];
    [self.view addSubview:paddle];
    
    
    //Creats opponents paddle
    oPaddle= [[paddleView alloc]
              initWithFrame:gameModel.oPaddleRect];
    [self.view addSubview:oPaddle];
    
    //Draws a ball
    ball= [[ballView alloc]
           initWithFrame:gameModel. ballRect];
    ball.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:ball];
    
    
    //start the CADisplayLink
    gameTimer=[CADisplayLink displayLinkWithTarget:self
                                          selector:@selector(updateDisplay:)];
    
    [gameTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    //start the CADisplayLink
   // gameTimer=[CADisplayLink displayLinkWithTarget:self
       //                                   selector:@selector(updateDisplay:)];
    
    //[gameTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

    
    //Adds in a label
    //To be used for testing
    
    CGRect labelFrame = CGRectMake(100.0f, 100.0f, 250.0f, 40.0f);
    //create the label
    self.myLabel = [[UILabel alloc] initWithFrame:labelFrame];
    //set the label text
    self.myLabel.text = @"0";
    //set the lable font
    self.myLabel.font = [UIFont boldSystemFontOfSize:40.0f];
    //se the text alignment
    self.myLabel.textAlignment =  NSTextAlignmentCenter;
    
   
    //se the border color and width
       //add the label to the view
    [self.view addSubview:self.myLabel];
    gameModel.yourScore=0;
    gameModel.oppScore=0;

}


-(void) updateDisplay:(CADisplayLink*)sender
{
    
    
    // This method is called by the gameTimer each time the display should
    // update
    
    // Update the model
    [gameModel updateModelWithTime:sender.timestamp];
    
   
    CGRect newBallRect= ball.frame;
    newBallRect.origin.x+=gameModel.timeDelta * gameModel.ballVelocity.x;
    newBallRect.origin.y+=gameModel.timeDelta*gameModel.ballVelocity.y;
    // Update the display
    [ball setFrame:gameModel.ballRect];
    
    
    newBallRect.origin.y=oPaddle.frame.origin.y;
    newBallRect.size.height=oPaddle.frame.size.height;
    newBallRect.size.width=oPaddle.frame.size.width;
    [oPaddle setFrame:newBallRect];
    
    
    
    // Check for collision with screen edges
    [gameModel checkCollisionWithScreenEdges];
    
    
    // Do collision detection with paddle
    [gameModel checkCollisionWithPaddle];
    

    
    [gameModel checkCollisionWithScreenEdges];
    
    if (ball.frame.origin.y <=  0)
    {
        
        
        
        gameModel.yourScore=gameModel.yourScore+1;
        
        
    }
    
    
    
    
    if(ball.frame.origin.y >= screenHeight-20)
    {
        
        
        gameModel.yourScore=gameModel.yourScore+1;
        
        
    }

    self.myLabel.text= [NSString stringWithFormat:@"%i", gameModel.yourScore];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (CMMotionManager *)motionManager
{
    CMMotionManager *motionManager = nil;
    
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate respondsToSelector:@selector(motionManager)]) {
        motionManager = [appDelegate motionManager];
    }
    
    return motionManager;
}

- (void)startMyMotionDetect
{
    

    
    __block float stepMoveFactor = 15;
    
    [self.motionManager
     startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init]
     withHandler:^(CMAccelerometerData *data, NSError *error)
     {
         
         dispatch_async(dispatch_get_main_queue(),
                        ^{
                            
                            CGRect rect = paddle.frame;
                            
                            float movetoX = rect.origin.x + (data.acceleration.x * stepMoveFactor);
                            float maxX = self.view.frame.size.width - rect.size.width;
                            
                            float movetoY = (rect.origin.y + rect.size.height)
                            - (data.acceleration.y * stepMoveFactor);
                            
                           
                            
                            if ( movetoX > 0 && movetoX < maxX ) {
                                rect.origin.x += (data.acceleration.x * stepMoveFactor);
                            };
                            
                          
                            
                           if(movetoY <= (screenHeight - 100))
                           {
                                rect.origin.y -= (data.acceleration.y * stepMoveFactor);
                            }
                            
                            [UIView animateWithDuration:0 delay:0
                                                options:UIViewAnimationCurveEaseInOut 
                                             animations:
                             ^{
                                 paddle.frame = rect;
                             }
                                             completion:nil
                             ];
                            
                        }
                        );
     }
     ];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    [self startMyMotionDetect];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [self.motionManager stopAccelerometerUpdates];
    
}







@end

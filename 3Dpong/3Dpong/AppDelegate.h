//
//  AppDelegate.h
//  3Dpong
//
//  Created by James Raubenheimer on 2/14/15.
//  Copyright (c) 2015 Raubenblahblah. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreMotion/CoreMotion.h>

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    
    CMMotionManager *motionManager;
    
}

@property (readonly) CMMotionManager *motionManager;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end



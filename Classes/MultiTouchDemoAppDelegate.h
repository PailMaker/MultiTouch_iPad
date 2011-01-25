//
//  MultiTouchDemoAppDelegate.h
//  MultiTouchDemo
//
//  Created by PailMaker on 10/12/19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MultiTouchDemoViewController;
@class ExternalViewController;

@interface MultiTouchDemoAppDelegate : NSObject <UIApplicationDelegate>
{
    UIWindow *window;
    UIWindow *externalWindow;
    MultiTouchDemoViewController *viewController;
	ExternalViewController *exViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIWindow *externalWindow;
@property (nonatomic, retain) IBOutlet MultiTouchDemoViewController *viewController;
@property (nonatomic, retain) IBOutlet ExternalViewController *exViewController;

@end


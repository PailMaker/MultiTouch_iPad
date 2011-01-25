//
//  MultiTouchDemoAppDelegate.m
//  MultiTouchDemo
//
//  Created by PailMaker on 10/12/19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MultiTouchDemoAppDelegate.h"
#import "MultiTouchDemoViewController.h"
#import "ExternalViewController.h"

@implementation MultiTouchDemoAppDelegate

@synthesize window, externalWindow;
@synthesize viewController;
@synthesize exViewController;


- (void) showAlertViewForModeSelect
{
	if ([[UIScreen screens] count] > 1)
	{
		UIScreen *secondScreen = [[UIScreen screens] objectAtIndex:1];
		UIAlertView *alert = [[UIAlertView alloc]
									initWithTitle: @"Connect Sub Display"
										  message: @"Select Display Size"
										 delegate: self
							    cancelButtonTitle: nil
							    otherButtonTitles: nil];
		for (UIScreenMode *mode in [secondScreen availableModes])
		{
			[alert addButtonWithTitle:[NSString stringWithFormat:@"%d * %d",
									   (int)mode.size.width, (int)mode.size.height]];
		}
			 
		[alert addButtonWithTitle:[NSString stringWithFormat:@"Cancel"]];
		[alert show];
		[alert release];
	}
}


#pragma mark -
#pragma mark UIAlertViewDelegate

- (void) alertView: (UIAlertView *)alertView
clickedButtonAtIndex: (NSInteger)buttonIndex
{
	NSLog(@"%d", buttonIndex);
	
	if ([[UIScreen screens] count] > 1)
	{
		UIScreen *secondScreen = [[UIScreen screens] objectAtIndex:1];
		
		if (buttonIndex < [[secondScreen availableModes] count])
		{
			UIScreenMode *selectedScreenMode = [[secondScreen availableModes] objectAtIndex:buttonIndex];
			
			[secondScreen setCurrentMode:selectedScreenMode];
			
			[externalWindow setScreen:secondScreen];
			[externalWindow setFrame:CGRectMake(0, 0, selectedScreenMode.size.width, selectedScreenMode.size.height)];
			[viewController.externalView setFrame:CGRectMake(0, 0, selectedScreenMode.size.width, selectedScreenMode.size.height)];
			[externalWindow addSubview:viewController.externalView];
			[externalWindow makeKeyAndVisible];
		}
	}
	
}


#pragma mark -
#pragma mark UIScreenNotification

- (void) didUIScreenConnect : (NSNotification*)notification
{
	[self showAlertViewForModeSelect];
}

- (void) didUIScreenDisconnect : (NSNotification*)notification
{
}

- (void) didUIScreenChange : (NSNotification*)notification
{
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Override point for customization after application launch.
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(didUIScreenConnect:)
												 name:UIScreenDidConnectNotification
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(didUIScreenDisconnect:)
												 name:UIScreenDidDisconnectNotification
											   object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(didUIScreenChange:)
												 name:UIScreenModeDidChangeNotification
											   object:nil];
	
    // Add the view controller's view to the window and display.
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];

	[self showAlertViewForModeSelect];
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)dealloc
{
	[exViewController release];
    [viewController release];
    [window release];
	[externalWindow release];
    [super dealloc];
}


@end

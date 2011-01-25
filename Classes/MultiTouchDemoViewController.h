//
//  MultiTouchDemoViewController.h
//  MultiTouchDemo
//
//  Created by PailMaker on 10/12/19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExternalView : UIView
{
	NSMutableArray* _allTouches;
	NSMutableArray* _colorArray;
}
-(void)drawSubview:(NSMutableArray *)touchArray;

@end


@interface MultiTouchView : UIView
{
	NSMutableArray* _allTouches;
	NSMutableArray* _colorArray;
	ExternalView *_extView;
}

@property (nonatomic, assign) ExternalView *_extView;

@end


@interface MultiTouchDemoViewController : UIViewController
{
	MultiTouchView *multiTouchView;
	ExternalView *externalView;
}

@property (nonatomic, assign) ExternalView *externalView;

@end


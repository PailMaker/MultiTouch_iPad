//
//  MultiTouchDemoViewController.m
//  MultiTouchDemo
//
//  Created by PailMaker on 10/12/19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MultiTouchDemoViewController.h"

void DrawLine(CGContextRef context, CGFloat x1, CGFloat y1, CGFloat x2, CGFloat y2)
{
	CGContextMoveToPoint(context, x1, y1);
	CGContextAddLineToPoint(context, x2, y2);
	CGContextStrokePath(context);
}

@implementation MultiTouchView

@synthesize _extView;

-(id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self != nil)
	{
		self.multipleTouchEnabled = YES;
		self.backgroundColor = [UIColor blackColor];
		_allTouches = [[NSMutableArray array] retain];
		_colorArray = [[NSMutableArray arrayWithObjects:
					   [UIColor yellowColor],
					   [UIColor redColor],
					   [UIColor greenColor],
					   [UIColor blueColor],
					   [UIColor cyanColor],
					   [UIColor magentaColor],
					   [UIColor orangeColor],
					   [UIColor purpleColor],
					   [UIColor brownColor],
					   [UIColor whiteColor],
					   [UIColor grayColor],
					   nil] retain];
	}
	return self;
}

- (void) dealloc
{
	[_allTouches release];
	[_colorArray release];
	[super dealloc];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSArray* arr = [touches allObjects];
    for (int i = 0; i < arr.count; i++ )
	{
        [_allTouches addObject:[arr objectAtIndex:i]];
    }
    [self setNeedsDisplay];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSArray* arr = [touches allObjects];
    for (int i = 0; i < arr.count; i++ )
	{
        NSObject* object = [arr objectAtIndex:i];
        if ([_allTouches containsObject:object])
		{
            [_allTouches removeObject:object];
        }
    }
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)event
{
    [_allTouches removeAllObjects];
    [self setNeedsDisplay]; 
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 3.0);

	CGFloat R = 15.0;
	
	for (int i = 0; i < _allTouches.count; i++ )
	{
		int colorIndex = i % 11;
		
		CGPoint pos = [[_allTouches objectAtIndex:i] locationInView:self];

		[[_colorArray objectAtIndex:colorIndex] setStroke];
		DrawLine(context, 0.0, pos.y, self.bounds.size.width, pos.y);
		DrawLine(context, pos.x, 0.0, pos.x, self.bounds.size.height);

		CGRect rectEllipse = CGRectMake(pos.x - R, pos.y - R, R * 2, R * 2);
		[[_colorArray objectAtIndex:colorIndex] setFill];
		CGContextFillEllipseInRect(context, rectEllipse);
	}
	[_extView drawSubview:_allTouches];
}

@end



@implementation ExternalView


-(id) initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self != nil)
	{
		self.backgroundColor = [UIColor blackColor];
		_allTouches = [[NSMutableArray array] retain];
		_colorArray = [[NSMutableArray arrayWithObjects:
						[UIColor yellowColor],
						[UIColor redColor],
						[UIColor greenColor],
						[UIColor blueColor],
						[UIColor cyanColor],
						[UIColor magentaColor],
						[UIColor orangeColor],
						[UIColor purpleColor],
						[UIColor brownColor],
						[UIColor whiteColor],
						[UIColor grayColor],
						nil] retain];
	}
	return self;
}

- (void) dealloc
{
	[_allTouches release];
	[_colorArray release];
	[super dealloc];
}

-(void)drawSubview:(NSMutableArray *)touchArray
{
	_allTouches = touchArray;
    [self setNeedsDisplay]; 
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 3.0);
	
	CGFloat R = 15.0;
	
	for (int i = 0; i < _allTouches.count; i++ )
	{
		int colorIndex = i % 11;
		
		CGPoint pos = [[_allTouches objectAtIndex:i] locationInView:self];
		CGRect rectEllipse = CGRectMake(pos.x - R, pos.y - R, R * 2, R * 2);
		
		[[_colorArray objectAtIndex:colorIndex] setFill];
		CGContextFillEllipseInRect(context, rectEllipse);
		
		[[_colorArray objectAtIndex:colorIndex] setStroke];
		DrawLine(context, 0.0, pos.y, self.bounds.size.width, pos.y);
		DrawLine(context, pos.x, 0.0, pos.x, self.bounds.size.height);
	}
}

@end




@implementation MultiTouchDemoViewController

@synthesize externalView;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	[super loadView];
	
	externalView = [[ExternalView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];

	multiTouchView = [[MultiTouchView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
	
	multiTouchView._extView = externalView;
	self.view = multiTouchView;
	[multiTouchView release];
	
}



/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc
{
	[externalView release];
    [super dealloc];
}

@end

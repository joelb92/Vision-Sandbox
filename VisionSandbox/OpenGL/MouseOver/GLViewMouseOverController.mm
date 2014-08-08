//
//  GLViewMouseOverController.mm
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 06/17/14.
//
//

#import "GLViewMouseOverController.h"

@implementation GLViewMouseOverController
- (GLViewTool*)tool
{
	return [[currentTool retain] autorelease];
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
	{
		rulerTool = [[GLRuler alloc] init];
		protractorTool = [[GLProtractor alloc] init];
		
		currentTool = rulerTool;
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdateOutput) name:@"MouseOverToolValueChanged" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OpenSegmentationAssistant) name:@"Open Segmentation Assistant!" object:nil];
    }
    
    return self;
}
- (void)UpdateOutput
{
	if([currentTool isEqual:rulerTool])
	{
		[DistanceOutput setStringValue:[NSString stringWithFormat:@"%f",rulerTool.Distance]];
	}
	else if([currentTool isEqual:protractorTool])
	{
		[AngleOutput setStringValue:[NSString stringWithFormat:@"%f degrees",protractorTool.Angle]];
	}
}

- (void)drawRect:(NSRect)dirtyRect
{
	[[NSColor lightGrayColor] set];
	[[NSColor colorWithCalibratedRed:0.7 green:0.7 blue:0.7 alpha:0.80] set];
	[[NSBezierPath bezierPathWithRect:dirtyRect] fill];
	[[NSBezierPath bezierPathWithRect:NSInsetRect([self bounds], 1, 1)] stroke];
}
- (void)tabView:(NSTabView*)tabView didSelectTabViewItem:(NSTabViewItem*)tabViewItem
{
	
	if([tabViewItem.label isEqualToString:@"Ruler"])
	{
		currentTool = rulerTool;
	}
	else if([tabViewItem.label isEqualToString:@"Protractor"])
	{
		currentTool = protractorTool;
	}

}
- (IBAction)ResetToolHandlePositions:(id)sender
{
	if([currentTool isEqual:rulerTool])
	{
		[rulerTool ResetHandles];
	}
	else if([currentTool isEqual:protractorTool])
	{
		[protractorTool ResetHandles];
	}
}
- (bool)ActiveInView:(NSView*)view
{
	return [self.superview isEqual:view];
}
- (void)ToggleInView:(NSView*)view
{
	if([self.superview isEqual:view])
	{
		[self removeFromSuperview];
		return;
	}
	
	if(self.superview) [self removeFromSuperview];
	
	[view addSubview:self];
	[self makeViewFitParentView];
}
- (void)dealloc
{
	[rulerTool release];
	[protractorTool release];
	[[NSNotificationCenter defaultCenter] removeObserver:self forKeyPath:@"MouseOverToolValueChanged"];
	[super dealloc];
}
@end

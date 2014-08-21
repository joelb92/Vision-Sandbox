//
//  AlgorithmOutlineView.m
//  VisionSandbox
//
//  Created by Joel Brogan on 8/13/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "AlgorithmOutlineView.h"

@implementation AlgorithmOutlineView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

-(NSRect)frameOfCellAtColumn:(NSInteger)column row:(NSInteger)row
{
	id item = [self itemAtRow:row];
	//If it is a parameter view for a function, we want to give it all the room we can, so we put its super frame all the way to the right!
	if ([item isKindOfClass:FunctionVisualParametersView.class])
	{
		NSRect superFrame = [super frameOfCellAtColumn:column row:row];
		return NSMakeRect(0, superFrame.origin.y, self.frame.size.width, superFrame.size.height);
	}
	return [super frameOfCellAtColumn:column row:row];
}

-(NSInteger)levelForItem:(id)item
{
	if ([item isKindOfClass:FunctionVisualParametersView.class]) {
		return 0;
	}
	return [super levelForItem:item];
}

-(NSInteger)levelForRow:(NSInteger)row
{
	id item = [self itemAtRow:row];
	if ([item isKindOfClass:FunctionVisualParametersView.class]) {
		return 0;
	}
	return [super levelForRow:row];
}

@end

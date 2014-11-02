//
//  KernelTableCellView.m
//  VisionSandbox
//
//  Created by Joel Brogan on 9/20/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "KernelTableCellView.h"
@implementation KernelTableCellView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}
-(IBAction)openEditWindow:(id)sender
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"edited" object:self];
}
- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

@end

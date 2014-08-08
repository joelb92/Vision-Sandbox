//
//  GLViewTool.mm
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 4/1/13.
//
//

#import "GLViewTool.h"

@implementation GLViewTool
@synthesize dragging;

- (id)init
{
	self = [super init];
	if(self)
	{
		mousePos = Vector2(NAN,NAN);
		startMousePos = Vector2(NAN,NAN);
		dragging = false;
	}
	return self;
}

-(void)GraphUsingSpaceConverter:(SpaceConverter)spaceConverter
{
	
}
- (void)SetMousePosition:(Vector2)mouseP UsingSpaceConverter:(SpaceConverter)spaceConverter
{
	previousMousePos = mousePos;
	mousePos = mouseP;
}
- (void)DragTo:(Vector3)point
{
	
}

- (bool)StartDragging:(bool)withShift
{
	dragging = true;
	startMousePos = mousePos;
	shiftHeld = withShift;
	return true;
}
- (void)StopDragging
{
	dragging = false;
	stopMousePos = mousePos;
}
@end

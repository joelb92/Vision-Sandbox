//
//  GLViewTool.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 4/1/13.
//
//

#import "GLObject.h"

@interface GLViewTool : GLObject
{
	Vector2 mousePos;
	Vector2 previousMousePos;
	Vector2 startMousePos;
	Vector2 stopMousePos;
	bool dragging;
	bool shiftHeld;
}
@property (readonly) bool dragging;
@property (readonly) bool shiftHeld;

- (void)DragTo:(Vector3)point;
- (void)SetMousePosition:(Vector2)mouseP UsingSpaceConverter:(SpaceConverter)spaceConverter;
- (bool)StartDragging:(bool)withShift;
- (void)StopDragging;
@end

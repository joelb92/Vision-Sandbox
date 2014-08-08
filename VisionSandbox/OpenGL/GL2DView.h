//
//  GLView.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 1/25/13.
//
//

#import <Cocoa/Cocoa.h>
#import "GLView.h"

typedef struct
{
	BOOL zoomIn;
	BOOL zoomOut;
	
	BOOL left;
	BOOL right;
	BOOL top;
	BOOL bottom;
	float speed;
} iMovement;

@interface GL2DView : GLView
{
	iMovement imageMovement;
	float Magnification;
	
	Vector2 startMousePos;
	Vector2 startImagePos;
	
	int FlasherDirection;
	float FlasherCyclesPerSecond;
	NSDate*FlasherDate;
}
- (void)setMaxImageSpaceRect:(vector2Rect)maxImageSpaceRect;

//////////////////////////////////////////////////////////////////////////////////////////////////
//																								//
//																								//
//									    Event Handling											//
//																								//
//																								//
//////////////////////////////////////////////////////////////////////////////////////////////////
- (void)UpdateFlasherValue;

- (void)mouseDown:(NSEvent*)event;
- (void)mouseMoved:(NSEvent*)event;
- (void)mouseDragged:(NSEvent*)event;
- (void)mouseUp:(NSEvent*)event;

- (void)scrollWheel:(NSEvent*)event;

//Pinch Gesture:
- (void)magnifyWithEvent:(NSEvent*)event;

- (void)keyDown:(NSEvent*)event;
- (void)keyUp:(NSEvent*)event;

- (void)move;

//Ensure that the user doesn't zoom, or scroll off of the image (or zoom to some insaine point where you can't see any thing):
- (void)ClampImageToScreen;
@end
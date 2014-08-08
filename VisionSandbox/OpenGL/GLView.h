//
//  GLView.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 3/21/13.
//
//

#import <Cocoa/Cocoa.h>
#import "GLObjectList.h"
#import "GLViewTool.h"
#import "GLUT/glut.h"
#import "Ray3.h"
#import "GLViewMouseOverController.h"

@interface GLView : NSOpenGLView 
{
	bool Enabled;
	SpaceConverter spaceConverter;
	GLObjectList*objectList;
	
	bool mouseDragged;
	bool MustReshape;
	
	IBOutlet GLViewMouseOverController*mouseOverController;
	Vector2 previousMouseLocation;
	NSTrackingArea*trackingArea;
	
	Vector2 mousePosition;
	Vector2 previousMousePosition;
	
	NSColor*backgroundColor;
}
@property (readwrite) bool Enabled;
@property (retain) GLObjectList*objectList;
@property (assign) NSColor *backgroundColor;
- (void)SaveObjectList;
//////////////////////////////////////////////////////////////////////////////////////////////////
//																								//
//																								//
//									Main Drawing Methodes										//
//																								//
//																								//
//////////////////////////////////////////////////////////////////////////////////////////////////

- (void)Draw;
- (void)drawRect:(NSRect)dirtyRect;

- (NSImage*)imageFromOpenGLView;
- (void)SaveRenderToPath:(NSString*)Path;

//////////////////////////////////////////////////////////////////////////////////////////////////
//																								//
//																								//
//									    Event Handling											//
//																								//
//																								//
//////////////////////////////////////////////////////////////////////////////////////////////////

- (void)mouseDown:(NSEvent*)event;
- (void)mouseUp:(NSEvent*)event;

//Setters:
- (void)setSmoothing:(bool)state;

//Reset all the viewing values:
- (void)Reset;

//Clear Content From View:
- (void)Clear;

- (void)ZoomIn;
- (void)ZoomOut;
@end
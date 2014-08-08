//
//  GL3DGeometryDrawer.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 3/22/13.
//
//

#import "GLObject.h"
#import "colorArr.h"
#import "floatArr.h"
#import "Vector3Arr.h"
#import "PlaneArr.h"
#import "Ray3Arr.h"
#import "LineSegment3Arr.h"
#import "intArr.h"

@interface GL3DGeometryDrawer : GLObject
{
	Color previousColor;
	
	colorArr*pointColors;
	//floatArr*pointSizes;
	Vector3Arr points;
	
	colorArr*rayColors;
	//floatArr*rayWidths;
	Ray3Arr*rays;
	
	colorArr*segColors;
	//floatArr*rayWidths;
	LineSegment3Arr segs;
	
	colorArr*planeColors;
	//floatArr*rayWidths;
	PlaneArr*planes;
	
	colorArr*sphereColors;
	//floatArr*rayWidths;
}
- (id)initWithCapacity:(int)capacity;

- (void)AddPoint:(Vector3)point WithColor:(Color)col;
- (void)AddPoints:(Vector3Arr)ps WithColor:(Color)col;
- (void)AddRay:(Ray3)ray WithColor:(Color)col;
- (void)AddLineSegment:(LineSegment3)seg WithColor:(Color)col;
- (void)AddPlane:(Plane)plane WithColor:(Color)col;
@end

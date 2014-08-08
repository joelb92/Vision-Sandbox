//
//  GLRuler.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 06/17/14.
//
//

#import "GLViewTool.h"
#import "Vector2Arr.h"
#import "Vector3Arr.h"
#import "Plane.h"

@interface GLRuler : GLViewTool
{
	Vector3Arr points;
	
	int draggedIndex;
	int mousedOverIndex;
	
	bool initialized;
}

- (float)Distance;
- (void)ResetHandles;
@end

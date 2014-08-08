//
//  GLProtractor.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 06/17/14.
//
//

#import "GLViewTool.h"
#import "Vector3Arr.h"

@interface GLProtractor : GLViewTool
{
	Vector3Arr points;
	
	int draggedIndex;
	int mousedOverIndex;
	
	bool initialized;
}

- (float)Angle;
- (void)ResetHandles;
@end

//
//  GLObjectList.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 1/31/13.
//
//

#import <Foundation/Foundation.h>
#import "Vector3Arr.h"
#import "GLObject.h"
#import "TreeList.h"
#import "idArr.h"

@interface GLObjectList : TreeList
{
	idArr*releaseArr;
}
- (void)releaseDeallocedObjects;

- (Vector3)MouseOverPointAtScreenPoint:(Vector2)screenPoint UsingSpaceConverter:(SpaceConverter)spaceConverter;
- (void)MouseOverInfoAtScreenPoint:(Vector2)screenPoint UsingSpaceConverter:(SpaceConverter)spaceConverter;
- (void)GraphUsingSpaceConverter:(SpaceConverter)spaceConverter;
@end

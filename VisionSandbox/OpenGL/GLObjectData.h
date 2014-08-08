//
//  GLObjectData.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 5/3/13.
//
//

#import <Foundation/Foundation.h>
#import "DisplayListArr.h"

@interface GLObjectData : NSObject
{
	DisplayList*mainDisplayList;
	DisplayListArr*displayLists;
	
	bool ObjectChanged;
	bool DisplayListBeingCreated;
	
	bool mainListMustReCompile;
	bool AppendingExistingDisplayList;
	
	//For Images
	GLuint gl;
	bool glSet;
}
- (void)ClearDisplayList;

@property (readwrite) DisplayList*mainDisplayList;
@property (retain) DisplayListArr*displayLists;
@property (readwrite) bool ObjectChanged;
@property (readwrite) bool DisplayListBeingCreated;

@property (readwrite) bool mainListMustReCompile;
@property (readwrite) bool AppendingExistingDisplayList;

@property (readwrite) GLuint gl;
@property (readwrite) GLuint*glAddress;
@property (readwrite) bool glSet;

- (void)deallocImage;
@end

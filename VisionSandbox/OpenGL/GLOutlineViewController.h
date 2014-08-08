//
//  GLOutlineViewController.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 7/23/13.
//
//

#import <Cocoa/Cocoa.h>
#import "GLViewList.h"
#import "OpenImageHandler.h"
@interface GLOutlineViewController : NSOutlineView
{
	GLViewList*viewList;
	BOOL ShouldReloadData;
//	BOOL mouseWasDragged;
}
@property (readwrite, atomic) BOOL ShouldReloadData;

- (GLViewList*)viewList;
- (void)setViewList:(GLViewList*)vL;
@end

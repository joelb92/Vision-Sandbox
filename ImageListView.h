//
//  ImageListView.h
//  VisionSandbox
//
//  Created by Joel Brogan on 8/8/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "GLOutlineViewController.h"
#import "GL2DView.h"

@interface ImageListView : NSView
{
	GLOutlineViewController *mainGLOutlineView;
	GL2DView *mainGLView;
	NSString *name;
}
@end

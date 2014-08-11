//
//  AppDelegate.h
//  VisionSandbox
//
//  Created by Joel Brogan on 8/6/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#include "opencv2/opencv.hpp"
#import <Cocoa/Cocoa.h>
#import "GLOutlineViewController.h"
#import "GL2DView.h"
#import "FunctionTreeViewController.h"
@interface AppDelegate : NSObject <NSApplicationDelegate>
{
	IBOutlet GLOutlineViewController *mainGLOutlineView;
	IBOutlet GL2DView *mainGLView;
	IBOutlet FunctionTreeViewController *functionListController;
}
@property (assign) IBOutlet NSWindow *window;

@end

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
#import "AlgorithmTreeViewController.h"
#import "PluginManager.h"
#import "Function.h"
#import "Threshold.h"
#import "Dilate.h"
#import "PropertyUtility.h"
@interface AppDelegate : NSObject <NSApplicationDelegate>
{
	IBOutlet GLOutlineViewController *mainGLOutlineView;
	IBOutlet GL2DView *mainGLView;
	GLViewList *viewList;
	IBOutlet FunctionTreeViewController *functionListController;
	IBOutlet AlgorithmTreeViewController *AlgorithmListController;
	IBOutlet NSOutlineView *FunctionListView;
	IBOutlet NSOutlineView *AlgorithmListView;
	IBOutlet NSTextField *initialInputPath;
	OpenImageHandler *loadedImg;
}
@property (assign) IBOutlet NSWindow *window;

@end

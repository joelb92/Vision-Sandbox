//
//  AppDelegate.m
//  VisionSandbox
//
//  Created by Joel Brogan on 8/6/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "AppDelegate.h"
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	GLViewList*viewList = [[GLViewList alloc] initWithBackupPath:@"/Users/joel/Documents/Programming/VisionSandbox/Settings/View List Backup.vis"];
	mainGLView.objectList = [[[GLObjectList alloc] initWithBackupPath:@"/Users/joel/Documents/Programming/VisionSandbox/Settings/Main View List Backup.vis"] autorelease];
	[viewList AddObject:mainGLView ForKeyPath:@"MainView"];
	mainGLOutlineView.viewList = viewList;
//	[GLViewListCommand SetViewKeyPath:@"MainView" MaxImageSpaceRect:vector2Rect(0, 0, 400, 400)];
//	FunctionTreeItem *item = [[FunctionTreeItem alloc] initWithKey:@"Test" Object:nil];
////	[functionListController addItem:item toPath:@"/Test1/Test2/Test3"];
	[[PluginManager sharedManager] addFunctionClassType:Function.class];
	[functionListController addFunctions:[[PluginManager sharedManager] FunctionObjects]];
	
	Algorithm *testAlgorithm = [[Algorithm alloc] init];
	testAlgorithm.functionName = @"Test Algorithm 1";
	[testAlgorithm addFunctions:[[PluginManager sharedManager] FunctionObjects]];
	[AlgorithmListController setAlgorithm:testAlgorithm];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runCurrentAlgorithm:) name:@"Setting Changed" object:nil];
}

-(IBAction)addToAlgorithmView:(id)sender
{
	id itemObjToAdd = [(FunctionTreeItem *)functionListController.selectedItem object];
	if ([itemObjToAdd isKindOfClass:Function.class]) {
		[AlgorithmListController addFunction:[(Function *)itemObjToAdd copy]];
	}
	NSLog(@"done");
}
- (IBAction)removeFromAlgorithmView:(id)sender
{
	
}
- (IBAction)runCurrentAlgorithm:(id)sender {
	NSString *runPath = initialInputPath.stringValue;
	if (!loadedImg) {
		loadedImg =[[OpenImageHandler alloc] initWithCVMat:cv::imread("/Users/joel/Desktop/9khibZX.jpg",0) Color:White BinaryImage:false];
		[GLViewListCommand AddObject:loadedImg ToViewKeyPath:@"MainView" ForKeyPath:@"First"];
//		[GLViewListCommand SetViewKeyPath:@"MainView" MaxImageSpaceRect:vector2Rect(Vector2(0,0), Vector2(loadedImg.size.width,loadedImg.size.height))];
	}
	[AlgorithmListController.Algorithm runMethod:loadedImg];
}

@end

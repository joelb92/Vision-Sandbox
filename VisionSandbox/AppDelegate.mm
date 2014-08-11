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
	[GLViewListCommand SetViewKeyPath:@"MainView" MaxImageSpaceRect:vector2Rect(0, 0, 400, 400)];
	OpenImageHandler * h = [[OpenImageHandler alloc] initWithCVMat:cv::Mat(400,400,CV_8UC3,cv::Scalar(0,255,0)) Color:White BinaryImage:false];
	[GLViewListCommand AddObject:h ToViewKeyPath:@"MainView" ForKeyPath:@"TestThing"];
	[mainGLOutlineView reloadData];
	FunctionTreeItem *item = [[FunctionTreeItem alloc] initWithKey:@"Test" Object:nil];
	[functionListController addItem:item toPath:@"/Test1/Test2/Test3"];
}


@end

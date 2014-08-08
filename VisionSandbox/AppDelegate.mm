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
	GLViewList*viewList = [[GLViewList alloc] initWithBackupPath:@"/Users/Shared/DIF Mapper/Settings/View List Settings/View List Backup.DIFmd"];
	mainGLView.objectList = [[[GLObjectList alloc] initWithBackupPath:@"/Users/Shared/DIF Mapper/Settings/View List Settings/Main View List Backup.DIFmd"] autorelease];
	[viewList AddObject:mainGLView ForKeyPath:@"MainView"];
	mainGLOutlineView.viewList = viewList;

}

@end

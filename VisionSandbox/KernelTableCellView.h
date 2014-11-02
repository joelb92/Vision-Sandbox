//
//  KernelTableCellView.h
//  VisionSandbox
//
//  Created by Joel Brogan on 9/20/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class KernelEditorController;
#import "KernelEditorController.h"
@interface KernelTableCellView : NSTableCellView
{
	IBOutlet NSImageView *imgView;
	IBOutlet NSButton *editButton;
	IBOutlet KernelEditorController *editor;
}
@property NSImageView *imgView;
@property NSButton *editButton;
@end

//
//  KernelSelectorController.h
//  VisionSandbox
//
//  Created by Joel Brogan on 9/21/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditableConvolutionKernel.h"
#import "KernelTableCellView.h"
#import "NSImage+OpenCV.h"
@interface KernelSelectorController : NSObject <NSTableViewDataSource,NSTableViewDelegate>
{
	IBOutlet NSTableView *kernelListTableView;
	IBOutlet NSWindow *window;
	NSMutableDictionary *kernelDictonary;
	NSMutableArray *orderedKernelKeys;
	int newCount;
}
@end

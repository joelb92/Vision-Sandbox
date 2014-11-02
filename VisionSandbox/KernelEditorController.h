//
//  KernelEditorController.h
//  VisionSandbox
//
//  Created by Joel Brogan on 9/19/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "Function.h"
#import "NSImage+OpenCV.h"
#import "EditableConvolutionKernel.h"
@interface KernelEditorController : NSObject <NSTableViewDataSource,NSTableViewDelegate>
{

	IBOutlet NSWindow *kernelEditorWindow;
	IBOutlet NSSlider *xSlider;
	IBOutlet NSSlider *ySlider;
	IBOutlet NSMatrix *radioSelection;
	IBOutlet NSCell *EllipseSelection;
	IBOutlet NSCell *RectangleSelection;
	IBOutlet NSCell *CrossSelection;
	IBOutlet NSImageView *imgView;
	IBOutlet NSButton *resizeCheckBox;
	IBOutlet NSButton *keepSquareCheckBox;
	IBOutlet NSButton *isBlackCheckBox;
	IBOutlet NSTextField *kernelNameLabel;
	IBOutlet NSTableView *kernelTableView;
	NSDictionary *morphTypeMap;
	int selectedElementIndex;
	EditableConvolutionKernel *currentConvKernel;
	bool shouldResize;
	cv::Size kernelPreviewFrameSize;
	
	cv::Mat currentKernel,currentKernelResized;
}
@property NSWindow *window;

@end

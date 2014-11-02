//
//  KernelEditorController.m
//  VisionSandbox
//
//  Created by Joel Brogan on 9/19/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "KernelEditorController.h"

@implementation KernelEditorController
@synthesize window;
-(id)init
{
	self = [super init];
	if (self) {
		currentKernel = cv::getStructuringElement(cv::MORPH_ELLIPSE, cv::Size(1,1));
		cv::resize(currentKernel, currentKernelResized, cv::Size(360,360));
		currentConvKernel = [[EditableConvolutionKernel alloc] initWithName:@"Test"];
		[currentConvKernel addElement];
		[currentConvKernel setElementValues:0 width:10 height:10 isBlack:false morphType:cv::MORPH_ELLIPSE];
		selectedElementIndex = 0;
	}
	return self;
}
-(void)awakeFromNib
{
	kernelPreviewFrameSize = cv::Size(imgView.frame.size.width,imgView.frame.size.height);
	shouldResize = resizeCheckBox.state == NSOnState;
	morphTypeMap = @{@(cv::MORPH_ELLIPSE): EllipseSelection,@(cv::MORPH_RECT):RectangleSelection,@(cv::MORPH_CROSS):CrossSelection};
	kernelNameLabel.stringValue = currentConvKernel.name;
	[self updateDisplay];
}
-(void)setCurrentConvKernel:(EditableConvolutionKernel *)k
{
	k.currentSelectedEl = 0;
	currentConvKernel = k;
	KernelElement el = currentConvKernel.elements[currentConvKernel.currentSelectedEl];
	xSlider.intValue = el.width;
	ySlider.intValue = el.height;
	isBlackCheckBox.state = el.isBlack;
	[radioSelection selectCell:[morphTypeMap objectForKey:@(el.morph_type)]];
	kernelNameLabel.stringValue = currentConvKernel.name;
}
- (IBAction)addElement:(id)sender
{
	[currentConvKernel addElement];
	[kernelTableView reloadData];
	[self updateDisplay];
}
- (IBAction)removeElement:(id)sender
{
	if (kernelTableView.selectedRow >= 0) {
		[currentConvKernel removeElementAtIndex:(int)[kernelTableView selectedRow]];
		if (selectedElementIndex >= currentConvKernel.elements.size())
		{
			selectedElementIndex = (int)currentConvKernel.elements.size()-1;
		}
		[kernelTableView reloadData];
		NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:selectedElementIndex];
		[kernelTableView selectRowIndexes:indexSet byExtendingSelection:NO];
		[self updateDisplay];
	}
	
}

- (IBAction)lockDimensionsChanged:(id)sender {
	[self sizeChanged:xSlider];
}
- (IBAction)resizeFlagChanged:(id)sender {
	if ([(NSButton *)sender state] == NSOnState) {
		shouldResize = true;
	}
	else shouldResize = false;
	[self updateDisplay];
}
- (IBAction)isBlackChanged:(id)sender {
	[currentConvKernel setElementIsBlack:isBlackCheckBox.state];
	[self updateDisplay];
}
- (IBAction)morphTypeChanged:(id)sender
{
	int i = (int)[morphTypeMap.allValues indexOfObject:[radioSelection selectedCell]];
	[currentConvKernel setElementType:[[morphTypeMap.allKeys objectAtIndex:i] intValue]];
	[self updateDisplay];
}

-(void)updateDisplay
{
	currentKernel = currentConvKernel.kernel;
	currentKernel = currentKernel*255;
	if (shouldResize) {
//		currentKernelResized = currentKernel;
		CvMat m1,m2;
		m1 = currentKernel;
		m2 = currentKernelResized;
		cvResize(&m1, &m2,CV_INTER_NN);
	}
	else{
		
		int addHeight = kernelPreviewFrameSize.height-currentKernel.rows;
		int addWidth = kernelPreviewFrameSize.width-currentKernel.cols;
		int top = addHeight/2;
		int bottom = addHeight/2;
		if (addHeight%2 != 0) bottom++;
		int left = addWidth/2;
		int right = addWidth/2;
		if (addWidth%2 != 0 ) right++;
		cv::copyMakeBorder(currentKernel, currentKernelResized, top, bottom, left, right, cv::BORDER_CONSTANT,0);
	}
	[imgView setImage:[[NSImage alloc] initWithCVMat:currentKernelResized]];
	[imgView setNeedsDisplay:YES];
	[imgView display];
}

- (IBAction)sizeChanged:(id)sender {
	if (sender == xSlider) {
		if (keepSquareCheckBox.state == NSOnState) {
			ySlider.floatValue = xSlider.floatValue;
		}
		if (!xSlider.intValue%2) {
		}
	}
	if (sender == ySlider) {
		if (keepSquareCheckBox.state == NSOnState) {
			xSlider.floatValue = ySlider.floatValue;
		}
		if (!ySlider.intValue%2) {
		}
	}
	[currentConvKernel setElementWidth:xSlider.intValue];
	[currentConvKernel setElementHeight:ySlider.intValue];
	[self updateDisplay];

	[kernelTableView reloadData];
	NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:selectedElementIndex];
	[kernelTableView selectRowIndexes:indexSet byExtendingSelection:NO];
}

//Data Source Methods
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
	if (currentConvKernel) {
		return currentConvKernel.elements.size();
	}
	return 0;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
	
    // Get an existing cell with the MyView identifier if it exists
    NSTextField *result = [tableView makeViewWithIdentifier:@"TextCell" owner:self];
	
    // There is no existing cell to reuse so create a new one
    if (result == nil) {
		
		// Create the new NSTextField with a frame of the {0,0} with the width of the table.
		// Note that the height of the frame is not really relevant, because the row height will modify the height.
		result = [[NSTextField alloc] init];
		
		// The identifier of the NSTextField instance is set to MyView.
		// This allows the cell to be reused.
		result.identifier = @"MyView";
	}
	
	// result is now guaranteed to be valid, either as a reused cell
	// or as a new cell, so set the stringValue of the cell to the
	// nameArray value at row
	if ([tableColumn.identifier isEqualToString:@"Name"]) {
		((NSTableCellView *)result).textField.stringValue = currentConvKernel.elements[row].name;
	}
	else
	{
		((NSTableCellView *)result).textField.stringValue = [NSString stringWithFormat:@"%i x %i", currentConvKernel.elements[row].width,currentConvKernel.elements[row].height];
	}
	
	// Return the result
	return result;
	
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
	if ([kernelTableView selectedRow] >= 0)
	{
		selectedElementIndex = (int)[kernelTableView selectedRow];
		currentConvKernel.currentSelectedEl = kernelTableView.selectedRow;
		KernelElement el = currentConvKernel.elements[[kernelTableView selectedRow]];
		[isBlackCheckBox setState:el.isBlack];
		[radioSelection selectCell:[morphTypeMap objectForKey:@(el.morph_type)]];
		xSlider.intValue = el.width;
		ySlider.intValue = el.height;
	}
	else
	{
		NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:selectedElementIndex];
		[kernelTableView selectRowIndexes:indexSet byExtendingSelection:NO];
	}
	[self updateDisplay];
	
}

@end

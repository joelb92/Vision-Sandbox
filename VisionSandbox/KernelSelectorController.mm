//
//  KernelSelectorController.m
//  VisionSandbox
//
//  Created by Joel Brogan on 9/21/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "KernelSelectorController.h"

@implementation KernelSelectorController

-(id)init
{
	self = [super init];
	if (self) {
		kernelDictonary = [[NSMutableDictionary alloc] init];
		orderedKernelKeys = [[NSMutableArray alloc] init];
	}
	return self;
}
- (IBAction)addNewKernel:(id)sender
{
	NSString *name = [self getDefaultName];
	EditableConvolutionKernel *newKernel = [[EditableConvolutionKernel alloc] initWithName:name];
	[kernelDictonary setObject:newKernel forKey:name];
	[orderedKernelKeys addObject:name];
	[kernelListTableView reloadData];
	NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:kernelDictonary.count-1];
	[kernelListTableView selectRowIndexes:indexSet byExtendingSelection:NO];
}
- (IBAction)removeKernel:(id)sender
{
	if ([kernelListTableView selectedRow] >= 0) {
		EditableConvolutionKernel *ker = [kernelDictonary objectForKey:[orderedKernelKeys objectAtIndex:kernelListTableView.selectedRow]];
		[orderedKernelKeys removeObjectAtIndex:kernelListTableView.selectedRow];
		[kernelDictonary removeObjectForKey:ker.name];
		[kernelListTableView reloadData];
		if (orderedKernelKeys.count > 0) {
			NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:kernelDictonary.count-1];
			[kernelListTableView selectRowIndexes:indexSet byExtendingSelection:NO];
		}
	}
}

-(NSString *)getDefaultName
{
	int count = 1;
	while(count < 1000)
	{
		NSString *s =[ NSString stringWithFormat:@"Kernel %i",count];
		if (![kernelDictonary.allKeys containsObject:s]) return s;
		count++;

	}
	return @"DefaultKernel";
	
}

//Data Source Methods
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
		return orderedKernelKeys.count;
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
	
    // Get an existing cell with the MyView identifier if it exists
	EditableConvolutionKernel *ker = [kernelDictonary objectForKey:[orderedKernelKeys objectAtIndex:row]];
	if ([tableColumn.identifier isEqualToString:@"Name"]) {
		 NSTextField *result = [tableView makeViewWithIdentifier:@"TextCell" owner:self];
		((NSTableCellView *)result).textField.stringValue = ker.name;
		return result;
	}
	else
	{
		NSTextField *result = [tableView makeViewWithIdentifier:@"ImageCell" owner:self];

		KernelTableCellView *view = (KernelTableCellView *)result;
		CvMat kernelImage = ker.kernel;
		CvMat resizedImage = cv::Mat(view.imgView.frame.size.width,view.imgView.frame.size.height,CV_8UC1);
		cvResize(&kernelImage, &resizedImage,CV_INTER_NN);
		[view.imgView setImage:[[NSImage alloc] initWithCVMat:cv::Mat(&resizedImage)]];
		[view.imgView setNeedsDisplay:YES];
		[view.imgView display];
		return result;
	}
	
}

-(void)tableViewSelectionDidChange:(NSNotification *)notification
{
	
}


@end

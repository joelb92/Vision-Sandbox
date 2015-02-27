//
//  AlgorithmTreeViewController.m
//  VisionSandbox
//
//  Created by Joel Brogan on 8/11/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "AlgorithmTreeViewController.h"

@implementation AlgorithmTreeViewController
-(id)init
{
	self = [super init];
	if (self) {
		TreeData = [[Algorithm alloc] init];
		Algorithm *inner=[[Algorithm alloc] init];
		inner.functionName = @"Untitled";
		[TreeData addFunction:inner];
	}
	return self;
}
-(Function *)FunctionAtIndex:(int)index
{
	return [TreeData FunctionAtIndex:index];
}
-(void)addFunction:(Function *)function
{
	[self.Algorithm addFunction:function];
	[listView reloadData];
}
-(void)insertFunction:(Function *)function atIndex:(int)index
{
	[TreeData insertFunction:function atIndex:index];
	[listView reloadData];
}
-(void)replaceFunctionAtIndex:(int)index withFunction:(Function *)function
{
	[TreeData replaceFunctionAtIndex:index withFunction:function];
	[listView reloadData];
}
-(void)removeFunctionAtIndex:(int)index
{
	[TreeData removeFunctionAtIndex:index];
	[listView reloadData];
}
-(void)removeFunction:(Function *)func
{
	[TreeData removeFunction:func];
	[listView reloadData];
}
-(Algorithm *)Algorithm
{
	return (Algorithm *)[TreeData FunctionAtIndex:0];
}
-(void)setAlgorithm:(Algorithm *)al
{
	if (TreeData.count >0) {
		[TreeData replaceFunctionAtIndex:0 withFunction:al];
	}
	else{
		[TreeData addFunction:al];
	}
	[listView reloadData];
}

-(IBAction)save:(id)sender
{
	[NSKeyedArchiver archiveRootObject:[self Algorithm] toFile:[NSString stringWithFormat:@"/Users/joel/Documents/VisionSettings/Algorithms/%@.alg",self.Algorithm.functionName]];
}
//Data Source Methods
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
	if (item == nil)
	{ //item is nil when the outline view wants to inquire for root level items
        return TreeData.count;
    }
	else if([item isKindOfClass:Algorithm.class])
	{
		return [(Algorithm *)item count];
	}
	else if([item isKindOfClass:Function.class] && [(Function *)item hasSettingsWindow])
	{
		return 1;
	}
	else return 0;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    return [item isKindOfClass:Algorithm.class] || ([item isKindOfClass:Function.class] && [(Function *)item hasSettingsWindow]);
}


- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
	if (item == nil) { //item is nil when the outline view wants to inquire for root level items
        return [TreeData FunctionAtIndex:(int)index];
    }
	else if ([item isKindOfClass:Algorithm.class]) {
		Algorithm *root = (Algorithm *)item;
		if (index < root.count) {
			return [root FunctionAtIndex:(int)index];
		}
	}
	else if([item isKindOfClass:Function.class] && [(Function *)item hasSettingsWindow])
	{
		return [(Function *)item parametersView];
	}
    return nil;
}

- (NSTableRowView*)outlineView:(NSOutlineView *)outlineView rowViewForItem:(id)item
{
	NSTableRowView*rowView = [[NSTableRowView alloc] init];
	//	FunctionTreeItem*Item = item;
	//	if(Item == nil) Item = TreeData;
	//	if(Item.object)
	//	{
	//		id object = Item.object;
	//		if(object)
	//		{
	[rowView setBackgroundColor:[NSColor colorWithCalibratedRed:0 green:0 blue:1 alpha:1]];
	//		}
	//	}
	return rowView;
}

- (CGFloat)outlineView:(NSOutlineView*)outlineView heightOfRowByItem:(id)item
{
	Function*Item = item;
	if(Item == nil) Item = TreeData;
	
	CGFloat height = 17;
	if([Item isKindOfClass:Algorithm.class])
	{
		height = 25;
	}
	if ([item isKindOfClass:FunctionVisualParametersView.class]) {
		height = [(FunctionVisualParametersView *)item frame].size.height;
	}
	return height;
}
//- (NSInteger)levelForItem:(id)item
//{
//	
//}

//Delegate Methods

- (NSView*)outlineView:(NSOutlineView*)outlineView viewForTableColumn:(NSTableColumn*)tableColumn item:(id)item
{
	// Everything is setup in bindings
	SingleViewCellView*view = nil;
	Function *Item = (Function *)item;
	if([item isKindOfClass:Algorithm.class])
	{
		view = [outlineView makeViewWithIdentifier:@"AlgorithmCell" owner:self];
	}
	else if([item isKindOfClass:FunctionVisualParametersView.class])
	{
		view = item;
		return view;
	}
	else
	{
		view = [outlineView makeViewWithIdentifier:@"FunctionCell" owner:self];
	}
	[view.textField setStringValue:Item.functionName];
	return view;
}

//Drag and drop methods


- (void)outlineView:(NSOutlineView*)outlineView draggingSession:(NSDraggingSession*)session willBeginAtPoint:(NSPoint)screenPoint forItems:(NSArray*)draggedItems
{
}
- (id <NSPasteboardWriting>)outlineView:(NSOutlineView *)outlineView pasteboardWriterForItem:(id)item{
    // No dragging if <some condition isn't met>
    BOOL dragAllowed = [item isKindOfClass:Function.class] && ![item isEqualTo:TreeData];
    if (!dragAllowed)  {
        return nil;
    }
	Function *otherItem = (Function *)item;
    NSData *itemData = [NSKeyedArchiver archivedDataWithRootObject:otherItem];
    
    NSPasteboardItem *pboardItem = [[NSPasteboardItem alloc] init];
	draggedFunction = item;
    [pboardItem setData:itemData forType: @"Function.func"];
	internalDrag = true;
    return pboardItem;
}


- (NSDragOperation)outlineView:(NSOutlineView *)outlineView validateDrop:(id < NSDraggingInfo >)info proposedItem:(id)targetItem proposedChildIndex:(NSInteger)index{
    
    BOOL canDrag = index >= 0 && targetItem;
	
    if (canDrag && [targetItem isKindOfClass:Algorithm.class] && ![draggedFunction isEqual:targetItem]) {
        return NSDragOperationMove;
    }else {
        return NSDragOperationNone;
    }
}


- (BOOL)outlineView:(NSOutlineView *)outlineView acceptDrop:(id < NSDraggingInfo >)info item:(id)targetItem childIndex:(NSInteger)index{
	
    NSPasteboard *p = [info draggingPasteboard];
    NSData *data = [p dataForType:@"Function.func"];
	Function *item = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	if ([targetItem isKindOfClass:Algorithm.class]) {
		Algorithm *targetAlg = targetItem;
		int indexOfItemDragged = [targetAlg indexForFunction:draggedFunction];
		int newIndex = index;
		if (internalDrag) {
			[targetAlg removeFunctionAtIndex:indexOfItemDragged];
			if(indexOfItemDragged < index) //
			{
				newIndex--;
			}
		}
				[targetAlg insertFunction:item atIndex:newIndex];
		
		[outlineView reloadData];
	}
    internalDrag = false;
    
	return YES;
}


@end

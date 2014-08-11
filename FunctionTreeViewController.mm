//
//  FunctionTreeViewController.m
//  VisionSandbox
//
//  Created by Joel Brogan on 8/10/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "FunctionTreeViewController.h"

@implementation FunctionTreeItem
@synthesize key,children,childrenOrderedKeys,object,isHeader;
-(id)init
{
	self = [super init];
	if (self)
	{
		key = @"Root";
		object = nil;
		isHeader = false;
		childrenOrderedKeys = [NSMutableArray array];
		children = [NSMutableDictionary dictionary];
	}
	return self;
}
-(id)initWithKey:(NSString *)k Object:(id)obj
{
	self = [super init];
	if (self)
	{
		key = k;
		object = obj;
		children = [[NSMutableDictionary alloc] init];
		childrenOrderedKeys = [[NSMutableArray alloc] init];
	}
	return self;
}
-(id)initWithKey:(NSString *)k Object:(id)obj Children:(NSMutableDictionary *)childs
{
	if (!children) return [self initWithKey:k Object:obj];
	self = [super init];
	if (self)
	{
		key = k;
		object = obj;
		children = childs;
		childrenOrderedKeys = [[children allKeys] mutableCopy];
		[self orderKeys];
	}
	return self;
}
-(void)addChild:(FunctionTreeItem *)child
{
	[children setObject:child forKey:child.key];
	[childrenOrderedKeys addObject:child.key];
	[self orderKeys];
}
-(void)orderKeys
{
	[childrenOrderedKeys sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}
@end

@implementation FunctionTreeViewController
-(id)init
{
	self = [super init];
	if (self) {
		TreeData = [[FunctionTreeItem alloc] init];
	}
	return self;
}

-(void)addItem:(FunctionTreeItem *)item toPath:(NSString *)path
{
	NSArray *components = [path componentsSeparatedByString:@"/"];
	FunctionTreeItem *lastItem = TreeData;
	for(int i = 0; i < components.count; i++)
	{
		NSString *component = [components objectAtIndex:i];
		if (component.length > 0) {
			FunctionTreeItem *nextItem = [lastItem.children objectForKey:component];
			if (!nextItem) {
				FunctionTreeItem *newItem = [[FunctionTreeItem alloc] initWithKey:component Object:nil];
				if (i == 1)newItem.isHeader = true;
				[lastItem addChild:newItem];
				nextItem = [lastItem.children objectForKey:component];
			}
			lastItem = nextItem;
		}
		
	}
	[lastItem addChild:item];
	[listView reloadData];
	
}

//Data Source Methods
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
	if (item == nil) { //item is nil when the outline view wants to inquire for root level items
        return TreeData.children.count;
    }
	return [[(FunctionTreeItem *)item children] count];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    return [[(FunctionTreeItem *)item children] count] > 0;
}


- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
	if (item == nil) { //item is nil when the outline view wants to inquire for root level items
        return [TreeData.children objectForKey:[TreeData.childrenOrderedKeys objectAtIndex:index]];
    }
	else if ([item isKindOfClass:FunctionTreeItem.class]) {
		FunctionTreeItem *root = (FunctionTreeItem *)item;
		if (index < root.children.count) {
			return [root.children objectForKey:[root.childrenOrderedKeys objectAtIndex:index]];
		}
	}
    return nil;
}

- (NSTableRowView*)outlineView:(NSOutlineView *)outlineView rowViewForItem:(id)item
{
	NSTableRowView*rowView = [[NSTableRowView alloc] init];
	FunctionTreeItem*Item = item;
	if(Item == nil) Item = TreeData;
	if(Item.object)
	{
		id object = Item.object;
		if(object)
		{
			[rowView setBackgroundColor:[NSColor colorWithCalibratedRed:0 green:0 blue:1 alpha:1]];
		}
	}
	return rowView;
}

//- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item
//{
//    return (item == nil) ? @"/" : item;
//}

- (CGFloat)outlineView:(NSOutlineView*)outlineView heightOfRowByItem:(id)item
{
	FunctionTreeItem*Item = item;
	if(Item == nil) Item = TreeData;
	id object = Item.object;
	
	CGFloat height = 17;
	if(Item.isHeader) //GLView
	{
		height = 40;
	}
	else if (Item.children.count > 0) //Group Item
	{
		height = 25;
	}
	
	return height;
}

//Delegate Methods

- (NSView*)outlineView:(NSOutlineView*)outlineView viewForTableColumn:(NSTableColumn*)tableColumn item:(id)item
{
	// Everything is setup in bindings
	SingleViewCellView*view = nil;
	FunctionTreeItem *obj = (FunctionTreeItem *)item;
	//	if(!Item.HasObject)
	//	{
	//		view = [outlineView makeViewWithIdentifier:@"GroupItemCell" owner:self];
	//	}
	if([obj isHeader])
	{
		view = [outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
	}
	else if ([[obj children] count] > 0)
	{
		view = [outlineView makeViewWithIdentifier:@"GroupItemCell" owner:self];
	}
	else
	{
		view = [outlineView makeViewWithIdentifier:@"FunctionCell" owner:self];
	}
	[view.textField setStringValue:obj.key];
	return view;
}
@end

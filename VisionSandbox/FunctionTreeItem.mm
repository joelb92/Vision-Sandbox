//
//  FunctionTreeItem.m
//  VisionSandbox
//
//  Created by Joel Brogan on 8/11/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "FunctionTreeItem.h"

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
- (NSArray*)writableTypesForPasteboard:(NSPasteboard*)pasteboard
{
	return [key writableTypesForPasteboard:pasteboard];
}
- (id)pasteboardPropertyListForType:(NSString *)type
{
    return nil;
}
- (NSPasteboardWritingOptions)writingOptionsForType:(NSString*)type pasteboard:(NSPasteboard*)pasteboard
{
	return 0;
}
+ (NSArray*)readableTypesForPasteboard:(NSPasteboard*)pasteboard
{
    return [NSArray arrayWithObjects:(id)kUTTypeFolder, (id)kUTTypeFileURL, nil];
}
+ (NSPasteboardReadingOptions)readingOptionsForType:(NSString*)type pasteboard:(NSPasteboard*)pasteboard
{
    return NSPasteboardReadingAsString;
}
- (void)valueForUndefinedKey:(NSString*)key
{
	NSLog(@"Failed to access TreeListItem %@ for key %@",self.description,key);
}

@end


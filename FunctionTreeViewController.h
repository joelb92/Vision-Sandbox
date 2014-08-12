//
//  FunctionTreeViewController.h
//  VisionSandbox
//
//  Created by Joel Brogan on 8/10/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SingleViewCellView.h"
#import "Function.h"
@interface FunctionTreeItem : NSObject
{
	NSString *key;
	NSMutableDictionary *children;
	NSMutableArray *childrenOrderedKeys;
	id object;
	bool isHeader;
}
@property NSString *key;
@property NSMutableDictionary *children;
@property NSMutableArray *childrenOrderedKeys;
@property id object;
@property bool isHeader;
-(id)initWithKey:(NSString *)k Object:(id)obj;
-(id)initWithKey:(NSString *)k Object:(id)obj Children:(NSMutableDictionary *)childs;
@end

@interface FunctionTreeViewController : NSObject <NSOutlineViewDataSource, NSOutlineViewDelegate>
{
	FunctionTreeItem *TreeData;
	IBOutlet NSOutlineView *listView;
}
-(void)addItem:(FunctionTreeItem *)item toPath:(NSString *)path;
-(void)addFunctions:(NSArray *)functions;
-(void)addFunction:(Function *)function;
@end

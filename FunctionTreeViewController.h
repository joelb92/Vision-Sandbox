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
#import "FunctionTreeItem.h"

@interface FunctionTreeViewController : NSObject <NSOutlineViewDataSource, NSOutlineViewDelegate>
{
	FunctionTreeItem *TreeData;
	IBOutlet NSOutlineView *listView;
	id selectedItem;
}
@property id selectedItem;
-(void)addItem:(FunctionTreeItem *)item toPath:(NSString *)path;
-(void)addFunctions:(NSArray *)functions;
-(void)addFunction:(Function *)function;
@end

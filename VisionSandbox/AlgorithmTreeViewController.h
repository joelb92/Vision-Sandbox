//
//  AlgorithmTreeViewController.h
//  VisionSandbox
//
//  Created by Joel Brogan on 8/11/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionTreeItem.h"
#import "Algorithm.h"
#import "SingleViewCellView.h"
#import "NSData+ValueToData.h"
@interface AlgorithmTreeViewController : NSObject <NSOutlineViewDataSource,NSOutlineViewDelegate>
{
	Algorithm *TreeData;
	Function *draggedFunction;
	IBOutlet NSOutlineView *listView;
}
-(Function *)FunctionAtIndex:(int)index;
-(void)addFunction:(Function *)function;
-(void)insertFunction:(Function *)function atIndex:(int)index;
-(void)replaceFunctionAtIndex:(int)index withFunction:(Function *)function;
-(Algorithm *)Algorithm;
-(void)setAlgorithm:(Algorithm *)al;
-(void)removeFunctionAtIndex:(int)index;
-(void)removeFunction:(Function *)func;
@end

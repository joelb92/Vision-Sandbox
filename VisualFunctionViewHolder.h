//
//  VisualFunctionViewHolder.h
//  VisionSandbox
//
//  Created by Joel Brogan on 8/13/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface VisualFunctionViewHolder : NSObject
{
	IBOutlet NSTableView *viewHolder;
}
@property NSTableView *viewHolder;
+ (id)sharedViewHolder;
@end

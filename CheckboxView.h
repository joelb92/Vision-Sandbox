//
//  CheckboxView.h
//  VisionSandbox
//
//  Created by Joel Brogan on 8/13/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FunctionVisualTableCellView.h"
@interface CheckboxView : FunctionVisualTableCellView
{
	IBOutlet NSButton *checkBox;
}
- (bool)state;
@end

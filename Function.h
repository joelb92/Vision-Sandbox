//
//  Function.h
//  VisionSandbox
//
//  Created by Joel Brogan on 8/9/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionVisualParametersView.h"
#import "Timer.h"
@interface Function : NSObject
{
	FunctionVisualParametersView *parametersView;
	NSString *functionName;
	NSString *functionTreePath;
	NSString *documentation;
	Timer *timer;
	double runTime;
	bool displayStepAsLayer;
	Class inputType;
	Class outputType;
}
@property FunctionVisualParametersView *parametersView;
@property NSString *functionName;
@property NSString *documentation;
@property double runTime;
@property bool displayStepAsLayer;
@property (readonly) Class inputType;
@property (readonly) Class outputType;
@property NSString *functionTreePath;
- (id)init;
- (id)run:(id)input;
- (void)beginRun;
- (void)endRun;
- (void)sendError;
@end

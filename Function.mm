//
//  Function.m
//  VisionSandbox
//
//  Created by Joel Brogan on 8/9/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "Function.h"
#import "OpenImageHandler.h"
@implementation Function
@synthesize parametersView,functionName,documentation,runTime,displayStepAsLayer,inputType,outputType;
- (id)init
{
	self = [super init];
	if (self) {
		parametersView = [[FunctionVisualParametersView alloc] init];
		timer = [[Timer alloc] init];
		runTime = 0;
		displayStepAsLayer = false;
	}
	return self;
}
- (id)run:(id)input;
{
	return input;
}
- (void)beginRun
{
	[timer startTimer];
}
- (void)endRun
{
	[timer stopTimer];
	runTime = [timer timeElapsedInMilliseconds];
}

-(void)sendError
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"Runtime Error" object:self];
}
@end

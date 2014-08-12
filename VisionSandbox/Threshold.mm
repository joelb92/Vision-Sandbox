//
//  Threshold.m
//  VisionSandbox
//
//  Created by Joel Brogan on 8/10/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "Threshold.h"

@implementation Threshold
-(id)init
{
	self = [super init];
	if (self) {
		functionName = @"Threshold";
		functionTreePath = @"OpenCV/Basic Operations";
		
		//Defaults
		thresh = 127;
		maxVal =255;
		type = cv::THRESH_BINARY;
	}
	return self;
}
-(id)run:(id)input
{
	id output = nil;
	[self beginRun];
	if ([input isKindOfClass:inputType]) {
		cv::Mat img = ((OpenImageHandler *)input).Cv;
		cv::threshold(img, img, thresh, maxVal, type);
		output = input;
	}
	else{
		[self sendError];
	}
	return output;
	[self endRun];
}
@end

//
//  Threshold.m
//  VisionSandbox
//
//  Created by Joel Brogan on 8/10/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "Threshold.h"

@implementation Threshold
-(id)run:(id)input
{
	id output = nil;
	[self beginRun];
	if ([input isKindOfClass:inputType]) {
		cv::Mat img = ((OpenImageHandler *)input).Cv;
		cv::threshold(img, img, 100, 255, CV_THRESH_BINARY);
		output = input;
	}
	else{
		[self sendError];
	}
	return output;
	[self endRun];
}
@end

//
//  Threshold.h
//  VisionSandbox
//
//  Created by Joel Brogan on 8/10/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "Function.h"
#import "OpenImageHandler.h"

@interface Threshold : Function
{
	double thresh;
	double maxVal;
	int type;
}
@end

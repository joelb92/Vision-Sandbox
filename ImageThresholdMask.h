//
//  ImageThresholdMask.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "OpenImageHandler.h"
#include "Vector2.h"
#include "Color.h"

@interface ImageThresholdMask : NSObject <NSCoding>
{
	OpenImageHandler*Mask;
	cv::Mat cvMask;
	OpenImageHandler*Image;
	Color Min;
	Color Max;
}
@property (retain) OpenImageHandler*Mask;
@property (readwrite) cv::Mat cvMask;
@property (retain) OpenImageHandler*Image;
@property (readwrite) Color Min;
@property (readwrite) Color Max;

- (id)initWithImage:(OpenImageHandler*)image Color:(Color)c MinValue:(double)min MaxColor:(double)max;
- (id)initWithImage:(OpenImageHandler*)image Color:(Color)c MinColor:(Color)min MaxColor:(Color)max;
- (id)initWithMask:(OpenImageHandler*)mask;
- (void)AddMask:(OpenImageHandler*)mask;
- (bool)MaskedAtX:(int)x Y:(int)y;
- (bool)MaskedAtPoint:(Vector2)point;
@end
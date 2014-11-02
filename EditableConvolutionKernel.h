//
//  EditableConvolutionKernel.h
//  VisionSandbox
//
//  Created by Joel Brogan on 9/19/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef struct
{
	NSString *name;
	int morph_type;
	int width;
	int height;
	bool isBlack;
}KernelElement;
@interface EditableConvolutionKernel : NSObject
{
	cv::Mat kernel,displayKernel;
	NSString *name;
	std::vector<KernelElement> elements;
	int currentSelectedEl;
}
@property cv::Mat kernel;
@property cv::Mat displayKernel;
@property NSString *name;
@property std::vector<KernelElement> elements;
@property int currentSelectedEl;
- (id)initWithName:(NSString *)n;
- (void)addElement;
- (void)removeElementAtIndex:(int)ind;
- (void)setElementWidth:(int)w;
- (void)setElementHeight:(int)h;
- (void)setElementType:(int)m;
- (void)setElementIsBlack:(bool)b;
- (void)setElementValues:(int)ind width:(int)w height:(int)h isBlack:(bool) b morphType:(int)m;
- (void) reconstructKernel;
@end

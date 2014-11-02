//
//  EditableConvolutionKernel.m
//  VisionSandbox
//
//  Created by Joel Brogan on 9/19/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "EditableConvolutionKernel.h"

@implementation EditableConvolutionKernel
@dynamic currentSelectedEl;
@synthesize kernel,displayKernel,name,elements;
static NSDictionary *morphTypes = @{@(cv::MORPH_ELLIPSE): @"Ellipse",@(cv::MORPH_RECT):@"Rectangle",@(cv::MORPH_CROSS):@"Cross"};
-(id)initWithName:(NSString *)n
{
	self = [super init];
	if (self) {
		currentSelectedEl = 0;
		name = n;
		[self addElement];
	}
	return self;
}

- (void)addElement{
	KernelElement newEl;
	newEl.morph_type = cv::MORPH_ELLIPSE;
	newEl.name = @"Ellipse";
	newEl.width = 5;
	newEl.height =5;
	newEl.isBlack = false;
	elements.push_back(newEl);
	[self reconstructKernel];
}
- (void)removeElementAtIndex:(int)ind
{
	if (elements.size() > 1 && ind < elements.size()) {
		std::vector<KernelElement> newElements;
		for (int i = 0; i < elements.size(); i++) {
			if (i != ind) {
				newElements.push_back(elements[i]);
			}
		}
		elements = newElements;
		[self reconstructKernel];
	}
}

-(void)setElementWidth:(int)w
{
	elements[currentSelectedEl].width = w;
	[self reconstructKernel];
}
-(void)setElementHeight:(int)h
{
	elements[currentSelectedEl].height = h;
	[self reconstructKernel];
}
-(void)setElementType:(int)m
{
	elements[currentSelectedEl].morph_type = m;
	elements[currentSelectedEl].name = [morphTypes objectForKey:@(m)];
	[self reconstructKernel];
}
-(void)setElementIsBlack:(bool)b
{
	elements[currentSelectedEl].isBlack =b;
	[self reconstructKernel];
}

-(void)setElementValues:(int)ind width:(int)w height:(int)h isBlack:(bool) b morphType:(int)m
{
	if (ind < elements.size()) {
		KernelElement newEl;
		newEl.morph_type = m;
		newEl.width = w;
		newEl.height = h;
		newEl.isBlack = b;
		newEl.name = [morphTypes objectForKey:@(m)];
		elements[ind] = newEl;
	}
	[self reconstructKernel];
	
}

-(void)setCurrentSelectedEl:(int)currentSelected
{
	currentSelectedEl =currentSelected;
	[self reconstructKernel];
}
- (void) reconstructKernel
{
	int kWidth,kHeight;
	kWidth = 0;
	kHeight = 0;
	for(int i = 0; i < elements.size(); i++)
	{
		int elWidth = elements[i].width;
		int elHeight = elements[i].height;
		if (elWidth > kWidth) {
			kWidth = elWidth;
		}
		if (elHeight > kHeight) {
			kHeight = elHeight;
		}
	}
	kernel = cv::Mat::zeros(kHeight, kWidth, CV_8UC1);
	cv::Mat colorElKern;
	for (int i = 0; i < elements.size(); i++) {
		
		cv::Mat elKern = cv::getStructuringElement(elements[i].morph_type, cv::Size(elements[i].width,elements[i].height));

		int addHeight = kHeight-elKern.rows;
		int addWidth = kWidth-elKern.cols;
		int top = addHeight/2;
		int bottom = addHeight/2;
		if (addHeight%2 != 0) bottom++;
		int left = addWidth/2;
		int right = addWidth/2;
		if (addWidth%2 != 0 ) right++;
		cv::copyMakeBorder(elKern, elKern, top, bottom, left, right, cv::BORDER_CONSTANT,0);
		if (!elements[i].isBlack) {
			kernel = kernel | elKern;
		}
		else{
			elKern = 1-elKern;
			kernel = kernel & elKern;
		}
		if (currentSelectedEl == i) {
			colorElKern = elKern;
		}
	}
	cv::Mat colorKernel;
	cv::cvtColor(kernel*255, colorKernel, CV_GRAY2BGR);
	for(int y=0;y<colorElKern.rows;y++)
	{
		for(int x=0;x<colorElKern.cols;x++)
		{
			// get pixel
			if (colorElKern.at<unsigned char>(y,x) == 1 && !elements[currentSelectedEl].isBlack) {
				colorKernel.at<cv::Vec3b>(y,x) = cv::Vec3b(0,0,255);
			}
			else if(colorElKern.at<unsigned char>(y,x) == 0 && elements[currentSelectedEl].isBlack) {
				colorKernel.at<cv::Vec3b>(y,x) = cv::Vec3b(255,0,0);
			}
			
		}
	}
	displayKernel = colorKernel;	
}
@end

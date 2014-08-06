//
//  AppDelegate.m
//  VisionSandbox
//
//  Created by Joel Brogan on 8/6/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	cv::Mat thing = cv::Mat::ones(5, 5, CV_8UC1);
	cv::imshow("thing", thing);
}

@end

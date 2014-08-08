//
//  GLViewMouseOverController.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 06/17/14.
//
//

#import "DragableSubView.h"
#import "GLRuler.h"
#import "GLProtractor.h"

@interface GLViewMouseOverController : DragableSubView <NSTabViewDelegate>
{
	GLRuler*rulerTool;
	GLProtractor*protractorTool;
	GLViewTool*currentTool;
	
	IBOutlet NSTabView *TabView;
	
	//Ruler
	IBOutlet NSTextField *DistanceOutput;
	
	//Protractor
	IBOutlet NSTextField *AngleOutput;
	
	//Spherometer
	IBOutlet NSTextField *RadiusOutput;
}
- (GLViewTool*)tool;

- (bool)ActiveInView:(NSView*)view;
- (void)ToggleInView:(NSView*)view;
@end

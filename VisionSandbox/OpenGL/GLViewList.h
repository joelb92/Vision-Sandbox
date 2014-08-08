//
//  GLViewList.h
//  DIF Map Decoder
//
//  Created by Charlie Mehlenbeck on 2/1/13.
//
//

#import <Foundation/Foundation.h>
#import "SingleViewCellView.h"
#import "GLViewListCommand.h"
#import "TreeList.h"
#import "GL2DView.h"
#import "GL3DView.h"

@interface GLViewList : TreeList <NSOutlineViewDataSource, NSOutlineViewDelegate, NSCoding>
{
	NSOutlineView*theOutlineView;
	NSArray*_itemsBeingDragged;
	NSMutableDictionary*Views;
	
	BOOL ViewReloadingData;
}
@property (readwrite) BOOL ViewReloadingData;

- (void)SaveRendersAtPath:(NSString*)path WithNamePrefix:(NSString*)namePrefix;
@end

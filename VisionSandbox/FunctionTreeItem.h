//
//  FunctionTreeItem.h
//  VisionSandbox
//
//  Created by Joel Brogan on 8/11/14.
//  Copyright (c) 2014 Magna Mirrors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunctionTreeItem : NSObject
{
	NSString *key;
	NSMutableDictionary *children;
	NSMutableArray *childrenOrderedKeys;
	id object;
	bool isHeader;
}
@property NSString *key;
@property NSMutableDictionary *children;
@property NSMutableArray *childrenOrderedKeys;
@property id object;
@property bool isHeader;
-(id)initWithKey:(NSString *)k Object:(id)obj;
-(id)initWithKey:(NSString *)k Object:(id)obj Children:(NSMutableDictionary *)childs;
-(void)addChild:(FunctionTreeItem *)child;
@end
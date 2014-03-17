//
//  Building.m
//  pokeson
//
//  Created by Jason Chu on 3/16/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "Building.h"

@interface Building ()

@property (readwrite) NSString* name;
@property (readwrite) CGFloat progress;
@property (readwrite) BuildingType type;
@property (readwrite) NSInteger level;

@property (readwrite) BOOL isConstructionComplete;
@property NSInteger actualProgress;
@property NSInteger maxProgress; 

@end
 
@implementation Building

- (BOOL) isConstructionComplete
{
	if (self.progress >= 1) {
		return YES;
	} else {
		return NO;
	}
}

- (id)init
{
    self = [super init];
    if (self) {
        self.name = @"";
		self.actualProgress = 10;
		self.maxProgress = 100;
		self.level = 1;
		self.progress = (CGFloat)self.actualProgress/self.maxProgress;
		self.isConstructionComplete = NO;
		self.type = BuildingTypeCore;
    }
    return self;
}


+ (Building*) buildingWithName:(NSString*) name type:(BuildingType) type {
	Building* building = [[Building alloc] init];
	building.name = name;
	building.type = type;
	return building;
}
@end

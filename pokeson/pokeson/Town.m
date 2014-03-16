//
//  Town.m
//  pokeson
//
//  Created by Jason Chu on 3/16/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "Town.h"

@implementation Town

- (id)init
{
    self = [super init];
    if (self) {
        self.buildings = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray*) buildingOfType:(BuildingType)type
{
	NSMutableArray *buildingsOfType = [[NSMutableArray alloc] init];
	
	for (Building *building in self.buildings) {
		if (building.type == type) {
			[buildingsOfType addObject:building];
		}
	}
	return buildingsOfType;
}

- (void)constructBuilding:(Building *)building {
	[self.buildings addObject:building];
}

@end

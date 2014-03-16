//
//  Town.h
//  pokeson
//
//  Created by Jason Chu on 3/16/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Building.h"

@interface Town : NSObject

@property NSMutableArray* buildings;

- (NSArray*) buildingOfType:(BuildingType)type;
- (void) constructBuilding:(Building*)building;

@end

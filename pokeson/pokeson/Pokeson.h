//
//  Pokeson.h
//  pokeson
//
//  Created by Jason Chu on 3/30/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Disease.h"
#import "Medicine.h"
#import "ActivePokeson.h"

@interface Pokeson : NSObject

@property float energy;
@property float healthState;
@property float sleepProgress;
@property float level;
@property BOOL dead;
@property Disease* disease;
@property Medicine* medicine;
@property ActivePokeson* activePokeson;
@property NSString* species;
@property UIImage* image;
@property NSString* name;

- (id)initWithName:(NSString*) name;


@end

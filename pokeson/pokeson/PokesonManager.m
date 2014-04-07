//
//  PokesonManager.m
//  pokeson
//
//  Created by Jason Chu on 3/31/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "PokesonManager.h"

@interface PokesonManager ()

@property (readwrite) NSMutableArray* pokesons;

@end


@implementation PokesonManager

- (id)init
{
    self = [super init];
    if (self) {
        self.pokesons = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)createPokesonWithName:(NSString *)name {
	Pokeson *newPokeson = [[Pokeson alloc] initWithName:name];
	[self.pokesons addObject:newPokeson];
}

@end

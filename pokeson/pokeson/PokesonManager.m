//
//  PokesonManager.m
//  pokeson
//
//  Created by Jason Chu on 3/31/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "PokesonManager.h"

@interface PokesonManager ()

@property (readwrite) NSMutableArray* allPokesons;

@end


@implementation PokesonManager

- (id)init
{
    self = [super init];
    if (self) {
        self.allPokesons = [[NSMutableArray alloc] init];
    }
    return self;
}

- (Pokeson*)newPokesonWithName:(NSString *)name color:(UIColor *)color{
    Pokeson* newPokeson = [[Pokeson alloc] initWithName:name color:color];
    [self.allPokesons addObject:newPokeson];
    return newPokeson;
}

@end

//
//  Pokeson.m
//  pokeson
//
//  Created by Jason Chu on 3/30/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "Pokeson.h"

@implementation Pokeson

- (id)initWithName:(NSString*)name
{
    self = [super init];
    if (self) {
        self.name = name;
        self.energy = 1.0;
        self.healthState = 5;
        self.sleepProgress = 0;
        self.level = 1;
        self.species = @"Pikachuie";
    }
    return self;
}

- (BOOL)sleep {
    if (self.energy <= 0) {
        self.sleepProgress += 0.01;
        if (self.sleepProgress >= 1) {
            return NO;
        } else {
            return YES;
        }
    } else {
        return NO;
    }
}

- (BOOL)available {
    if (self.energy <= 0) {
        return NO;
    } else if (self.sleepProgress != 0) {
        return NO;
    } else if (self.healthState <= 1) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)giveMedicine:(NSInteger)strength {
    if (self.healthState < 5) {
        self.healthState =+ strength;
        if (self.healthState > 5) {
            self.healthState = 5;
        }
        return YES;
    } else {
        return NO;
    }
}
@end

//
//  PokesonManager.h
//  pokeson
//
//  Created by Jason Chu on 3/31/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pokeson.h"

@interface PokesonManager : NSObject

@property (readonly) NSMutableArray* pokesons;

- (void)createPokesonWithName:(NSString*) name;

@end

//
//  EconomyManager.h
//  pokeson
//
//  Created by Jason Chu on 3/31/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResourceManager : NSObject

@property (readonly) NSInteger resources;

- (BOOL)canChargeResource:(NSInteger) amount;
- (BOOL)chargeResource:(NSInteger) amount;

@end

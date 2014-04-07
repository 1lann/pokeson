//
//  EconomyManager.m
//  pokeson
//
//  Created by Jason Chu on 3/31/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "ResourceManager.h"

@interface ResourceManager ()

@property (readwrite) NSInteger resources;

@end

@implementation ResourceManager

- (BOOL)canChangeResource:(NSInteger)amount {
	if (self.resources-amount >= 0) {
		self.resources -= amount;
		return YES;
	} else {
		return NO;
	}
}

- (BOOL)changeResource:(NSInteger)amount {
	if (self.resources-amount >= 0) {
		return YES;
	} else {
		return NO;
	}
}

@end

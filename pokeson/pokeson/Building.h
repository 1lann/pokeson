//
//  Building.h
//  pokeson
//
//  Created by Jason Chu on 3/16/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BuildingType) {
	BuildingTypeCore,
	BuildingTypeSpecial
};


@interface Building : NSObject

@property (readonly) NSString* name;
@property (readonly) CGFloat progress;
@property (readonly) NSInteger level;
@property (readonly) BuildingType type;

@property (nonatomic, readonly) BOOL isConstructionComplete;

+ (Building*) buildingWithName:(NSString*) name type:(BuildingType) type;

@end

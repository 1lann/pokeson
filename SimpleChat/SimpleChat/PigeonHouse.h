//
//  PigeonHouse.h
//  SimpleChat
//
//  Created by Jason Chu on 4/7/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarrierPigeon.h"

@protocol PigeonHouseDelegate <NSObject>

- (void)receivedArrayDataWithType:(NSString *)type data:(NSArray *)data fromSender:(NSString *)sender;
- (void)receivedRequestWithType:(NSString *)type;
- (void)networkChange:(NSArray*)peers;
- (void)networkError:(NSError*)error;

@end

@interface PigeonHouse : NSObject<CarrierPigeonDelegate>

@property (nonatomic, assign) id <PigeonHouseDelegate> delegate;

- (NSArray*)getPeers;
- (void)connectToNetworkWithName:(NSString*)name visible:(BOOL)visible;
- (BOOL)requestDataWithType:(NSString *)type targetName:(NSString *)targetName;
- (BOOL)respondWithData:(NSArray *)data type:(NSString *)type targetName:(NSString *)targetName;

@end

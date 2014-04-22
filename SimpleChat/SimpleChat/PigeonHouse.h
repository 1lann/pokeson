//
//  PigeonHouse.h
//  SimpleChat
//
//  Created by Jason Chu on 4/7/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarrierPigeonEmulator.h"

@protocol PigeonHouseDelegate <NSObject>

- (void)receivedArrayDataWithType:(NSString *)type data:(NSArray *)data fromSender:(NSString *)sender;
- (void)receivedRequestWithType:(NSString *)type fromSender:(NSString *)sender;
- (void)networkChange:(NSArray*)peers;
- (void)networkError:(NSError*)error;

@end

@interface PigeonHouse : NSObject<CarrierPigeonEmulatorDelegate>

@property (nonatomic, assign) id <PigeonHouseDelegate> delegate;

- (NSArray*)getPeers;
- (void)connectToNetworkWithName:(NSString*)name visible:(BOOL)visible;
- (BOOL)requestDataWithType:(NSString *)type targetName:(NSString *)targetName;
- (void)setAutoResponseWithType:(NSString *)type response:(NSArray *)response;
- (void)clearAutoResponseWithType:(NSString *)type;
- (BOOL)respondWithData:(NSArray *)data type:(NSString *)type targetName:(NSString *)targetName;

@end

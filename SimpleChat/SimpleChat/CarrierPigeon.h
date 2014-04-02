//
//  CarrierPigeon.h
//  SimpleChat
//
//  Created by Jason Chu on 3/17/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

@import MultipeerConnectivity;

#import <Foundation/Foundation.h>

@protocol CarrierPigeonDelegate <NSObject>

- (void)didReceiveMessage:(NSString *)message fromSender:(NSString *)sender rawData:(NSData *)data;
- (void)networkChange:(NSArray*)peerNames;
- (void)networkError:(NSError*)error;

@end

@interface CarrierPigeon : NSObject <MCNearbyServiceAdvertiserDelegate, MCSessionDelegate, MCNearbyServiceBrowserDelegate>


@property (nonatomic, assign) id <CarrierPigeonDelegate> delegate;

- (BOOL)broadcastMessage:(NSString *)message raw:(NSData*)raw;
- (BOOL)sendMessage:(NSString *)message targetName:(NSString*)targetName raw:(NSData*)raw;
- (void)connectToNetwork:(NSString *)displayName;
- (void)disconnect;

@end

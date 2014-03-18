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

- (void)didReceiveMessage:(NSString *)message fromSender:(NSString *)sender;
- (void)networkChange:(NSArray*)peerNames;
- (void)networkError:(NSError*)error;

@end

@interface CarrierPigeon : NSObject <MCNearbyServiceAdvertiserDelegate, MCSessionDelegate, MCNearbyServiceBrowserDelegate>


@property (nonatomic, assign) id <CarrierPigeonDelegate> delegate;

- (BOOL)sendMessage:(NSString *)message;
- (BOOL)sendMessage:(NSString *)message targetName:(NSString*)targetName;
- (void)connectToNetwork:(NSString *)displayName;
- (void)disconnect;

@end

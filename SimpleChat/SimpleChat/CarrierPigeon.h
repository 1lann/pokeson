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
- (void)didConnectToNetwork:(BOOL)successful;

@end

@interface CarrierPigeon : NSObject <MCNearbyServiceAdvertiserDelegate, MCSessionDelegate>

@property (readonly) NSString* broadcastName;
@property (readonly) MCPeerID* peerID;
@property (readonly) MCNearbyServiceAdvertiser* advertiser;
@property (readonly) MCSession* session;
@property (nonatomic, assign) id <CarrierPigeonDelegate> delegate;


- (void)sendMessage:(NSString *)message;
- (void)connectToNetwork:(NSString *)targetName;
- (CarrierPigeon*)initWithName:(NSString*)ourName;

@end

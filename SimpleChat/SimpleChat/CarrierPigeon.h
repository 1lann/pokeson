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

- (void)didReceiveData:(NSData *)data fromSender:(NSString *)sender;
- (void)networkChange:(NSArray*)peerNames;
- (void)networkError:(NSError*)error;

@end

@interface CarrierPigeon : NSObject <MCNearbyServiceAdvertiserDelegate, MCSessionDelegate, MCNearbyServiceBrowserDelegate>

@property (readonly) NSMutableArray* peerNames;
@property (readonly) BOOL visible;

@property (nonatomic, assign) id <CarrierPigeonDelegate> delegate;

- (BOOL)broadcastData:(NSData *)data;
- (BOOL)sendData:(NSData *)data targetName:(NSString*)targetName;
- (void)connectToNetworkWithName:(NSString *)displayName visible:(BOOL)visible;
- (void)disconnect;

@end

//
//  CarrierPigeonEmulator.h
//  SimpleChat
//
//  Created by Jason Chu on 4/21/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

@import MultipeerConnectivity;

#import <Foundation/Foundation.h>

@protocol CarrierPigeonEmulatorDelegate <NSObject>

- (void)didReceiveData:(NSData *)data fromSender:(NSString *)sender;
- (void)networkChange:(NSArray*)peerNames;
- (void)networkError:(NSError*)error;

@end

@interface CarrierPigeonEmulator : NSObject

@property (readonly) NSMutableArray* peerNames;
@property (readonly) BOOL visible;

@property (nonatomic, assign) id <CarrierPigeonEmulatorDelegate> delegate;

- (BOOL)broadcastData:(NSData *)data;
- (BOOL)sendData:(NSData *)data targetName:(NSString*)targetName;
- (void)connectToNetworkWithName:(NSString *)displayName visible:(BOOL)visible;
- (void)disconnect;

@end

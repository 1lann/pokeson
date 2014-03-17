//
//  CarrierPigeon.m
//  SimpleChat
//
//  Created by Jason Chu on 3/17/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "CarrierPigeon.h"

#define SERVICE_TYPE @"pokeson-archipelago-service"

@interface CarrierPigeon ()

@property (readwrite) NSString* broadcastName;
@property (readwrite) MCPeerID* peerID;
@property (readwrite) MCNearbyServiceAdvertiser* advertiser;
@property (readwrite) MCSession* session;

@end

@implementation CarrierPigeon

- (id)initWithName:(NSString*)name
{
    self = [super init];
    if (self) {
        self.peerID = [[MCPeerID alloc] initWithDisplayName:name];
		self.advertiser =
		[[MCNearbyServiceAdvertiser alloc] initWithPeer:self.peerID
										  discoveryInfo:nil
											serviceType:SERVICE_TYPE];
		self.advertiser.delegate = self;
		[self.advertiser startAdvertisingPeer];
    }
    return self;
}

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser
didReceiveInvitationFromPeer:(MCPeerID *)peerID
				 withContext:(NSData *)context
		  invitationHandler:(void(^)(BOOL accept, MCSession *session))invitationHandler
{
	self.session = [[MCSession alloc] initWithPeer:self.peerID
										securityIdentity:nil
									encryptionPreference:MCEncryptionNone];
	self.session.delegate = self;
	invitationHandler(YES, self.session);
	return;
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
	NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	[self.delegate didReceiveMessage:message fromSender:peerID.displayName];
}

- (void)connectToNetwork:(NSString *)ourName {
	
}

- (void)sendMessage:(NSString *)message {
	
}

// TODO: Discovery
// MCNearbyServiceBrowser
// - (void)startBrowsingForPeers
// browser:foundPeer:withDiscoveryInfo:
// - (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error

// ------------------------------------- DOCUMENTATION LINK ----------------------------- //
// https://developer.apple.com/library/ios/documentation/MultipeerConnectivity/Reference/MultipeerConnectivityFramework/Introduction/Introduction.html //
// ------------------------------------- DOCUMENTATION LINK ----------------------------- //



// ----------------------------------------------------------- //

#pragma mark To be completed in the future

// ----------------------------------------------------------- //


- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress {
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
}

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
}

@end

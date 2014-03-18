//
//  CarrierPigeon.m
//  SimpleChat
//
//  Created by Jason Chu on 3/17/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "CarrierPigeon.h"

#define SERVICE_TYPE @"pokeson-carrierpigeon"

@interface CarrierPigeon ()

@property (readwrite) NSString* broadcastName;
@property (readwrite) MCPeerID* peerID;
@property (readwrite) MCNearbyServiceAdvertiser* advertiser;
@property (readwrite) MCNearbyServiceBrowser* browser;
@property (readwrite) NSMutableArray* peerNames;
@property (readwrite) MCSession* session;
@property NSMutableArray* peers;

@end

@implementation CarrierPigeon

- (id)init
{
    self = [super init];
    if (self) {
        // Nothing as of right now
    }
    return self;
}

- (id)initWithName:(NSString*)name
{
    self = [super init];
    if (self) {
        self.peerID = [[MCPeerID alloc] initWithDisplayName:name];
        self.peers = [[NSMutableArray alloc] init];
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
    if (!self.session) {
        self.session = [[MCSession alloc] initWithPeer:self.peerID
										securityIdentity:nil
									encryptionPreference:MCEncryptionNone];
        self.session.delegate = self;
    }
	invitationHandler(YES, self.session);
	return;
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
	NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	[self.delegate didReceiveMessage:message fromSender:peerID.displayName];
}

- (void)connectToNetwork:(NSString*) displayName{
    // Initialise Peer
    self.peerID = [[MCPeerID alloc] initWithDisplayName:displayName];
    self.peers = [[NSMutableArray alloc] init];
    
    // Broadcast Peer
    self.advertiser =
    [[MCNearbyServiceAdvertiser alloc] initWithPeer:self.peerID
                                      discoveryInfo:nil
                                        serviceType:SERVICE_TYPE];
    self.advertiser.delegate = self;
    [self.advertiser startAdvertisingPeer];
    
    // Find Other Peers
	if (self.browser) {
        [self.browser stopBrowsingForPeers];
        self.browser = NULL;
    }
    self.browser = [[MCNearbyServiceBrowser alloc] initWithPeer:self.peerID serviceType:SERVICE_TYPE];
}

- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
    [self.peers addObject:peerID];
    [self.peerNames addObject:peerID.displayName];
    [self.delegate networkChange:self.peerNames];
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID {
    [self.peers removeObject:peerID];
    [self.peerNames removeObject:peerID.displayName];
    [self.delegate networkChange:self.peerNames];
}

- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error {
    [self.delegate networkError:(error)];
}

- (BOOL)sendMessage:(NSString *)message targetName:(NSString *)targetName {
    // Create connection with peer
    
    
    // Send message
	for (MCPeerID* peer in self.peers) {
        if ([targetName isEqualToString:peer.displayName]) {
            NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSArray *target = @[peer];
            if (![self.session sendData:data
                                toPeers:target
                               withMode:MCSessionSendDataReliable
                                  error:&error]) {
                return NO;
            } else {
                return YES;
            }
        }
    }
    return NO;
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

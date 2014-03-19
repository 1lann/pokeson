//
//  CarrierPigeon.m
//  SimpleChat
//
//  Created by Jason Chu on 3/17/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "CarrierPigeon.h"

#define SERVICE_TYPE @"pokeson-pigeon"
#define PIGEON_DEBUG @NO

@interface CarrierPigeon ()

@property (readwrite) NSString* broadcastName;
@property (readwrite) MCPeerID* peerID;
@property (readwrite) MCNearbyServiceAdvertiser* advertiser;
@property (readwrite) MCNearbyServiceBrowser* browser;
@property (readwrite) NSMutableArray* peerNames;
@property (readwrite) MCSession* session;
@property NSMutableArray* visiblePeers;

@end

@implementation CarrierPigeon

- (id)init
{
    self = [super init];
    if (self) {
		self.visiblePeers = [[NSMutableArray alloc] init];
		self.peerNames = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser
didReceiveInvitationFromPeer:(MCPeerID *)peerID
				 withContext:(NSData *)context
		  invitationHandler:(void(^)(BOOL accept, MCSession *session))invitationHandler
{
    if (![self.session.connectedPeers containsObject:peerID]) {
        if (PIGEON_DEBUG) NSLog(@"PIGEON: Peer inviting to connect: %@",peerID.displayName);
        invitationHandler(YES, self.session);
    }
	return;
}

- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID {
    if (PIGEON_DEBUG) NSLog(@"PIGEON: Received message from: %@",peerID.displayName);
	NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	[self.delegate didReceiveMessage:message fromSender:peerID.displayName];
}

- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state {
	if (state == MCSessionStateConnected) {
		if (PIGEON_DEBUG) NSLog(@"PIGEON: Connected: %@",peerID.displayName);
		[self.peerNames addObject:peerID.displayName];
		[self.delegate networkChange:self.peerNames];
	} else if (state == MCSessionStateNotConnected) {
		if (PIGEON_DEBUG) NSLog(@"PIGEON: Disconnected: %@",peerID.displayName);
		[self.peerNames removeObject:peerID.displayName];
		[self.delegate networkChange:self.peerNames];
	} else {
		if (PIGEON_DEBUG) NSLog(@"PIGEON: Unknown state change of: %@",peerID.displayName);
	}
}

- (void)connectToNetwork:(NSString*) displayName{
    // Initialise Peer
    self.peerID = [[MCPeerID alloc] initWithDisplayName:displayName];
    
	// Initialise Session
	self.session = [[MCSession alloc] initWithPeer:self.peerID
								  securityIdentity:nil
							  encryptionPreference:MCEncryptionNone];
	self.session.delegate = self;
	
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
    self.browser.delegate = self;
    [self.browser startBrowsingForPeers];
    if (PIGEON_DEBUG) NSLog(@"PIGEON: Started browsing for peers");
}

- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didNotStartAdvertisingPeer:(NSError *)error {
	if (PIGEON_DEBUG) NSLog(@"PIGEON: An error occured while trying to start advertising");
	[self.delegate networkError:error];
}

- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info {
	if (!([self.visiblePeers containsObject:peerID] || [self.session.connectedPeers containsObject:peerID])) {
        if (PIGEON_DEBUG) NSLog(@"PIGEON: Found peer, inviting: %@",peerID.displayName);
        [self.visiblePeers addObject:peerID];
        [self.browser invitePeer:peerID toSession:self.session withContext:nil timeout:3.0];
    }
}

- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID {
	if (PIGEON_DEBUG) NSLog(@"PIGEON: Lost peer: %@",peerID.displayName);
	[self.peerNames removeObject:peerID.displayName];
    [self.visiblePeers removeObject:peerID];
}

- (void)browser:(MCNearbyServiceBrowser *)browser didNotStartBrowsingForPeers:(NSError *)error {
	if (PIGEON_DEBUG) NSLog(@"PIGEON: An error occured while trying to start browsing");
    [self.delegate networkError:error];
}

- (BOOL)sendMessage:(NSString *)targetName {
	return true;
}

- (BOOL)sendMessage:(NSString *)message targetName:(NSString *)targetName {
    // Try to send message
	for (MCPeerID* peer in self.session.connectedPeers) {
        if ([targetName isEqualToString:peer.displayName]) {
            NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
            NSError *error = nil;
            NSArray *target = @[peer];
            [self.session sendData:data toPeers:target withMode:MCSessionSendDataReliable error:&error];
            if (error) {
				if (PIGEON_DEBUG) NSLog(@"PIGEON: An error occured while sending message");
                return NO;
            } else {
				if (PIGEON_DEBUG) NSLog(@"PIGEON: Message sent");
                return YES;
            }
        }
    }
	if (PIGEON_DEBUG) NSLog(@"PIGEON: Target not connected");
	return NO;
}

- (BOOL)broadcastMessage:(NSString *)message {
    // Try to send message
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *target = self.session.connectedPeers;
    [self.session sendData:data toPeers:target withMode:MCSessionSendDataReliable error:&error];
    if (error) {
        if (PIGEON_DEBUG) NSLog(@"PIGEON: An error occured while broadcasting message");
        return NO;
    } else {
        if (PIGEON_DEBUG) NSLog(@"PIGEON: Message broadcasted");
        return YES;
    }
}

- (void) disconnect {
	[self.advertiser stopAdvertisingPeer];
	[self.session disconnect];
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
    if (PIGEON_DEBUG) NSLog(@"PIGEON: Received Resource");
}

- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error {
    if (PIGEON_DEBUG) NSLog(@"PIGEON: Finished Resource");
}

- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID {
    if (PIGEON_DEBUG) NSLog(@"PIGEON: Received Stream");
}

@end

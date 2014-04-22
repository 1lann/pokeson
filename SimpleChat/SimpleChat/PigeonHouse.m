//
//  PigeonHouse.m
//  SimpleChat
//
//  Created by Jason Chu on 4/7/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "PigeonHouse.h"

@interface PigeonHouse ()

@property CarrierPigeonEmulator* pigeon;
@property NSMutableArray* autoResponses;

@end

@implementation PigeonHouse

- (id)init
{
    self = [super init];
    if (self) {
        self.pigeon = [[CarrierPigeonEmulator alloc] init];
        self.pigeon.delegate = self;
		self.autoResponses = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray*)getPeers {
	return [self.pigeon.peerNames copy];
}

- (void)connectToNetworkWithName:(NSString*)name visible:(BOOL)visible {
	[self.pigeon connectToNetworkWithName:name visible:visible];
}

- (void)networkError:(NSError *)error {
	[self.delegate networkError:error];
}

- (BOOL)requestDataWithType:(NSString *)type targetName:(NSString*)targetName {
	// TODO: currently dummy code
//	if ([type isEqualToString:@"list"]) {
//		[self.delegate receivedArrayDataWithType:@"list" data:@[@"Chuie",@"Ben",@"Hector",@"Pizz"] fromSender:targetName];
//	}
//	return YES;
	NSMutableArray* request = [[NSMutableArray alloc] init];
	[request addObject:@"request"];
	[request addObject:type];
	NSData* data = [NSKeyedArchiver archivedDataWithRootObject:request];
	return [self.pigeon sendData:data targetName:targetName];
}

- (BOOL)respondWithData:(NSArray *)data type:(NSString *)type targetName:(NSString *)targetName {
	NSMutableArray* mutData = [data mutableCopy];
	NSMutableArray* response = [[NSMutableArray alloc] init];
	[response addObject:@"response"];
	[response addObject:type];
	[response addObject:mutData];
	NSData* sendData = [NSKeyedArchiver archivedDataWithRootObject:response];
	return [self.pigeon sendData:sendData targetName:targetName];
}

- (void)networkChange:(NSArray *)peerNames {
    [self.delegate networkChange:peerNames];
}

- (void)didReceiveData:(NSData *)data fromSender:(NSString *)sender {
	NSArray* request = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	if (request && [request count] >= 2) {
		if ([request[0] isKindOfClass:[NSString class]] &&
			[request[1] isKindOfClass:[NSString class]] &&
			[request[0] isEqualToString:@"request"]) {
			for (NSArray *dataArray in self.autoResponses) {
				if ([request[1] isEqualToString:dataArray[0]]) {
					NSArray *responseData = @[@"response", request[1], dataArray[1]];
					NSData* sendData = [NSKeyedArchiver archivedDataWithRootObject:responseData];
					[self.pigeon sendData:sendData targetName:sender];
					return;
				}
			}
			[self.delegate receivedRequestWithType:request[1] fromSender:sender];
		} else if (request && [request count] >= 3 &&
				   [request[0] isKindOfClass:[NSString class]] &&
				   [request[1] isKindOfClass:[NSString class]] &&
				   [request[0] isEqualToString:@"response"]) {
			[self.delegate receivedArrayDataWithType:request[1] data:request[2] fromSender:sender];
		} else {
			NSLog(@"Malformed request");
		}
	} else {
		NSLog(@"Invalid request");
	}
}

- (void)setAutoResponseWithType:(NSString *)type response:(NSArray *)response {
	NSArray *responseData = @[type, response];
	[self clearAutoResponseWithType:type];
	[self.autoResponses addObject:responseData];
}

- (void)clearAutoResponseWithType:(NSString *)type {
	for (NSArray *dataArray in self.autoResponses){
		if ([type isEqualToString:dataArray[0]]) {
			[self.autoResponses removeObject:dataArray];
		}
	}
}

@end

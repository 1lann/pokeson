//
//  PigeonHouse.m
//  SimpleChat
//
//  Created by Jason Chu on 4/7/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "PigeonHouse.h"

@interface PigeonHouse ()

@property CarrierPigeon* pigeon;

@end

@implementation PigeonHouse

- (id)init
{
    self = [super init];
    if (self) {
        self.pigeon = [[CarrierPigeon alloc] init];
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
		if ([[request objectAtIndex:1] isKindOfClass:[NSString class]] &&
			[[request objectAtIndex:2] isKindOfClass:[NSString class]] &&
			[[request objectAtIndex:1] isEqualToString:@"request"]) {
			[self.delegate receivedRequestWithType:[request objectAtIndex:2]];
		} else if ([request count] >= 3 &&
				   [[request objectAtIndex:1] isKindOfClass:[NSString class]] &&
				   [[request objectAtIndex:2] isKindOfClass:[NSString class]] &&
				   [[request objectAtIndex:1] isEqualToString:@"response"]) {
			[self.delegate receivedArrayDataWithType:[request objectAtIndex:2] data:[request objectAtIndex:3] fromSender:sender];
		} else {
			NSLog(@"Malformed request");
		}
	} else {
		NSLog(@"Invalid request");
	}
}

@end

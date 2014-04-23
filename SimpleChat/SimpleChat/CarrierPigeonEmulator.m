//
//  CarrierPigeonEmulator.m
//  SimpleChat
//
//  Created by Jason Chu on 4/21/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "CarrierPigeonEmulator.h"

@interface CarrierPigeonEmulator()

@property NSString *name;

@property (readwrite) NSMutableArray *peerNames;
@property (readwrite) BOOL visible;

@end

@implementation CarrierPigeonEmulator

- (void)connectToNetworkWithName:(NSString *)displayName visible:(BOOL)visible {
	self.name = displayName;
	self.visible = visible;
	self.peerNames = [[NSMutableArray alloc] init];
	[self.peerNames addObject:@"Demo"];
	if (self.visible) {
		[self.peerNames addObject:self.name];
	}
	[self.delegate networkChange:[self.peerNames copy]];
}

- (BOOL)broadcastData:(NSData *)data {
	[self.delegate didReceiveData:data fromSender:self.name];
	return YES;
}

- (BOOL)sendData:(NSData *)data targetName:(NSString *)targetName {
	if ([targetName isEqualToString:self.name] && self.visible) {
		[self.delegate didReceiveData:data fromSender:self.name];
		return YES;
	} else if ([targetName isEqualToString:@"Demo"]) {
		NSArray* request = [NSKeyedUnarchiver unarchiveObjectWithData:data];
		if (request) {
			if (request.count > 1) {
				if ([request[0] isKindOfClass:[NSString class]] && [request[0] isEqualToString:@"request"]) {
					if([request[1] isKindOfClass:[NSString class]] && [request[1] isEqualToString:@"list"]) {
						NSArray *demoList = @[@"Demo Object 1", @"Demo Object 2", @"Demo Object 3", @"Potato", @"12345"];
						NSData *demoData = [NSKeyedArchiver archivedDataWithRootObject:@[@"response", @"list", demoList]];
						[self.delegate didReceiveData:demoData fromSender:@"Demo"];
					} else {
						NSLog(@"EmuP Error: Request type is not 'list'");
					}
				} else {
					NSLog(@"EmuP Error: Header is not 'request'");
				}
			} else {
				NSLog(@"EmuP Error: Invalid number of arguments of archived data from sendData. Minimum required: 2");
			}
		} else {
			NSLog(@"EmuP Error: NSArray not archived correctly");
		}
		return YES;
	} else {
		return NO;
	}
}

- (void)disconnect {
	return;
}

@end

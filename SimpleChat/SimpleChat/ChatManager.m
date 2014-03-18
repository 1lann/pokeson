//
//  ChatManager.m
//  SimpleChat
//
//  Created by Jason Chu on 3/11/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "ChatManager.h"

@interface ChatManager ()

@property (nonatomic, readwrite) NSString* username;

@property NSMutableArray* users;
@property NSMutableArray* messages;


@end

@implementation ChatManager

- (id)init
{
    self = [super init];
    if (self) {
        self.users = [[NSMutableArray alloc] init];
		self.messages = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSString*) getMessageAtIndex:(NSInteger)index {
	return [self.messages objectAtIndex:(index)];
}

- (NSString*) getUserAtIndex:(NSInteger)index {
	return [self.users objectAtIndex:(index)];
}

- (NSInteger) getLengthOfChat {
	if ([self.users count] == [self.messages count]) {
		return [self.users count];
	} else {
		assert(!"Fatal: Chat database disprecancy!");
	}
		
}

- (NSString*) username {
	if (!_username || [[_username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) return @"Anonymous";
	else return _username;
}

- (void)storeChatMessage:(NSString*)message withUser:(NSString*)username {
	if ([[message stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) return;
	[self.users insertObject:username atIndex:0];
	[self.messages insertObject:message atIndex:0];
}

- (void) registerUsername:(NSString *)username {
	self.username = username;
}

@end

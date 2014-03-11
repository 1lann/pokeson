//
//  ChatManager.h
//  SimpleChat
//
//  Created by Jason Chu on 3/11/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatManager : NSObject

@property (nonatomic, readonly) NSString* username;

- (NSString*)getUserAtIndex:(NSInteger) index;
- (NSString*)getMessageAtIndex:(NSInteger) index;
- (void)storeChatMessage:(NSString*)message withUser:(NSString*)username;
- (NSInteger)getLengthOfChat;
- (void)registerUsername:(NSString*)username;

@end

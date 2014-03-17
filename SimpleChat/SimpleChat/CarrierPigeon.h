//
//  CarrierPigeon.h
//  SimpleChat
//
//  Created by Jason Chu on 3/17/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CarrierPigeonDelegate <NSObject>

- (void)didReceiveMessage:(NSString *)message fromSender:(NSString *)sender;
- (void)didConnectToNetwork:(BOOL)successful;

@end

@interface CarrierPigeon : NSObject

- (void)sendMessage:(NSString *)message;
- (void)connectToNetwork:(NSString *)ourName;

@end

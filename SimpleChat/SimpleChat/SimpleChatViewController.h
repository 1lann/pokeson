//
//  SimpleChatViewController.h
//  SimpleChat
//
//  Created by Jason Chu on 3/11/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleChatViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
- (IBAction)sendButtonPressed:(UIButton *)sender;

@end

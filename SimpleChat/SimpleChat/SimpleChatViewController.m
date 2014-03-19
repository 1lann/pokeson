//
//  SimpleChatViewController.m
//  SimpleChat
//
//  Created by Jason Chu on 3/11/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "SimpleChatViewController.h"
#import "ChatManager.h"

#define MESSAGE_FIELD_TAG 2
#define NAME_FIELD_TAG 1
#define CELL_IDENTIFIER @"tableCell"
#define USERNAME @"Chuie"

@interface SimpleChatViewController ()

@property (nonatomic) ChatManager* chat;
@property CarrierPigeon* pigeon;

@end

@implementation SimpleChatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnTableView:)];
	[self.tableView addGestureRecognizer:tap];
	self.pigeon = [[CarrierPigeon alloc] init];
    self.pigeon.delegate = self;
	[self.pigeon connectToNetwork:USERNAME];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ChatManager*) chat {
	if (!_chat) _chat = [[ChatManager alloc] init];
	return _chat;
    
}

- (void)didReceiveMessage:(NSString *)message fromSender:(NSString *)sender {
	NSLog(@"Received Message: %@",message);
    [self.chat storeChatMessage:message withUser:sender];
    [self.tableView reloadData];
}

- (void)networkChange:(NSArray *)peerNames {
	NSLog(@"Network Change");
}

- (void)networkError:(NSError *)error {
	NSLog(@"Network Error");
}

// ---------------------------------------------------------- //
#pragma mark - Buttons and what not
// ---------------------------------------------------------- //

- (IBAction)sendButtonPressed:(UIButton *)sender {
	[self.chat storeChatMessage:self.messageField.text withUser:USERNAME];
	self.messageField.text = @"";
	[self.tableView reloadData];
	NSLog(@"Attempt to send: %hhd", [self.pigeon broadcastMessage:self.messageField.text]);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField.tag == MESSAGE_FIELD_TAG) {
		// Send
		[self.chat storeChatMessage:textField.text withUser:USERNAME];
		textField.text = @"";
		[self.tableView reloadData];
        NSLog(@"Attempt to send: %hhd", [self.pigeon broadcastMessage:self.messageField.text]);
		return YES;
	} else {
		[textField resignFirstResponder];
		return NO;
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	if (textField.tag == NAME_FIELD_TAG) {
		[self.chat registerUsername:(textField.text)];
	}
}

- (void)didTapOnTableView:(UIGestureRecognizer*) recognizer {
	[self.messageField resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	return [self.chat getLengthOfChat];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
	if (cell == nil) {
		NSLog(@"new cell");
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
									  reuseIdentifier:CELL_IDENTIFIER];
	}
    // Configure the cell...
	cell.textLabel.text = [self.chat getUserAtIndex:indexPath.row];
	cell.detailTextLabel.text = [self.chat getMessageAtIndex:indexPath.row];
	//cell.detailTextLabel.textColor = [UIColor colorWithRed:67.0/255.0 green:119.0/255.0 blue:255.0/255.0 alpha:1.0];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
	//[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	
}

@end

//
//  PokesonViewerViewController.m
//  SimpleChat
//
//  Created by Jason Chu on 4/8/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "PokesonViewerViewController.h"
#define CELL_ID @"viewerCell"

@interface PokesonViewerViewController ()

@property NSMutableArray* listOfPokesons;
@property id previousDelegate;

@end

@implementation PokesonViewerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.previousDelegate = self.pigeonHouse.delegate;
	self.pigeonHouse.delegate = self;
	self.listOfPokesons = [[NSMutableArray alloc] init];
	[self.pigeonHouse requestDataWithType:@"list" targetName:self.targetName];
	self.navigationController.topViewController.title = self.targetName;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listOfPokesons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
									  reuseIdentifier:CELL_ID];
	}
    cell.textLabel.text = [self.listOfPokesons objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)networkChange:(NSArray *)peers {
	
}

- (void)receivedArrayDataWithType:(NSString *)type data:(NSArray *)data fromSender:(NSString *)sender {
	if ([type isEqualToString:@"list"]) {
		self.listOfPokesons = [data mutableCopy];
		[self.tableView reloadData];
	}
}

- (void)receivedRequestWithType:(NSString *)type fromSender:(NSString *)sender {

}

- (void)networkError:(NSError *)error {
	
}

-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        self.pigeonHouse.delegate = self.previousDelegate;
        [self callbackFunc];
        [self.navigationController popViewControllerAnimated:NO];
    }
    [super viewWillDisappear:animated];
}

@end

//
//  RadarViewController.m
//  SimpleChat
//
//  Created by Jason Chu on 4/8/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "RadarViewController.h"
#import "PokesonViewerViewController.h"
#define CELL_ID @"radarCell"

@interface RadarViewController ()

@property PigeonHouse* pigeonHouse;

@end

@implementation RadarViewController

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
    self.pigeonHouse = [[PigeonHouse alloc] init];
    self.pigeonHouse.delegate = self;
#warning TODO: Change this later
    [self.pigeonHouse connectToNetworkWithName:@"Chuie" visible:YES];
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
    return [[self.pigeonHouse getPeers] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
									  reuseIdentifier:CELL_ID];
	}
    cell.textLabel.text = [[self.pigeonHouse getPeers] objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"listPokeson" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"listPokeson"]){
        NSIndexPath *selectedRow = [[self tableView] indexPathForSelectedRow];
        PokesonViewerViewController *vc = [segue destinationViewController];
		vc.pigeonHouse = self.pigeonHouse;
		vc.targetName = [[self.pigeonHouse getPeers] objectAtIndex:selectedRow.row];
        vc.callbackFunc = ^void() {[self.tableView reloadData];};
        [self.tableView deselectRowAtIndexPath:selectedRow animated:YES];
    }
}

- (void)networkChange:(NSArray *)peers {
    [self.tableView reloadData];
}

- (void)receivedArrayDataWithType:(NSString *)type data:(NSArray *)data fromSender:(NSString *)sender {
    
}

- (void)receivedRequestWithType:(NSString *)type fromSender:(NSString *)sender {
#warning Not implemented correctly. TODO
    if ([type isEqualToString:@"list"]) {
        NSArray* array = @[@"Test",@"Josh",@"Test monster",@"MissingNO."];
        [self.pigeonHouse respondWithData:array type:type targetName:sender];
    }
}

- (void)networkError:(NSError *)error {
    
}

@end

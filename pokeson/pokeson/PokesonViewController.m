//
//  PokesonViewController.m
//  pokeson
//
//  Created by Jason Chu on 3/9/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//
#warning TO BE DELETED

#import "PokesonViewController.h"
#import "Town.h"
#import "ObjectCell.h"

#define CELL_STANDARD @"StandardCell"
#define CELL_PROGRESS @"ProgressCell"

@interface PokesonViewController ()

@property (nonatomic) Town* town;

@end

@implementation PokesonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (Town *)town
{
	if (!_town) {
        _town = [[Town alloc] init];
		[_town constructBuilding:[Building buildingWithName:@"Chuie Corp Offices" type:BuildingTypeSpecial]];
		[_town constructBuilding:[Building buildingWithName:@"Chuie Corp Cafeteria" type:BuildingTypeSpecial]];
		[_town constructBuilding:[Building buildingWithName:@"Nandos Restruant" type:BuildingTypeCore]];
		[_town constructBuilding:[Building buildingWithName:@"Nandos 'Breeding' Centre" type:BuildingTypeCore]];
	}
	return _town;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) progressOfAttributeAtIndex:(NSInteger)index {
	return arc4random_uniform(100)/100.0;
}

- (UIColor*) colorOfAttributeAtIndex:(NSInteger)index { 
	CGFloat hue = (float)index / (float)[self numberOfAttributes];
	return [UIColor colorWithHue:hue
					  saturation:0.8
					  brightness:0.8
						   alpha:1];
}

- (NSInteger) numberOfAttributes {
	return 5;
}

- (MultiProgressViewDisplayStyle)displayStyle {
	return MultiProgressViewDisplayStyleRightToLeft;
}
- (IBAction)click:(UIButton *)sender {
    [self.barView updateDisplay];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSArray* buildingsOfType = [self.town buildingOfType:[indexPath indexAtPosition:0]];
	Building* building = [buildingsOfType objectAtIndex:[indexPath indexAtPosition:1]];
	if (building.isConstructionComplete) {
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_STANDARD];
		cell.textLabel.text = building.name;
		cell.detailTextLabel.text = [NSString stringWithFormat:@"Level: %i",building.level];
		return cell;
	} else {
		ObjectCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_PROGRESS];
		cell.titleLabel.text = building.name;
		cell.detailLabel.text = [NSString stringWithFormat:@"Level: %i",building.level];
		cell.progressBar.progress = building.progress;
		return cell;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (section == 0) {
		return @"Core Buildings";
	} else {
		return @"Special Buildings";
	}
}


@end

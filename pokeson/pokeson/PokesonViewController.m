//
//  PokesonViewController.m
//  pokeson
//
//  Created by Jason Chu on 3/9/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "PokesonViewController.h"
#define SHOP_CELL_IDENTIFIER @"shopCell"

@interface PokesonViewController ()

@end

@implementation PokesonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SHOP_CELL_IDENTIFIER forIndexPath:indexPath];
	if (cell == nil) {
		NSLog(@"new cell");
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
									  reuseIdentifier:SHOP_CELL_IDENTIFIER];
	}
    // Configure the cell...
	cell.textLabel.text = @"Chuie Likes Trains!";
	cell.detailTextLabel.text = @"Derp";
	cell.detailTextLabel.textColor = [UIColor colorWithRed:67.0/255.0 green:119.0/255.0 blue:255.0/255.0 alpha:1.0];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
	
}

@end

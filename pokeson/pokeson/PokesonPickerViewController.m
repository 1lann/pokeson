//
//  PokesonManagerViewController.m
//  pokeson
//
//  Created by Jason Chu on 3/30/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "PokesonPickerViewController.h"
#define CELL_ID @"collectionCell"

@interface PokesonPickerViewController ()

@property PokesonManager* pokesonManager;
@property Pokeson* pokesonToBePassed;
@property Pokeson* selectedPokeson1;
@property Pokeson* selectedPokeson2;
@property Pokeson* justSelectedPokeson;
@property Pokeson* justUnselectedPokeson;
@property id titleView;
@property id leftView;
@property id rightView;
@property BOOL selectionActive;

@end

@implementation PokesonPickerViewController

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
	self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
	self.pokesonManager = [[PokesonManager alloc] init];
	[self.pokesonManager newPokesonWithName:@"Pikachuie" color:[UIColor yellowColor]];
	[self.pokesonManager newPokesonWithName:@"Nandos" color:[UIColor redColor]];
	[self.pokesonManager newPokesonWithName:@"Wood" color:[UIColor brownColor]];
	[self.pokesonManager newPokesonWithName:@"Grass" color:[UIColor greenColor]];
	
	NSLog(@"Loaded");
	self.titleView = [[self.navigationController.navigationBar subviews] objectAtIndex:1];
	self.leftView = [[self.navigationController.navigationBar subviews] objectAtIndex:2];
	self.rightView = [[self.navigationController.navigationBar subviews] objectAtIndex:3];
	
	self.selectionActive = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.pokesonManager.allPokesons count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    [label setTextColor:[UIColor blackColor]];
    [label setBackgroundColor:[UIColor clearColor]];
	[label setTextAlignment:NSTextAlignmentCenter];
    [label setFont:[UIFont fontWithName: @"HelveticaNeue-CondensedBold" size: 45.0f]];
	Pokeson* pokeson = [self.pokesonManager.allPokesons objectAtIndex:indexPath.row];
	UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	bgView.backgroundColor = pokeson.color;
	NSString* name = [pokeson.name substringWithRange:NSMakeRange(0, 4)];
	[label setText:name];
	[cell.contentView addSubview:bgView];
    [cell.contentView addSubview:label];
	if (self.selectedPokeson1 == pokeson || self.selectedPokeson2 == pokeson) {
		if (self.justSelectedPokeson == pokeson) {
		[bgView.layer setBorderColor:[[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]CGColor]];
		bgView.layer.borderWidth = 0.0;
		CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
		fadeAnim.fromValue = [NSNumber numberWithFloat:0.0];
		fadeAnim.toValue = [NSNumber numberWithFloat:6.0];
		fadeAnim.duration = 0.1;
		[bgView.layer addAnimation:fadeAnim forKey:@"borderWidth"];
		bgView.layer.borderWidth = 6.0;
		} else {
			[bgView.layer setBorderColor:[[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]CGColor]];
			bgView.layer.borderWidth = 6.0;
		}
	} else if (self.justUnselectedPokeson == pokeson) {
		self.justUnselectedPokeson = NULL;
		[bgView.layer setBorderColor:[[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]CGColor]];
		bgView.layer.borderWidth = 6.0;
		CABasicAnimation* fadeAnim = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
		fadeAnim.fromValue = [NSNumber numberWithFloat:6.0];
		fadeAnim.toValue = [NSNumber numberWithFloat:0.0];
		fadeAnim.duration = 0.1;
		[bgView.layer addAnimation:fadeAnim forKey:@"borderWidth"];
		bgView.layer.borderWidth = 0.0;
	}
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	if (!self.selectionActive) {
		self.pokesonToBePassed = [self.pokesonManager.allPokesons objectAtIndex:indexPath.item];
		[self performSegueWithIdentifier:@"selectedPokeson" sender:self ];
	} else {
		Pokeson* tappedPokeson = [self.pokesonManager.allPokesons objectAtIndex:indexPath.row];
		self.justSelectedPokeson = tappedPokeson;
		if (self.selectedPokeson1) {
			if (self.selectedPokeson1 == tappedPokeson) {
				self.justUnselectedPokeson = self.selectedPokeson1;
				if (self.selectedPokeson2) {
					self.selectedPokeson1 = self.selectedPokeson2;
					self.selectedPokeson2 = NULL;
				} else {
					self.selectedPokeson1 = NULL;
				}
			} else if (self.selectedPokeson2 == tappedPokeson) {
				self.justUnselectedPokeson = self.selectedPokeson2;
				self.selectedPokeson2 = NULL;
			} else {
				self.justUnselectedPokeson = self.selectedPokeson2;
				self.selectedPokeson2 = tappedPokeson;
			}
		} else {
			self.selectedPokeson1 = tappedPokeson;
		}
		[self.pickerView reloadData];
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if([[segue identifier] isEqualToString:@"selectedPokeson"]){
		PokesonInfoViewController* vc = [[[segue destinationViewController] viewControllers] objectAtIndex:0];
		vc.pokeson = self.pokesonToBePassed;
	}
}

- (IBAction)breedButtonPressed:(UIBarButtonItem *)sender {
	if (!self.selectionActive) {
		self.selectionActive = YES;
		[UIView animateWithDuration:0.3 animations:^{
			self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
			[self.titleView setAlpha:0];
			[self.leftView setAlpha:0];
			[self.rightView setAlpha:0];
			[self.rightView setTitle:@"Breed"];
			[self.leftView setTitle:@"Cancel"];
		} completion:^(BOOL finished){
			self.navigationController.topViewController.title = @"Select Pokesons";
			[UIView animateWithDuration:0.2 animations:^{
				[self.titleView setAlpha:1];
				[self.leftView setAlpha:1];
				[self.rightView setAlpha:1];
			}];
		}
		 ];
	} else {
		self.selectionActive = NO;
		self.selectedPokeson1 = NULL;
		self.selectedPokeson2 = NULL;
		[self.pickerView reloadData];
		[UIView animateWithDuration:0.3 animations:^{
			[self.rightView setTitle:@"Done"];
			[self.leftView setTitle:@"Breed"];
			self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
			[self.titleView setAlpha:0];
			[self.leftView setAlpha:0];
			[self.rightView setAlpha:0];
		} completion:^(BOOL finished){
			self.navigationController.topViewController.title = @"Manage Pokesons";
			[UIView animateWithDuration:0.2 animations:^{
				[self.titleView setAlpha:1];
				[self.leftView setAlpha:1];
				[self.rightView setAlpha:1];
			}];
		}
		 ];

	}
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
	if (!self.selectionActive) {
		[self performSegueWithIdentifier:@"unwindFromPokesonPicker" sender:self];
	} else {
		
	}
}
	 
@end

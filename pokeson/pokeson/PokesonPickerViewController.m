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
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	self.pokesonToBePassed = [self.pokesonManager.allPokesons objectAtIndex:indexPath.item];
	 [self performSegueWithIdentifier:@"selectedPokeson" sender:self ];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if([[segue identifier] isEqualToString:@"selectedPokeson"]){
		UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
		PokesonInfoViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PokesonInfoView"];
		vc.pokeson = self.pokesonToBePassed;
		vc.pokeson.name = @"Test";
	}
}

@end

//
//  PokesonMenuViewController.m
//  pokeson
//
//  Created by Jason Chu on 3/26/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "PokesonMenuViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PokesonMenuViewController ()

@end

@implementation PokesonMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)applyGlow:(UIButton*) button {
	button.layer.masksToBounds = NO;
    button.layer.borderWidth = 0.0f;
    
    button.layer.shadowColor = [UIColor whiteColor].CGColor;
    button.layer.shadowOpacity = 1;
    button.layer.shadowRadius = 8;
    button.layer.shadowOffset = CGSizeMake(0,0);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self applyGlow:self.manageButton];
	[self applyGlow:self.structuresButton];
	[self applyGlow:self.travelButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindFromPokesonPicker:(UIStoryboardSegue*) segue {
    
}

@end

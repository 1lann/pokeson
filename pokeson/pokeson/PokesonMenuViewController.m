//
//  PokesonMenuViewController.m
//  pokeson
//
//  Created by Jason Chu on 3/26/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "PokesonMenuViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.manageButton.layer.shadowColor = [[UIColor whiteColor] CGColor];
    self.manageButton.layer.shadowOffset = CGSizeMake(0.5, 0.5);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

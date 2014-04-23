//
//  PokesonInfoViewController.m
//  pokeson
//
//  Created by Jason Chu on 4/18/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "PokesonInfoViewController.h"

@interface PokesonInfoViewController ()

@end

@implementation PokesonInfoViewController

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
	self.navigationController.topViewController.title = self.pokeson.name;
	NSLog(@"Viewer loaded");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

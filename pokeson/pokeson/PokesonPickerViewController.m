//
//  PokesonManagerViewController.m
//  pokeson
//
//  Created by Jason Chu on 3/30/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "PokesonPickerViewController.h"

@interface PokesonPickerViewController ()

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.manageButton.layer.masksToBounds = NO;
    self.manageButton.layer.borderWidth = 0.0f;
    
    self.manageButton.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.manageButton.layer.shadowOpacity = 1;
    self.manageButton.layer.shadowRadius = 8;
    self.manageButton.layer.shadowOffset = CGSizeMake(0,0);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

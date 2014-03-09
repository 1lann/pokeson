//
//  PokesonViewController.m
//  pokeson
//
//  Created by Jason Chu on 3/9/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "PokesonViewController.h"

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
	return 3;
}
@end

//
//  PokesonViewController.h
//  pokeson
//
//  Created by Jason Chu on 3/9/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiProgressView.h"

@interface PokesonViewController : UIViewController<MultiProgressViewDelegate, UITableViewDataSource, UITableViewDelegate>

- (IBAction)click:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet MultiProgressView *barView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

//
//  PokesonViewerViewController.h
//  SimpleChat
//
//  Created by Jason Chu on 4/8/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PigeonHouse.h"

@interface PokesonViewerViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, PigeonHouseDelegate>

@property PigeonHouse* pigeonHouse;
@property NSString* targetName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

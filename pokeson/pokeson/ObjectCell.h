//
//  ObjectCell.h
//  pokeson
//
//  Created by Jason Chu on 3/12/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ObjectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

@end

//
//  ObjectCell.m
//  pokeson
//
//  Created by Jason Chu on 3/12/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "ObjectCell.h"

@implementation ObjectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

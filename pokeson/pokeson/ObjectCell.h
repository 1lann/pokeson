//
//  ObjectCell.h
//  pokeson
//
//  Created by Jason Chu on 3/12/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MultiProgressViewDelegate <NSObject>

- (CGFloat) progressOfAttributeAtIndex:(NSInteger)index;
- (NSInteger) numberOfAttributes;
- (UIColor*) colorOfAttributeAtIndex:(NSInteger)index;
- (MultiProgressViewDisplayStyle) displayStyle;

@end

@interface ObjectCell : UITableViewCell


@end

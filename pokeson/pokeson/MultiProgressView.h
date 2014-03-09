//
//  MultiProgressView.h
//  pokeson
//
//  Created by Jason Chu on 3/9/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MultiProgressViewDelegate <NSObject>

- (CGFloat) progressOfAttributeAtIndex:(NSInteger)index;
- (NSInteger) numberOfAttributes;
- (UIColor*) colorOfAttributeAtIndex:(NSInteger)index;

@end

@interface MultiProgressView : UIView

@property IBOutlet id<MultiProgressViewDelegate> delegate;


@end

//
//  MultiProgressView.h
//  pokeson
//
//  Created by Jason Chu on 3/9/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MultiProgressViewDisplayStyle) {
	MultiProgressViewDisplayStyleLeftToRight,
	MultiProgressViewDisplayStyleRightToLeft
};

@protocol MultiProgressViewDelegate <NSObject>

- (CGFloat) progressOfAttributeAtIndex:(NSInteger)index;
- (NSInteger) numberOfAttributes;
- (UIColor*) colorOfAttributeAtIndex:(NSInteger)index;
- (MultiProgressViewDisplayStyle) displayStyle;

@end

@interface MultiProgressView : UIView

@property IBOutlet id<MultiProgressViewDelegate> delegate;
- (void) updateDisplay;

@end

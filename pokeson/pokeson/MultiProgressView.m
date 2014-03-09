//
//  MultiProgressView.m
//  pokeson
//
//  Created by Jason Chu on 3/9/14.
//  Copyright (c) 2014 Jason Chu. All rights reserved.
//

#import "MultiProgressView.h"

@implementation MultiProgressView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
	NSInteger barHeigth = 10;
	MultiProgressViewDisplayStyle style = [self.delegate displayStyle];
	
	NSInteger numberOfAttributes = [self.delegate numberOfAttributes];
	
	for (NSInteger currentAttribute = 0;
		 currentAttribute <= numberOfAttributes;
		 currentAttribute += 1) {
		CGRect progressRect;
		CGFloat width = [self.delegate progressOfAttributeAtIndex:currentAttribute] * rect.size.width;
		if (style == MultiProgressViewDisplayStyleLeftToRight) {
			progressRect = CGRectMake(rect.origin.x, rect.origin.y+(currentAttribute*(barHeigth+1)), width, barHeigth);
		} else if (style == MultiProgressViewDisplayStyleRightToLeft) {
			progressRect = CGRectMake(rect.origin.x+rect.size.width, rect.origin.y+(currentAttribute*(barHeigth+1)), (-1)*width, barHeigth);
		} else {
			assert(!"No display style set");
		}
		CGContextSetFillColorWithColor(context, [[self.delegate colorOfAttributeAtIndex:currentAttribute] CGColor]);
		CGContextFillRect(context, progressRect);
	}
}


@end

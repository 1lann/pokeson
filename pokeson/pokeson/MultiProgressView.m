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
    
    // Clear area
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextFillRect(context, rect);
    
	NSInteger barHeight = 10;
    NSInteger barGap = 1;
    
	MultiProgressViewDisplayStyle style = [self.delegate displayStyle];
	
	NSInteger numberOfAttributes = [self.delegate numberOfAttributes];
    
    if(numberOfAttributes*(barHeight+barGap) > rect.size.height) {
        //barGap = 0;
       // if (numberOfAttributes*barHeight > rect.size.height) {
            barHeight = (int)((rect.size.height-numberOfAttributes*barGap)/numberOfAttributes);
            if (barHeight < 5) {
                assert(!"Too many bars to cram in such a small space!");
            }
        //}
    }
	
	for (NSInteger currentAttribute = 0;
		 currentAttribute <= numberOfAttributes;
		 currentAttribute += 1) {
		CGRect progressRect;
		CGFloat width = [self.delegate progressOfAttributeAtIndex:currentAttribute] * rect.size.width;
		if (style == MultiProgressViewDisplayStyleLeftToRight) {
			progressRect = CGRectMake(rect.origin.x, rect.origin.y+(currentAttribute*(barHeight+barGap)), width, barHeight);
		} else if (style == MultiProgressViewDisplayStyleRightToLeft) {
			progressRect = CGRectMake(rect.origin.x+rect.size.width, rect.origin.y+(currentAttribute*(barHeight+barGap)), (-1)*width, barHeight);
		} else {
			assert(!"No display style set");
		}
		CGContextSetFillColorWithColor(context, [[self.delegate colorOfAttributeAtIndex:currentAttribute] CGColor]);
		CGContextFillRect(context, progressRect);
	}
}

- (void)updateDisplay {
    [self setNeedsDisplay];
}

@end

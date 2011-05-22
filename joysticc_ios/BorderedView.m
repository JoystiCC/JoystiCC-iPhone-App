//
//  BorderedView.m
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BorderedView.h"


@implementation BorderedView

@synthesize borderColor;
@synthesize borderWidth;

- (id)initWithFrame:(CGRect)aFrame borderColor:(UIColor *)aColor borderWidth:(float)aWidth {
    self = [super initWithFrame:aFrame];
    if (self) {
		self.borderColor = aColor;
		self.borderWidth = aWidth;
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

	if (self.borderColor != nil && self.borderWidth > 0) {
		CGColorRef cgColorRef = [self.borderColor CGColor];
		CGContextRef contextRef = UIGraphicsGetCurrentContext();
		CGContextSetLineWidth(contextRef, self.borderWidth);
		CGContextSetStrokeColorWithColor(contextRef, cgColorRef);
		CGContextStrokeRect(contextRef, rect);
	}
}

- (void)dealloc
{
    [super dealloc];
}

@end

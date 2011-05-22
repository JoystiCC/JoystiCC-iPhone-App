//
//  BorderedView.h
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BorderedView : UIView {
    UIColor *_borderColor;
	float _borderWidth;
}

- (id)initWithFrame:(CGRect)aFrame borderColor:(UIColor *)aColor borderWidth:(float)aWidth;

@property (nonatomic, retain) UIColor *borderColor;
@property (nonatomic) float borderWidth;

@end

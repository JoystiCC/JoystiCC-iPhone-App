//
//  ButtonGroupView.m
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ButtonGroupView.h"


@implementation ButtonGroupView

@synthesize buttons=_buttons;
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame buttons:(NSArray *)aButtons {
    self = [super initWithFrame:frame];
    if (self) {

		_buttons = aButtons;
		
		float initX = 10.0f;
		int i = 0;
		for (UIButton *button in aButtons) {			
		
			CGRect frame = button.frame;
			frame.origin.x = initX;
			button.frame = frame;
			
			button.selected = (i == 0);
			
			[button addTarget:self action:@selector(touchDownAction:) forControlEvents:UIControlEventTouchDown];
			[button addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
			[button addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchUpOutside];
			[button addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchDragOutside];
			[button addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchDragInside];
			
			[self addSubview:button];
			
			initX += frame.size.width + 20.0f;
			i++;
		}
		
	}
    return self;
}

- (void)touchDownAction:(id)sender {
	[self selectButton:sender];
}

- (void)touchUpInsideAction:(id)sender {
	[self selectButton:sender];
}

- (void)otherTouchesAction:(id)sender {
	[self selectButton:sender];
}

- (void)selectButton:(UIButton *)aButton {

	for (UIButton *button in _buttons) {

		if (button == aButton) {
			button.selected = YES;
			button.highlighted = (button.selected ? NO : YES);
			
			if (self.delegate && [self.delegate respondsToSelector:@selector(buttonWasSelected:)]) {
				if (_selected != button) {
					[self.delegate buttonWasSelected:button];
				}
			}
			
		}
		else {

			if (self.delegate && [self.delegate respondsToSelector:@selector(buttonWasUnselected:)]) {
				if (_selected == button) {
					[self.delegate buttonWasUnselected:button];
				}
			}
			
			button.selected = NO;
			button.highlighted = NO;
		}
	}

	_selected = aButton;
}


- (void)dealloc
{
    [super dealloc];
}

@end

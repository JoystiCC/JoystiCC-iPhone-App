//
//  ButtonGroupView.h
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ButtonGroupViewDelegate <NSObject>
@optional
- (void)buttonWasSelected:(UIButton *)aButton;
- (void)buttonWasUnselected:(UIButton *)aButton;
@end


@interface ButtonGroupView : UIView {

    id<ButtonGroupViewDelegate> _delegate;
	
	NSArray *_buttons;
	UIButton *_selected;
}

@property (nonatomic, readonly) NSArray *buttons;
@property (nonatomic, retain) id<ButtonGroupViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame buttons:(NSArray *)aButtons;
- (void)selectButton:(UIButton *)aButton;

@end

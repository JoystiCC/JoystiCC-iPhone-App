//
//  CreateGameViewController.h
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "BorderedView.h"

@interface CreateGameViewController : UIViewController {
    
	UILabel *createGameHeaderLabel;
	UILabel *gameNameHeaderLabel;
	UILabel *teamNameHeaderLabel;
	UILabel *pinHeaderLabel;
	UILabel *confirmPinHeaderLabel;
	UIScrollView *mainScrollView;
	UITextField *gameNameField;
	UITextField *teamNameField;
	UITextField *pinField;
	UITextField *confirmPinField;

	BorderedView *subheaderView;
	
	BOOL _showingKeyboard;
	CGPoint _scrollOffset;
	
}

@property (nonatomic, retain) IBOutlet BorderedView *subheaderView;
@property (nonatomic, retain) IBOutlet UILabel *createGameHeaderLabel;

@property (nonatomic, retain) IBOutlet UILabel *gameNameHeaderLabel;
@property (nonatomic, retain) IBOutlet UILabel *teamNameHeaderLabel;
@property (nonatomic, retain) IBOutlet UILabel *pinHeaderLabel;
@property (nonatomic, retain) IBOutlet UILabel *confirmPinHeaderLabel;

@property (nonatomic, retain) IBOutlet UIScrollView *mainScrollView;

@property (nonatomic, retain) IBOutlet UITextField *gameNameField;
@property (nonatomic, retain) IBOutlet UITextField *teamNameField;
@property (nonatomic, retain) IBOutlet UITextField *pinField;
@property (nonatomic, retain) IBOutlet UITextField *confirmPinField;

@end

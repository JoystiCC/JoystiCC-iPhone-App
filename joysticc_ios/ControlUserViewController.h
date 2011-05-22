//
//  ControlUserViewController.h
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASIHTTPRequest.h"
#import "ButtonGroupView.h"
#import "BorderedView.h"
#import "JSON.h"

extern NSInteger const kUpKeyCode;
extern NSInteger const kDownKeyCode;
extern NSInteger const kLeftKeyCode;
extern NSInteger const kRightKeyCode;
extern NSInteger const kEnterKeyCode;

extern float const kPlayerButtonWidth;
extern float const kPlayerButtonHeight;
extern float const kPlayerButtonSpace;

@interface ControlUserViewController : UIViewController<ButtonGroupViewDelegate, UIAlertViewDelegate> {
    
	UILabel *teamHeaderLabel;
	UILabel *teamNameLabel;
	BorderedView *nameBorderedView;
	UILabel *roundNumberLabel;
	UILabel *roundHeaderLabel;
	UILabel *playerNameLabel;
	UILabel *playerHeaderLabel;
	UILabel *gameTimeLabel;
	UILabel *gameTimeHeaderLabel;
	UILabel *nextMoveLabel;
	UILabel *nextMoveHeaderLabel;
	BorderedView *gameTimeView;
	BorderedView *nextMoveView;
	
	
	// overlay
	UIView *_waitOverlay;
	
	
	// dpad buttons
	UIButton *upButton;
	UIButton *rightButton;
	UIButton *downButton;
	UIButton *leftButton;
	UIButton *enterButton;
	BorderedView *currentPlayerView;
	BorderedView *playerButtonGroupView;
	
	NSMutableArray *_playerButtons;
	NSTimer *_startGameTimer;
	NSInteger _failCount;
	
	// state
	NSDictionary *_teamData;
}

@property (nonatomic, retain) IBOutlet UILabel *teamHeaderLabel;
@property (nonatomic, retain) IBOutlet UILabel *teamNameLabel;
@property (nonatomic, retain) IBOutlet BorderedView *nameBorderedView;
@property (nonatomic, retain) IBOutlet UILabel *roundNumberLabel;
@property (nonatomic, retain) IBOutlet UILabel *roundHeaderLabel;

@property (nonatomic, retain) IBOutlet UILabel *playerNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *playerHeaderLabel;

@property (nonatomic, retain) IBOutlet UILabel *gameTimeLabel;
@property (nonatomic, retain) IBOutlet UILabel *gameTimeHeaderLabel;
@property (nonatomic, retain) IBOutlet UILabel *nextMoveLabel;
@property (nonatomic, retain) IBOutlet UILabel *nextMoveHeaderLabel;

@property (nonatomic, retain) IBOutlet BorderedView *gameTimeView;
@property (nonatomic, retain) IBOutlet BorderedView *nextMoveView;

// dpad keys
@property (nonatomic, retain) IBOutlet UIButton *upButton;
@property (nonatomic, retain) IBOutlet UIButton *rightButton;
@property (nonatomic, retain) IBOutlet UIButton *downButton;
@property (nonatomic, retain) IBOutlet UIButton *leftButton;
@property (nonatomic, retain) IBOutlet UIButton *enterButton;

@property (nonatomic, retain) IBOutlet BorderedView *currentPlayerView;
@property (nonatomic, retain) IBOutlet BorderedView *playerButtonGroupView;

// init
- (id)initWithTeamData:(NSDictionary *)aTeamData;

// actions
- (IBAction)dpadHit:(id)sender;


@end

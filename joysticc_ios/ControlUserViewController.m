//
//  ControlUserViewController.m
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ControlUserViewController.h"
#import "ButtonGroupView.h"

NSInteger const kUpKeyCode = 101001;
NSInteger const kDownKeyCode = 101002;
NSInteger const kLeftKeyCode = 101003;
NSInteger const kRightKeyCode = 101004;
NSInteger const kEnterKeyCode = 101005;

float const kPlayerButtonWidth = 52.0f;
float const kPlayerButtonHeight = 58.0f;
float const kPlayerButtonSpace = 8.0f;

@interface ControlUserViewController (Private)
- (void)initialize;
- (void)setupViews;

- (void)postDirectionEvent:(NSInteger)aDirectionCode;
- (void)postActionEvent;

@end

@implementation ControlUserViewController

@synthesize upButton, rightButton, downButton, leftButton, enterButton;
@synthesize currentPlayerView;
@synthesize playerButtonGroupView;

@synthesize teamHeaderLabel;
@synthesize teamNameLabel;
@synthesize nameBorderedView;
@synthesize roundNumberLabel;
@synthesize roundHeaderLabel;
@synthesize playerNameLabel;
@synthesize playerHeaderLabel;
@synthesize gameTimeLabel;
@synthesize gameTimeHeaderLabel;
@synthesize nextMoveLabel;
@synthesize nextMoveHeaderLabel;
@synthesize gameTimeView;
@synthesize nextMoveView;

#pragma mark Initialization
- (void)initialize {

}

- (void)setupViews {
	
	CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
	
	nameBorderedView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.15f];
	nameBorderedView.borderColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
	
	nextMoveView.borderColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
	nextMoveView.borderWidth = 3.0f;
	gameTimeView.borderColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
	gameTimeView.borderWidth = 3.0f;
	
	// build player buttons

	UIImage *playerImageNormal = [UIImage imageNamed:@"player_button"];
	UIImage *playerImageActive = [UIImage imageNamed:@"player_button_active"];
	
	NSMutableArray *playerButtons = [[NSMutableArray alloc] init];
	for (int i = 0; i < _numPlayers; i++) {
		
		UIButton *playerButton = [UIButton buttonWithType:UIButtonTypeCustom];
		
		[playerButton setBackgroundImage:playerImageNormal forState:UIControlStateNormal];
		[playerButton setBackgroundImage:playerImageActive forState:UIControlStateSelected];
		[playerButton setBackgroundImage:playerImageActive forState:UIControlStateHighlighted];

		playerButton.frame = CGRectMake(0.0f, 0.0f, kPlayerButtonWidth, kPlayerButtonHeight);

		[playerButton setTitle:[NSString stringWithFormat:@"P%d", (i + 1)] 
					  forState:UIControlStateNormal];
		playerButton.titleLabel.font = [UIFont fontWithName:@"silkscreen" size:14.0f];
		
		[playerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
		[playerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
		[playerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
		
		playerButton.showsTouchWhenHighlighted = NO;
		playerButton.tag = i + 1;		
		
		[playerButtons addObject:playerButton];
	}

	
	currentPlayerView.borderColor = [UIColor colorWithWhite:0.0f alpha:0.9f];
	
	ButtonGroupView *buttonGroup = [[ButtonGroupView alloc] initWithFrame:CGRectMake(0.0f, 398.0f, 
																					 appFrame.size.width, 60.0f) 
																  buttons:playerButtons];
	buttonGroup.delegate = self;
	[self.view addSubview:buttonGroup];
	
	
	// set custom fonts
	teamHeaderLabel.font = [UIFont fontWithName:@"chunkfive" size:8.0f];
	teamNameLabel.font = [UIFont fontWithName:@"chunkfive" size:28.0f];
	roundHeaderLabel.font = [UIFont fontWithName:@"chunkfive" size:8.0f];
	roundNumberLabel.font = [UIFont fontWithName:@"silkscreen" size:36.0f];
	playerHeaderLabel.font = [UIFont fontWithName:@"silkscreen" size:11.0f];
	playerNameLabel.font = [UIFont fontWithName:@"chunkfive" size:11.0f];
	nextMoveHeaderLabel.font = [UIFont fontWithName:@"silkscreen" size:10.0f];
	gameTimeHeaderLabel.font = [UIFont fontWithName:@"silkscreen" size:10.0f];
	nextMoveLabel.font = [UIFont fontWithName:@"silkscreen" size:22.0f];
	gameTimeLabel.font = [UIFont fontWithName:@"silkscreen" size:22.0f];
	
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		[self initialize];
	}
    return self;
}

- (id)initWithPlayers:(NSInteger)aNumberOfPlayers {
	self = [super init];
	if (self) {
		_numPlayers = aNumberOfPlayers;
	}
	return self;
}


#pragma mark - Callbacks
- (IBAction)dpadHit:(id)sender {

	UIButton *hitButton = (UIButton *)sender;	

	NSInteger tag = hitButton.tag;
	if (tag == kUpKeyCode || tag == kDownKeyCode || tag == kLeftKeyCode || tag == kRightKeyCode) {
		
	}
	else if (tag == kEnterKeyCode) {
		
	}
}

- (void)buttonWasSelected:(UIButton *)aButton {
	LLog(@"button was selected: %d", aButton.tag);
}


#pragma mark - Network events
- (void)postDirectionEvent:(NSInteger)aDirectionCode {
	
}

- (void)postActionEvent {
	
}



#pragma mark - View lifecycle
- (void)viewDidLoad {

    [super viewDidLoad];
	[self setupViews];

	teamNameLabel.text = @"Team Name";
	
}

- (void)viewDidUnload {
	[self setTeamNameLabel:nil];
	[self setNameBorderedView:nil];
	[self setRoundNumberLabel:nil];
	[self setRoundHeaderLabel:nil];
	[self setTeamHeaderLabel:nil];
	[self setUpButton:nil];
	[self setRightButton:nil];
	[self setDownButton:nil];
	[self setLeftButton:nil];
	[self setEnterButton:nil];
	[self setCurrentPlayerView:nil];
	[self setPlayerButtonGroupView:nil];
	[self setPlayerNameLabel:nil];
	[self setPlayerHeaderLabel:nil];
	[self setGameTimeLabel:nil];
	[self setGameTimeHeaderLabel:nil];
	[self setNextMoveLabel:nil];
	[self setNextMoveHeaderLabel:nil];
	[self setGameTimeView:nil];
	[self setNextMoveView:nil];
    [super viewDidUnload];	
}


#pragma mark - View configuration
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Memory management
- (void)dealloc {
	[teamNameLabel release];
	[nameBorderedView release];
	[roundNumberLabel release];
	[roundHeaderLabel release];
	[teamHeaderLabel release];
	[upButton release];
	[rightButton release];
	[downButton release];
	[leftButton release];
	[enterButton release];
	[currentPlayerView release];
	[playerButtonGroupView release];
	[playerNameLabel release];
	[playerHeaderLabel release];
	[gameTimeLabel release];
	[gameTimeHeaderLabel release];
	[nextMoveLabel release];
	[nextMoveHeaderLabel release];
	[gameTimeView release];
	[nextMoveView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

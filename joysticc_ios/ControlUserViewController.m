//
//  ControlUserViewController.m
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ControlUserViewController.h"
#import "ButtonGroupView.h"

float const kPlayerButtonWidth = 52.0f;
float const kPlayerButtonHeight = 58.0f;
float const kPlayerButtonSpace = 8.0f;

@interface ControlUserViewController (Private)
- (void)initialize;
- (void)setupViews;

- (void)postDirectionEvent:(NSInteger)aDirectionCode;
- (void)postActionEvent;
- (void)checkForGameStart;
- (void)startGame;

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
	
	self.navigationController.navigationBarHidden = YES;
	
	CGRect appFrame = [[UIScreen mainScreen] bounds];
	
	
	_waitOverlay = [[UIView alloc] initWithFrame:appFrame];
	_waitOverlay.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.9f];
	
	
	UIActivityIndicatorView *waitLoader = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	waitLoader.frame = CGRectMake((appFrame.size.width - 20) / 2, 200 - 30, 20, 20);
	[waitLoader startAnimating];
	[_waitOverlay addSubview:waitLoader];
	
	UILabel *waitLabel = [[UILabel alloc] initWithFrame:CGRectMake((appFrame.size.width - 200) / 2, 200.0f, 
																   200.0f, 80.0f)];
	waitLabel.backgroundColor = [UIColor clearColor];
	waitLabel.numberOfLines = 2;
	waitLabel.text = @"PLEASE WAIT WHILE THE GAME IS SET UP";
	waitLabel.textColor = [UIColor whiteColor];
	waitLabel.font = [UIFont fontWithName:@"silkscreen" size:12.0f];
	waitLabel.textAlignment = UITextAlignmentCenter;
	
	[_waitOverlay addSubview:waitLabel];
	
	_waitOverlay.hidden = NO;
	[self.view addSubview:_waitOverlay];
	
	nameBorderedView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.15f];
	nameBorderedView.borderColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
	
	nextMoveView.borderColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
	nextMoveView.borderWidth = 3.0f;
	gameTimeView.borderColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
	gameTimeView.borderWidth = 3.0f;
	

	
	currentPlayerView.borderColor = [UIColor colorWithWhite:0.0f alpha:0.9f];

	[_waitOverlay bringSubviewToFront:self.view];
	
	
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

- (id)initWithTeamData:(NSDictionary *)aTeamData {
	self = [super init];
	if (self) {
		_teamData = [aTeamData retain];
	}
	return self;
}


#pragma mark - Callbacks
- (IBAction)dpadHit:(id)sender {

	UIButton *hitButton = (UIButton *)sender;	

	NSInteger tag = hitButton.tag;
	if (tag == kUpKeyCode || tag == kDownKeyCode || tag == kLeftKeyCode || tag == kRightKeyCode || tag == kEnterKeyCode) {
		
		NSString *urlString = [NSString stringWithFormat:kGetPlayerUrl, @"7"];
		NSURL *requestUrl = [NSURL URLWithString:urlString];
		ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:requestUrl];
		
		[request setRequestMethod:@"PUT"];
		
		NSString *accessKey = @"32da39da51c742188b2572b65cf70fbda09e273dbb30e4fb83a617e09b271f80";
		[request setPostValue:[NSString stringWithFormat:@"%d", tag] forKey:@"direction"];
		[request setPostValue:accessKey forKey:@"access_key"];
		
		[request setDelegate:self];
		[request setDidFailSelector:@selector(updateRequestFailed:)];
		[request setDidFinishSelector:@selector(updateRequestFinished:)];
		
		[request startAsynchronous];
	}
}

- (void)updateRequestFailed:(ASIHTTPRequest *)aRequest {
	LLog(@"request failed");	
}

- (void)updateRequestFinished:(ASIHTTPRequest *)aRequest {
	LLog(@"request finished");
}
	
- (void)buttonWasSelected:(UIButton *)aButton {
	LLog(@"button was selected: %d", aButton.tag);
}


- (void)checkForGameStart {

	NSArray *players = [_teamData valueForKeyPath:@"team.players"];
	LLog(@"Checking for game start: %d players", [players count]);
	if ([players count] != 2) {
		_failCount = 0;
		_startGameTimer = [[NSTimer scheduledTimerWithTimeInterval:1.0f 
										 target:self 
									   selector:@selector(hasGameStarted) 
									   userInfo:nil 
										repeats:YES] retain];		
	}
	
	
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 101) {
		LLog(@"pop view controller");
		[self.navigationController popViewControllerAnimated:YES];
	}	
}

- (void)hasGameStarted {
	
	if (_failCount > 6) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" 
														message:@"Could not start the game due to errors. Please start a new game." 
													   delegate:self 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert setTag:101];
		[alert show];

		[_startGameTimer invalidate];
	}
	else {
		
		NSString *teamId = [_teamData valueForKeyPath:@"team.id"];
		NSString *getTeamUrlString = [NSString stringWithFormat:kGetTeamUrl, teamId];
		NSURL *getTeamUrl = [NSURL URLWithString:getTeamUrlString];
		
		ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:getTeamUrl];
		
		[request setDelegate:self];
		[request setDidFailSelector:@selector(teamRequestFailed:)];
		[request setDidFinishSelector:@selector(teamRequestFinished:)];	
		
		[request startAsynchronous];	
	}
}


- (void)teamRequestFailed:(ASIHTTPRequest *)aRequest {
	_failCount++;
}

- (void)teamRequestFinished:(ASIHTTPRequest *)aRequest {
	if ([aRequest responseHeaders]) {
		if ([aRequest responseStatusCode] != 422) {
			_failCount = 0;
			SBJsonParser *parser = [[SBJsonParser alloc] init];
			NSDictionary *teamObj = [parser objectWithData:[aRequest responseData]];
			NSArray *players = [teamObj valueForKeyPath:@"team.players"];
			
			LLog(@"checking for start: %d players", [players count]);
			
			if ([players count] > 1) {
				[_startGameTimer invalidate];
				[self startGame];
			}
		}
		else {
			_failCount++;
		}		
	}
	else {
		_failCount++;
	}
}


- (void)startGame {
	[_startGameTimer invalidate];

	// build player buttons
	
	UIImage *playerImageNormal = [UIImage imageNamed:@"player_button"];
	UIImage *playerImageActive = [UIImage imageNamed:@"player_button_active"];

	NSMutableArray *playerButtons = [[NSMutableArray alloc] init];
	for (int i = 0; i < 1; i++) {
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
	
	playerNameLabel.text = @"PLAYER 1";
	
	CGRect appFrame = [[UIScreen mainScreen] bounds];
	ButtonGroupView *buttonGroup = [[ButtonGroupView alloc] initWithFrame:CGRectMake(0.0f, 398.0f, 
																					 appFrame.size.width, 60.0f) 
																  buttons:playerButtons];
	buttonGroup.delegate = self;
	[self.view addSubview:buttonGroup];
	
	_waitOverlay.hidden = YES;
	
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

	[self checkForGameStart];

	teamNameLabel.text = [_teamData valueForKeyPath:@"team.name"];
	
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
	
	[_teamData release];
	[_startGameTimer release];
	
	
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

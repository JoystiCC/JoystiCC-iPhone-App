//
//  CreateGameViewController.m
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CreateGameViewController.h"

@interface CreateGameViewController (Private)
- (void)initialize;
- (void)setupViews;
@end

@implementation CreateGameViewController
@synthesize subheaderView;
@synthesize createGameHeaderLabel;
@synthesize gameNameHeaderLabel;
@synthesize teamNameHeaderLabel;
@synthesize pinHeaderLabel;
@synthesize confirmPinHeaderLabel;
@synthesize mainScrollView;
@synthesize gameNameField;
@synthesize teamNameField;
@synthesize pinField;
@synthesize confirmPinField;

#pragma mark Initialization

- (void)setupViews {

	
	self.navigationController.navigationBarHidden = NO;
	
	_showingKeyboard = NO;

	UIImage *headerImage = [UIImage imageNamed:@"header_bar"];
	
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor darkGrayColor];
    navBar.layer.contents = (id)headerImage.CGImage;
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(keyboardWillShow:) 
												 name:UIKeyboardWillShowNotification 
											   object:self.view.window];
	// register for keyboard notifications
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(keyboardWillHide:) 
												 name:UIKeyboardWillHideNotification 
											   object:self.view.window];
	
	
	UIImage *nextImageNormal = [UIImage imageNamed:@"next_button_small"];
	UIImage *nextImageHit = [UIImage imageNamed:@"next_button_small_hit"];
	
	
	UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	nextButton.frame = CGRectMake(0.0f, 0.0f, 70.0, 34.0f);
	
	nextButton.showsTouchWhenHighlighted = NO;
	
	nextButton.titleLabel.font = [UIFont fontWithName:@"silkscreen" size:10.0f];

	UIEdgeInsets buttonInsets = UIEdgeInsetsMake(4.0f, -10.0f, 0.0f, 0.0f);
	nextButton.titleEdgeInsets = buttonInsets;
	
	[nextButton setTitle:@"CREATE" forState:UIControlStateNormal];
	
	[nextButton setBackgroundImage:nextImageNormal forState:UIControlStateNormal];
	[nextButton setBackgroundImage:nextImageHit forState:UIControlStateSelected];
	[nextButton setBackgroundImage:nextImageHit forState:UIControlStateHighlighted];
	
	[nextButton addTarget:self action:@selector(nextButtonHit:) forControlEvents:UIControlEventTouchUpInside];
	
	UIBarButtonItem *nextButtonItem = [[UIBarButtonItem alloc] initWithCustomView:nextButton];
	
	self.navigationItem.rightBarButtonItem = nextButtonItem;

	
	
	subheaderView.borderColor = [UIColor whiteColor];
	subheaderView.borderWidth = 1.0f;
	
	// set up fonts
	createGameHeaderLabel.font = [UIFont fontWithName:@"chunkfive" size:14.0f];
	gameNameHeaderLabel.font = [UIFont fontWithName:@"silkscreen" size:12.0f];
	teamNameHeaderLabel.font = [UIFont fontWithName:@"silkscreen" size:12.0f];
	pinHeaderLabel.font = [UIFont fontWithName:@"silkscreen" size:12.0f];
	confirmPinHeaderLabel.font = [UIFont fontWithName:@"silkscreen" size:12.0f];
	
	[mainScrollView setContentSize:mainScrollView.bounds.size];
}

- (void)viewDidAppear:(BOOL)animated {
	[self setupViews];
}


#pragma mark - Keyboard notifications
	
- (void)keyboardWillShow:(NSNotification *)aNotification {
	
	LLog(@"keyboard will show ..");
	
	CGRect keyboardSize;
	NSDictionary* userInfo = [aNotification userInfo];
	NSValue *keyEndFrame = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
	[keyEndFrame getValue:&keyboardSize];
	
	LLog(@"key.width=%f, key.size=%f", keyboardSize.size.width, keyboardSize.size.height);
	
	_scrollOffset = mainScrollView.contentOffset;
	
	// Resize the scroll view to make room for the keyboard
	CGRect viewFrame = mainScrollView.frame;
	viewFrame.size.height -= keyboardSize.size.height;
	mainScrollView.frame = viewFrame;

	
	CGRect topFieldRect = gameNameField.frame;
	topFieldRect.origin.y += 140;
	[mainScrollView scrollRectToVisible:topFieldRect animated:YES];
	
	_showingKeyboard = YES;
	
}

- (void)keyboardWillHide:(NSNotification *)aNotification {

	if (!_showingKeyboard) return;
	
	CGSize bounds = [[UIScreen mainScreen] bounds].size;
	
	mainScrollView.frame = CGRectMake(0, 0, bounds.width, bounds.height);
	mainScrollView.contentOffset = _scrollOffset;
	
	_showingKeyboard = NO;

}


- (void)nextButtonHit:(id)sender {

	// get values
	NSString *gameName = gameNameField.text;
	NSString *pinValue = pinField.text;
	NSString *confirmPinValue = confirmPinField.text;
	
	[self.view resignFirstResponder];
	
	if (![pinValue isEqualToString:confirmPinValue]) {
		UIAlertView *pinAlert = [[UIAlertView alloc] initWithTitle:@"PIN Mismatch" 
														   message:@"Your PIN entry and confirmation do not match" 
														  delegate:nil cancelButtonTitle:@"OK" 
												 otherButtonTitles:nil];
		[pinAlert show];
	}
	else {
		// create the game 
		NSURL *createGameUrl = [NSURL URLWithString:kCreateGameUrl];
		ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:createGameUrl];
		
		[req setDelegate:self];
		[req setDidFinishSelector:@selector(createGameDidFinish:)];
		[req setDidFailSelector:@selector(createDidFail:)];
		
		[req setPostValue:gameName forKey:@"name"];
		[req setPostValue:pinValue forKey:@"password"];
		[req setPostValue:@"6" forKey:@"owner_id"];
		
		[req startAsynchronous];
	}
}

- (void)createDidFail:(ASIHTTPRequest *)aRequest {

	LLog(@"request failed: %@", [aRequest.error description]);
}

- (void)createGameDidFinish:(ASIHTTPRequest *)aRequest {

	if ([aRequest responseHeaders]) {
		if ([aRequest responseStatusCode] != 422) {

			NSString *teamName = teamNameField.text;
			NSString *pinValue = pinField.text;

			// parse game id
			SBJsonParser *parser = [[SBJsonParser alloc] init];
			NSDictionary *gameObj = [parser objectWithData:[aRequest responseData]];
			
			NSURL *createGameUrl = [NSURL URLWithString:kCreateTeamUrl];
			ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:createGameUrl];
			
			[req setDelegate:self];
			[req setDidFinishSelector:@selector(createTeamDidFinish:)];
			[req setDidFailSelector:@selector(createDidFail:)];
			
			[req setPostValue:teamName forKey:@"name"];
			[req setPostValue:pinValue forKey:@"game_password"];
			[req setPostValue:[gameObj valueForKeyPath:@"game.id"] forKey:@"game_id"];
			[req setPostValue:@"6" forKey:@"leader_id"];
			
			[req startAsynchronous];
			
		}
		else {
			LLog(@"failed!! 422");
		}
	}
}

- (void)createTeamDidFinish:(ASIHTTPRequest *)aRequest {

	if ([aRequest responseHeaders]) {
		if ([aRequest responseStatusCode] != 422) {
	
			LLog(@"game and team created ..");
			
			SBJsonParser *parser = [[SBJsonParser alloc] init];
			NSDictionary *teamData = [parser objectWithData:[aRequest responseData]];
			
			NSLog(@"%@", teamData);
			
			NSString *joinTeamUrlString = [NSString stringWithFormat:kJoinTeamUrl, @"7"];
			NSURL *joinTeamUrl = [NSURL URLWithString:joinTeamUrlString];
			
			ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:joinTeamUrl];
			

			NSLog(@"joining team %@", [teamData valueForKeyPath:@"team.id"]);
			
			[request setPostValue:@"32da39da51c742188b2572b65cf70fbda09e273dbb30e4fb83a617e09b271f80" forKey:@"access_key"];
			[request setPostValue:@"1111" forKey:@"game_password"];
			[request setPostValue:[teamData valueForKeyPath:@"team.id"] forKey:@"team_id"];
			
			[request setDelegate:self];
			[request setDidFinishSelector:@selector(joinTeamDidFinish:)];
			
			[request startAsynchronous];
			
			
			ControlUserViewController *controlViewController = [[ControlUserViewController alloc] 
																initWithTeamData:teamData];
			[self.navigationController pushViewController:controlViewController animated:YES];
		}
	}	
}

- (void)joinTeamDidFinish:(ASIHTTPRequest *)aRequest {
	LLog(@"added to team");
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupViews];
}

- (void)viewDidUnload
{
	[self setCreateGameHeaderLabel:nil];
	[self setSubheaderView:nil];
	[self setGameNameHeaderLabel:nil];
	[self setTeamNameHeaderLabel:nil];
	[self setPinHeaderLabel:nil];
	[self setConfirmPinHeaderLabel:nil];
	[self setMainScrollView:nil];
	[self setGameNameField:nil];
	[self setTeamNameField:nil];
	[self setPinField:nil];
	[self setConfirmPinField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Memory management

- (void)dealloc {
	[createGameHeaderLabel release];
	[subheaderView release];
	[gameNameHeaderLabel release];
	[teamNameHeaderLabel release];
	[pinHeaderLabel release];
	[confirmPinHeaderLabel release];
	[mainScrollView release];
	[gameNameField release];
	[teamNameField release];
	[pinField release];
	[confirmPinField release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

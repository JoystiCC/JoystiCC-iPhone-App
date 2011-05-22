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

	_showingKeyboard = NO;

}


- (void)nextButtonHit:(id)sender {

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

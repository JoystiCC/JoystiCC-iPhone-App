//
//  MoveViewController.m
//  joysticc_ios
//
//  Created by Luke Freeman on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoveViewController.h"


@implementation MoveViewController
@synthesize endGameButton;



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

	endGameButton.titleLabel.font = [UIFont fontWithName:@"silkscreen" size:12.0f];
	
}

- (void)viewDidUnload
{
	[self setEndGameButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)dealloc
{
	[endGameButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


@end

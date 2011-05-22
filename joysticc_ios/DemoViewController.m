//
//  DemoViewController.m
//  joysticc_ios
//
//  Created by Luke Freeman on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DemoViewController.h"


@implementation DemoViewController
@synthesize createButton;
@synthesize joinButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [createButton release];
    [joinButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.navigationController.navigationBarHidden = YES;
	
	createButton.titleLabel.font = [UIFont fontWithName:@"silkscreen" size:12.0f];
	joinButton.titleLabel.font = [UIFont fontWithName:@"silkscreen" size:12.0f];
	
}

- (void)viewDidUnload
{
    [self setCreateButton:nil];
    [self setJoinButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)doCreate:(id)sender {

	CreateGameViewController *createController = [[CreateGameViewController alloc] init];
	[self.navigationController pushViewController:createController animated:YES];

}

- (IBAction)doJoin:(id)sender {
	
	MoveViewController *moveController = [[MoveViewController alloc] init];
	[self.navigationController pushViewController:moveController animated:YES];
}

@end

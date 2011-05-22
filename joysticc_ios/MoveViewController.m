//
//  MoveViewController.m
//  joysticc_ios
//
//  Created by Luke Freeman on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MoveViewController.h"

@interface MoveViewController (Private)
- (void)speakDirection:(NSInteger)aDirection;
@end


@implementation MoveViewController
@synthesize waitLabel = _waitLabel;



#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	_waitTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f 
												  target:self 
												selector:@selector(checkForCommand) 
												userInfo:nil repeats:YES];
	_lastCommandDate = nil;
	
	self.waitLabel.font = [UIFont fontWithName:@"silkscreen" size:14.0f];
	
}

- (void)checkForCommand {
	NSString *getPlayerUrlString = [NSString stringWithFormat:kGetPlayerUrl, @"7"];
	NSURL *getPlayerUrl = [NSURL URLWithString:getPlayerUrlString];
	
	ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:getPlayerUrl];
	
	[request setDelegate:self];
	[request setDidFailSelector:@selector(playerRequestFailed:)];
	[request setDidFinishSelector:@selector(playerRequestFinished:)];
	
	[request startAsynchronous];
	
}

- (void)playerRequestFailed:(ASIHTTPRequest *)aRequest {
	
}

- (void)playerRequestFinished:(ASIHTTPRequest *)aRequest {

	NSLog(@"checking for new direction ...");
	
	SBJsonParser *parser = [[SBJsonParser alloc] init];
	NSDictionary *playerObj = [parser objectWithData:[aRequest responseData]];
	
	//NSLog (@"playerObj = %@", playerObj);
	
	NSString *lastUpdated = [playerObj valueForKeyPath:@"player.updated_at"];
	
	NSLog (@"%@, %@", _lastCommandDate, lastUpdated);
	
	if (_lastCommandDate != nil && ![lastUpdated isEqualToString:_lastCommandDate]) {
		NSString *direction = [playerObj valueForKeyPath:@"player.direction"];
		NSInteger directionInt = [direction intValue];
		[self speakDirection:directionInt];
	}

	_lastCommandDate = [lastUpdated retain];
	
}

- (void)speakDirection:(NSInteger)aDirection {
	
	if (aDirection == 0) return;
	
	NSLog(@"move in direction: %d", aDirection);
	
	NSError *error;

	NSString *filePart = nil;
	switch (aDirection) {
		case kUpKeyCode:
			filePart = @"2fwd.mp3";
			break;

		case kDownKeyCode:
			filePart = @"2back.mp3";
			break;

			
		case kLeftKeyCode:
			filePart = @"2left.mp3";
			break;

			
		case kRightKeyCode:
			filePart = @"2right.mp3";
			break;
			
			
		case kEnterKeyCode:
			filePart = @"congrats.mp3";
			break;
			
			
		default:
			break;
	}
	
	NSString *fileUrl;
	if (filePart != nil) {
		fileUrl = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], filePart];
	}
	
	NSURL *audioUrl = [NSURL fileURLWithPath:fileUrl];
	AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioUrl error:&error];
	audioPlayer.numberOfLoops = 0;
	if (audioPlayer != nil) {	
		[audioPlayer prepareToPlay];
		[audioPlayer play];
	}

	NSString *urlString = [NSString stringWithFormat:kGetPlayerUrl, @"7"];
	NSURL *requestUrl = [NSURL URLWithString:urlString];
	ASIFormDataRequest *request = [[ASIFormDataRequest alloc] initWithURL:requestUrl];
	
	[request setRequestMethod:@"PUT"];
	
	NSString *accessKey = @"32da39da51c742188b2572b65cf70fbda09e273dbb30e4fb83a617e09b271f80";
	[request setPostValue:@"0" forKey:@"direction"];
	[request setPostValue:accessKey forKey:@"access_key"];
	
	[request setDelegate:self];
	[request setDidFailSelector:@selector(updateRequestFailed:)];
	[request setDidFinishSelector:@selector(updateRequestFinished:)];
	
	[request startAsynchronous];
	
}

- (void)viewDidUnload
{
	[self setWaitLabel:nil];
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
	[_waitLabel release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


@end

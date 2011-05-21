//
//  PinViewController.m
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PinViewController.h"

NSInteger const kPinLength = 4;
NSInteger const kPinEntryWidth = 61;
NSInteger const kPinEntryHeight = 53;
NSInteger const kPinEntryGap = 8;

@interface PinViewController (Private)
- (void)initialize;
@end

@implementation PinViewController

@synthesize delegate=_delegate;

#pragma mark Initialization
- (void)initialize {
	
	// render the pin entry layout
	float screenWidth = [[UIScreen mainScreen] applicationFrame].size.width;
	float startX = (screenWidth - ((kPinLength * (kPinEntryWidth + kPinEntryGap)) - kPinEntryGap)) / 2;
	
	UILabel *pinHeader = [[UILabel alloc] initWithFrame:CGRectMake(startX, 120 - 26, 200.0f, 22.0f)];
	pinHeader.text = @"Enter your PIN";
	pinHeader.font = [UIFont systemFontOfSize:10.0f];
	pinHeader.textColor = [UIColor darkGrayColor];
	[self.view addSubview:pinHeader];
	
	
	// master pin entry
	_masterPinEntry = [[UITextField alloc] initWithFrame:CGRectZero];
	_masterPinEntry.keyboardType = UIKeyboardTypeNumberPad;
	_masterPinEntry.hidden = YES;
	_masterPinEntry.delegate = self;
	[self.view addSubview:_masterPinEntry];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(masterPinDidChange:)
												 name:UITextFieldTextDidChangeNotification
											   object:_masterPinEntry];
		
	
	// visual representation
	_pinEntries = [[[NSMutableArray alloc] init] retain];
	for (int i = 0; i < kPinLength; i++) {			
		
		CGRect entryFrame = CGRectMake(startX, 120.0f, kPinEntryWidth, kPinEntryHeight);
		
		UITextField *pinEntry = [[UITextField alloc] initWithFrame:entryFrame];
		pinEntry.borderStyle = UITextBorderStyleNone;
		pinEntry.background = [UIImage imageNamed:@"pin_entry"];
		pinEntry.font = [UIFont boldSystemFontOfSize:32.0f];
		pinEntry.textAlignment = UITextAlignmentCenter;
		pinEntry.tag = i + 1;
		pinEntry.keyboardType = UIKeyboardTypeNumberPad;
		pinEntry.userInteractionEnabled = NO;
		pinEntry.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		
		[self.view addSubview:pinEntry];
		[_pinEntries addObject:pinEntry];
		[pinEntry release];
		
		startX += (kPinEntryWidth + kPinEntryGap);
	}
	

	[_masterPinEntry becomeFirstResponder];
	
}

- (id)init {
	
	self = [super init];
	if (self) {
		[self initialize];
	}
	
	return self;
}

- (void)updatePINValues {

	NSString *pinText = _masterPinEntry.text;
	NSInteger curLength = [pinText length];
	
	for (int i = 0; i < kPinLength; i++) {
		UITextField *textField = (UITextField *)[_pinEntries objectAtIndex:i];
		if (i < curLength) {
			NSRange range = NSMakeRange(i, 1);
			NSString *substring = [pinText substringWithRange:range];
			textField.text = substring;
		}
		else {
			textField.text = @"";
		}
	}
}

#pragma mark - Callbacks
- (void)masterPinDidChange:(NSNotification *)aNotification {
	
	UITextField *sendObj = [aNotification object];
	
	// only do this if master pin sent notification
	if (sendObj == _masterPinEntry ) {
		NSString *pinText = sendObj.text;
		NSInteger curLength = [pinText length];
		
		[self updatePINValues];
		if (curLength == kPinLength) {
			[self.delegate pinValidationRequested:pinText];
		}
	}
}

- (BOOL)textField:(UITextField *)aTextField shouldChangeCharactersInRange:(NSRange)aRange 
		replacementString:(NSString *)aString {

	if (aTextField == _masterPinEntry) {
		NSUInteger newLength = [aTextField.text length] + [aString length] - aRange.length;
		return (newLength > 4 ? NO : YES);
	}
	
	return YES;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


#pragma mark - View configuration
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - Memory management
- (void)dealloc {
    [super dealloc];

	// clean up
	[_pinEntries release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

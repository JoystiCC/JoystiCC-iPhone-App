//
//  PinViewController.h
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinViewControllerDelegate.h"


extern NSInteger const kPinLength;
extern NSInteger const kPinEntryWidth;
extern NSInteger const kPinEntryHeight;
extern NSInteger const kPinEntryGap;

@interface PinViewController : UIViewController<UITextFieldDelegate> {
    
	id<PinViewControllerDelegate> _delegate;
	NSMutableArray *_pinEntries;
	
	UITextField *_masterPinEntry;
	NSUInteger _pin;
}

@property (nonatomic, retain) id<PinViewControllerDelegate> delegate;

@end

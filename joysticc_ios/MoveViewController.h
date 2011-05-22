//
//  MoveViewController.h
//  joysticc_ios
//
//  Created by Luke Freeman on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <AVFoundation/AVAudioPlayer.h>
#import <UIKit/UIKit.h>

#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "JSON.h"

@interface MoveViewController : UIViewController {
	NSTimer *_waitTimer;
	
	NSString *_lastCommandDate;
	UILabel *_waitLabel;
}
@property (nonatomic, retain) IBOutlet UILabel *waitLabel;

@end

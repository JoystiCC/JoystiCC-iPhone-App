//
//  DemoViewController.h
//  joysticc_ios
//
//  Created by Luke Freeman on 5/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CreateGameViewController.h"
#import "MoveViewController.h"


@interface DemoViewController : UIViewController {
    
	UIButton *createButton;
	UIButton *joinButton;
}

- (IBAction)doCreate:(id)sender;
- (IBAction)doJoin:(id)sender;

@property (nonatomic, retain) IBOutlet UIButton *createButton;
@property (nonatomic, retain) IBOutlet UIButton *joinButton;

@end

//
//  ControlUserViewController.m
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ControlUserViewController.h"


@interface ControlUserViewController (Private)
- (void)initialize;
@end

@implementation ControlUserViewController


#pragma mark Initialization
- (void)initialize {
	
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		[self initialize];
	}
    return self;
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
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


#pragma mark - Memory management
- (void)dealloc {
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

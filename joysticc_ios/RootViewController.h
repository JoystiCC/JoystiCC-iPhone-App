//
//  RootViewController.h
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const kGameInfoCellId;

@interface RootViewController : UITableViewController {

	NSMutableArray *_currentGames;
	NSMutableArray *_pastGames;
	
}


@end

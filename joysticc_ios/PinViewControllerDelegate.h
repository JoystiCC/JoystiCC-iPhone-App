//
//  PinViewControllerDelegate.h
//  joysticc_ios
//
//  Created by Luke Freeman on 5/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PinViewControllerDelegate <NSObject>

- (void)pinValidationRequested:(NSString *)aPin;
- (void)pinCancelRequested;

@end

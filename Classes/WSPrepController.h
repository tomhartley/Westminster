//
//  WSPrepController.h
//  Westminster
//
//  Created by Tom Hartley on 10/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSPrep.h"
#import "PullRefreshTableViewController.h"

@interface WSPrepController : PullRefreshTableViewController {
    NSArray *preps;
}

-(void)updatePreps;
-(IBAction)signOut;
@end

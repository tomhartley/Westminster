//
//  WSPrepController.h
//  Westminster
//
//  Created by Tom Hartley on 10/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSPrep.h"

@interface WSPrepController : UITableViewController {
    NSArray *preps;
}

-(void)updatePreps;
-(IBAction)refresh;
-(IBAction)signOut;
@end

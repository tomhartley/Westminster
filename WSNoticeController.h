//
//  WSNoticeController.h
//  Westminster
//
//  Created by Tom Hartley on 06/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSNoticeCell.h"
#import "WSNotice.h"

@interface WSNoticeController : UIViewController {
    NSArray *notices;
	IBOutlet UITableView *tableView;
	IBOutlet UINavigationBar *navBar;
}

-(void)updateNotices;
-(IBAction)refresh;
-(int)getHeightForRow:(int)row;
@end

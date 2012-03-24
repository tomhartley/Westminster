//
//  WSTimetableController.h
//  Westminster
//
//  Created by Tom Hartley on 17/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "THPagedScrollView.h"
#import "WSDataManager.h"
#import "WSTimetableTableViewDelegate.h"

@interface WSTimetableController : UIViewController <THPagedScrollViewDelegate> {
	NSArray *timetableDays;
	NSMutableArray *tableViews;
	NSMutableArray *delegates;
	IBOutlet THPagedScrollView *pagedScrollView;
	IBOutlet UILabel *dateLabel;
}
- (void)updateTableViews; //update with new data when its available (unlikely...)
- (void)createTableViews; //set up the table views at the beginning
- (void)updateTimetable; //Called when the timetable changes (eg a user logs out)
- (void)updateDate; //Called when a page changes, requiring an update to the label displaying the day of the week.


@end

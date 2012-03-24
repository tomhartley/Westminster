//
//  WSTimetableTableViewDelegate.h
//  Westminster
//
//  Created by Tom Hartley on 23/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSTimetableDay.h"
#import "WSLesson.h"
#import "WSClassCell.h"

@interface WSTimetableTableViewDelegate : NSObject <UITableViewDelegate, UITableViewDataSource> {
	WSTimetableDay *timetableDay;
}

@property (nonatomic, retain) WSTimetableDay *timetableDay;

@end

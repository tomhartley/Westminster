//
//  WSTimetableTableViewDelegate.m
//  Westminster
//
//  Created by Tom Hartley on 23/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WSTimetableTableViewDelegate.h"

@implementation WSTimetableTableViewDelegate
@synthesize timetableDay;

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ClassCell";
    
    WSClassCell *cell = (WSClassCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"WSClassCell" bundle:nil];    
		cell = (WSClassCell*)temporaryController.view;
		[temporaryController release];
	}
	
	NSDictionary *dict = [timetableDay lessons];
	WSLesson *lesson = [dict objectForKey:[NSNumber numberWithInteger:indexPath.row+1]];
	[cell setLesson:lesson];
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch ([timetableDay isShort]) {
		case YES:
			return 5; //Tues, thurs & sat
			break;
		default:
			return 7; //Mon, wed & fri
			break;
	}
}
@end

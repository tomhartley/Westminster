//
//  WSTimetableTableViewDelegate.m
//  Westminster
//
//  Created by Tom Hartley on 23/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WSTimetableTableViewDelegate.h"

@implementation WSTimetableTableViewDelegate
@synthesize timetableDay, isToday, tableView;

-(id)init {
	[super init];
	
	currentLesson = -1;
	timer = [[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(updateCurrentLesson:) userInfo:nil repeats:YES] retain];
	[self updateCurrentLesson:nil];
	return self;
}

-(void)setTimetableDay:(WSTimetableDay *)newTimetableDay {
	[timetableDay autorelease];
	[newTimetableDay retain];
	timetableDay = newTimetableDay;
	[self updateCurrentLesson:nil];
}

-(UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ClassCell";
    
    WSClassCell *cell = (WSClassCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
		UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"WSClassCell" bundle:nil];    
		cell = (WSClassCell*)temporaryController.view;
		[temporaryController release];
	}
	if (indexPath.row == currentLesson) {
		cell.contentView.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.647 alpha:1];
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

-(void)updateCurrentLesson:(NSTimer *)aTimer { //Super ugly, needs to be rewritten to work with NSDate, NSCalendar and NSDateComponents...
	currentLesson = -1;
	if (isToday) {
		NSDate *today = [NSDate date];
		NSCalendar *gregorian = [[NSCalendar alloc]
								 initWithCalendarIdentifier:NSGregorianCalendar];
		NSDateComponents *components =
		[gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:today];
		
		NSInteger hour = [components hour];
		NSInteger minute = [components minute];
		[gregorian autorelease];
		NSInteger currentMinute = hour*60+minute;
		for (int i = 0; i<[[timetableDay lessons] count]; i++) {
			WSLesson *lesson = [[timetableDay lessons] objectForKey:[NSNumber numberWithInteger:i+1]];
			WSTime startTime = lesson.startTime;
			WSTime endTime = lesson.endTime;
			NSInteger startMinute = startTime.hours*60+startTime.minutes-5;
			NSInteger endMinute = endTime.hours*60+endTime.minutes;
			WSClassCell *cell = (WSClassCell*)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
			cell.contentView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
			if (currentMinute>startMinute && currentMinute<=endMinute) {
				currentLesson = i;
				cell.contentView.backgroundColor = [UIColor colorWithRed:1 green:0.941 blue:0.647 alpha:1];
				break;
			}
		}
	}
}

-(void)scrollToCurrentLesson {
	if (currentLesson>-1) {
		[tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currentLesson inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
	}
}

-(void)dealloc {
	[timer invalidate];
	[super dealloc];
}

@end

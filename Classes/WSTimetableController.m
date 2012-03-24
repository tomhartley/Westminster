//
//  WSTimetableController.m
//  Westminster
//
//  Created by Tom Hartley on 17/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSTimetableController.h"


@implementation WSTimetableController

- (void)viewDidLoad
{
	[super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTimetable) name:@"WSTimetableUpdatedNotification" object:nil];
	timetableDays = [[WSDataManager sharedInstance] currentTimetable];
	[timetableDays retain];
	tableViews = [[NSMutableArray alloc] init];
	delegates = [[NSMutableArray alloc] init];
	[NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(createTableViews) userInfo:nil repeats:NO];
}

- (void)updateTableViews {
	//For each table view
	for (int i = 0; i<6; i++) {
		UITableView *tableView = [tableViews objectAtIndex:i];
		WSTimetableTableViewDelegate *delegate = (WSTimetableTableViewDelegate *) tableView.delegate;
		//Set its delegate's timetable to the updated version
		delegate.timetableDay = [timetableDays objectAtIndex:i];
		//Tell the table view to reload its data
		[tableView reloadData];
	}
	[self updateDate];
}

- (void)createTableViews {
	//Create table views if neccesary
	if (![tableViews count]) {
		for (int i = 0; i<6; i++) {
			UITableView *tableView =[[UITableView alloc] init];
			//tableView.separatorColor = [UIColor lightGrayColor];
			//tableView.backgroundColor = [UIColor darkGrayColor];
			tableView.layer.cornerRadius=7;
			tableView.rowHeight = 145.0;
			WSTimetableTableViewDelegate *delegate = [[WSTimetableTableViewDelegate alloc] init];
			delegate.timetableDay= [timetableDays objectAtIndex:i]; 
			tableView.dataSource = delegate;
			tableView.delegate = delegate;
            tableView.allowsSelection = NO;
			[tableViews addObject:tableView];
			[delegates addObject:delegate];
			[tableView release];
			[delegate release];
		}
	}
	[self updateDate];
	[pagedScrollView setViews:tableViews];
	pagedScrollView.delegate = self;
}

- (void)updateTimetable {
	[timetableDays release];
	timetableDays = [[WSDataManager sharedInstance] currentTimetable];
	[timetableDays retain];
	[self updateTableViews];
}

- (void)updateDate {
	@try {
		dateLabel.text = [[timetableDays objectAtIndex:pagedScrollView.currentPage] dateDescription];
	}
	@catch (NSException *exception) {
		dateLabel.text = @"";
	}
}

-(void)pagedScrollView:(THPagedScrollView *)pagedScrollView didScrollToPageIndex:(NSUInteger)index {
	[self updateDate];
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end

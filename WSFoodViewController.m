//
//  WSFoodViewController.m
//  Westminster
//
//  Created by Tom Hartley on 11/10/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "WSFoodViewController.h"
#import "WSDataManager.h"
#import "WSDataFetcher.h"
#import "WSAuthManager.h"
#import <TapkuLibrary/TapkuLibrary.h>
#import "WSAuthController.h"
#import "GANTracker.h"


@implementation WSFoodViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	self.view.autoresizesSubviews = YES; 
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMeals) name:@"WSFoodUpdatedNotification" object:nil];
	weekFoods = [[WSDataManager sharedInstance] currentFood];
	[weekFoods retain];
	tableViews = [[NSMutableArray alloc] init];
	delegates = [[NSMutableArray alloc] init];
	[NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(createTableViews) userInfo:nil repeats:NO];
}

-(void)updateTableViews {
	//For each table view
	for (int i = 0; i<7; i++) {
		UITableView *tableView = [tableViews objectAtIndex:i];
		WSMealsTableViewDelegate *delegate = (WSMealsTableViewDelegate *) tableView.delegate;
		//Set its delegate's food to the updated version
		if ([weekFoods count]>i) {
			delegate.foodDay = [weekFoods objectAtIndex:i];
		} else {
			delegate.foodDay = nil;
		}
		//Tell the table view to reload its data
		[tableView reloadData];
	}
	[self updateDate];
}

-(void)createTableViews {
	//Create table views if neccesary
	if (![tableViews count]) {
		for (int i = 0; i<7; i++) {
			UITableView *tableView =[[UITableView alloc] init];
			tableView.separatorColor = [UIColor lightGrayColor];
			tableView.backgroundColor = [UIColor darkGrayColor];
			tableView.layer.cornerRadius=7;
			WSMealsTableViewDelegate *delegate = [[WSMealsTableViewDelegate alloc] init];
			delegate.foodDay = [weekFoods objectAtIndex:i]; 
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

-(void)updateMeals {
	[weekFoods release];
	weekFoods = [[WSDataManager sharedInstance] currentFood];
	[weekFoods retain];
	[self updateTableViews];

}
/*
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	[self layoutSubviews];
}
*/
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[[GANTracker sharedTracker] trackPageview:@"/foodController"
									withError:nil];
}

- (void)updateDate {
	@try {
		dateLabel.text = [[weekFoods objectAtIndex:pagedScrollView.currentPage] dateDescription];

	}
	@catch (NSException *exception) {
		dateLabel.text = @"";
	}
}

-(void)pagedScrollView:(THPagedScrollView *)pagedScrollView didScrollToPageIndex:(NSUInteger)index {
	[self updateDate];
}

- (IBAction)refreshFood:(id)sender {
	[[WSDataFetcher sharedInstance] updateFood];
	[[GANTracker sharedTracker] trackEvent:@"food"
									action:@"refresh"
									 label:nil
									 value:-1
								 withError:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		return YES;
	}
#endif
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [dateLabel release];
	[tableViews release];
	[delegates release];
    [super dealloc];
}

@end


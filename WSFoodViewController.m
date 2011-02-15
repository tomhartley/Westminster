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
	[NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector:@selector(layoutSubviews) userInfo:nil repeats:NO];
}

-(void)updateTableViews {
	//For each table view
	for (int i = 0; i<7; i++) {
		UITableView *tableView = [tableViews objectAtIndex:i];
		MealsTableViewDelegate *delegate = tableView.delegate;
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

-(void)layoutSubviews {
	//Create table views if neccesary
	if ([tableViews count]==0) {
		for (int i = 0; i<7; i++) {
			UITableView *tableView =[[UITableView alloc] init];
			tableView.separatorColor = [UIColor lightGrayColor];
			tableView.backgroundColor = [UIColor darkGrayColor];
			tableView.layer.cornerRadius=7;
			MealsTableViewDelegate *delegate = [[MealsTableViewDelegate alloc] init];
			tableView.dataSource = delegate;
			tableView.delegate = delegate;
			[tableViews addObject:tableView];
			[delegates addObject:delegate];
			[scrollView addSubview:tableView];
			[tableView release];
			[delegate release];
		}
	}
	//Get values for setting up
	int w = scrollView.frame.size.width;
	int h = scrollView.frame.size.height;
	int margins = w/20;
	scrollView.contentSize = CGSizeMake(w*7, h);
	
	for (int i = 0; i<7; i++) {
		//Get table view
		UITableView *tableView = [tableViews objectAtIndex:i];
		//Resize it
		tableView.frame = CGRectMake(w*i+margins,0,w-(margins*2),h);
	}
	//Scroll back to correct page
	int page = pageControl.currentPage;
	[self scrollToPage:page];
}

-(void)updateMeals {
	[weekFoods release];
	weekFoods = [[WSDataManager sharedInstance] currentFood];
	[weekFoods retain];
	[self updateTableViews];

}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration {
	[self layoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[self layoutSubviews];
	[[GANTracker sharedTracker] trackPageview:@"/foodController"
									withError:nil];
}

- (IBAction)pageControlChanged:(UIPageControl *)sender {
	[self scrollToPage:sender.currentPage];
}

- (void)updateDate {
	@try {
		dateLabel.text = [[weekFoods objectAtIndex:pageControl.currentPage] dateDescription];

	}
	@catch (NSException *exception) {
		dateLabel.text = @"";
	}
}

- (void)scrollToPage:(int)pageNumber {
	int w = scrollView.frame.size.width;
	int h = scrollView.frame.size.height;
	[scrollView scrollRectToVisible:CGRectMake(w*pageNumber,0,w,h) animated:YES];
	[self updateDate];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)theScrollView {
	int x = scrollView.contentOffset.x;
	pageControl.currentPage = x/scrollView.frame.size.width;
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

- (IBAction)signOut:(id)sender {
	[[WSAuthManager sharedInstance] signOut];
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Signed Out"];
	WSAuthController *authController = [[WSAuthController alloc] initWithNibName:@"WSAuthController" bundle:nil];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[authController setModalPresentationStyle:UIModalPresentationFormSheet];
	}
#endif
    [self.parentViewController presentModalViewController:authController animated:YES];
	[authController autorelease];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
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
    [scrollView release];
    [pageControl release];
    [dateLabel release];
	[tableViews release];
	[delegates release];
    [super dealloc];
}


@end


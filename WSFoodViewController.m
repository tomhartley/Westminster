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

@implementation WSFoodViewController


- (void)viewDidLoad {
	[super viewDidLoad];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMeals) name:@"WSFoodUpdatedNotification" object:nil];
	weekFoods = [[WSDataManager sharedInstance] currentFood];
	[weekFoods retain];
	delegatz = [[NSMutableArray alloc] init];
	tableViews = [[NSMutableArray alloc] init];
	[NSTimer scheduledTimerWithTimeInterval:0.0001 target:self selector:@selector(setUpScrollView) userInfo:nil repeats:NO];
}

 
-(void)setUpScrollView {
	NSLog(@"%@",@"setUpScrollView reporting for duty...");
	//Now set up the scroll view
	int w = scrollView.frame.size.width;
	int h = scrollView.frame.size.height;
	NSLog(@"%d",h);
	scrollView.contentSize = CGSizeMake(w*7, h);
	//Add subviews to it
	int margins = w/15;
	for (int i = 0; i<7;i++) {
		UITableView *tableView =[[UITableView alloc] init];
		//tableView.frame = CGRectMake(w*i+10,10,w-20,h-70);
		tableView.frame = CGRectMake(w*i+margins,margins,w-(margins*2),h-(margins*2));
		tableView.separatorColor = [UIColor lightGrayColor];
		tableView.backgroundColor = [UIColor darkGrayColor];
		MealsTableViewDelegate *delegate;
		@try {
			delegate = [[MealsTableViewDelegate alloc] initWithFood:[weekFoods objectAtIndex:i]];
		}
		@catch (NSException *exception) {
			delegate = [[MealsTableViewDelegate alloc] initWithFood:nil];
		}
		tableView.dataSource = delegate;
		tableView.delegate = delegate;
		tableView.layer.cornerRadius=7;
		[delegatz addObject:delegate];
		[scrollView addSubview:tableView];
		[tableViews addObject:tableView];
		[tableView release];
		[delegate release];
	}
	[self updateDate];
}

-(void)updateMeals {
	[weekFoods release];
	weekFoods = [[WSDataManager sharedInstance] currentFood];
	[weekFoods retain];
	[self updateDate];
	for (UITableView *tView in [scrollView subviews]) {
		[tView removeFromSuperview];
		if ([tView isMemberOfClass:[UITableView class]]) {
			tView.delegate = nil;
			tView.dataSource = nil;
		}
	}
	[tableViews removeAllObjects];
	[delegatz removeAllObjects];
	[self setUpScrollView];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	for (UITableView *tView in [scrollView subviews]) {
		[tView removeFromSuperview];
		if ([tView isMemberOfClass:[UITableView class]]) {
			tView.delegate = nil;
			tView.dataSource = nil;
		}
	}
	[tableViews removeAllObjects];
	[delegatz removeAllObjects];
	[self setUpScrollView];
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
	[delegatz release];
    [super dealloc];
}


@end


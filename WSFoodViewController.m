//
//  WSFoodViewController.m
//  Westminster
//
//  Created by Tom Hartley on 11/10/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "WSFoodViewController.h"


@implementation WSFoodViewController

#pragma mark -
#pragma mark Memory management


- (void)viewDidLoad {
	[super viewDidLoad];
	WSDataFetcher *fetcher = [[WSDataFetcher alloc] init];
	weekFoods = [fetcher nextMeals];
	[weekFoods retain];
	[fetcher release];
	delegatz = [[NSMutableArray alloc] init];
	tableViews = [[NSMutableArray alloc] init];
	[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(setUpScrollView) userInfo:nil repeats:NO];
}

-(void)setUpScrollView {
	//Now set up the scroll view
	int w = scrollView.frame.size.width;
	int h = scrollView.frame.size.height;
	NSLog(@"%d",h);
	scrollView.contentSize = CGSizeMake(w*[weekFoods count], h);
	//Add subviews to it
	int margins = w/15;
	for (int i = 0; i<[weekFoods count];i++) {
		UITableView *tableView =[[UITableView alloc] init];
		//tableView.frame = CGRectMake(w*i+10,10,w-20,h-70);
		tableView.frame = CGRectMake(w*i+margins,margins,w-(margins*2),h-(margins*2));
		tableView.separatorColor = [UIColor lightGrayColor];
		tableView.backgroundColor = [UIColor darkGrayColor];
		MealsTableViewDelegate *delegate = [[MealsTableViewDelegate alloc] initWithFood:[weekFoods objectAtIndex:i]];
		tableView.dataSource = delegate;
		tableView.delegate = delegate;
		tableView.layer.cornerRadius=5;
		[delegatz addObject:delegate];
		[scrollView addSubview:tableView];
		[tableViews addObject:tableView];
		[tableView release];
		[delegate release];
	}
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
	dateLabel.text = [[weekFoods objectAtIndex:pageControl.currentPage] dateDescription];
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


//
//  WSNoticeController.m
//  Westminster
//
//  Created by Tom Hartley on 06/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSNoticeController.h"
#import "WSDataManager.h"
#import "WSDataFetcher.h"
#import "GANTracker.h"


@implementation WSNoticeController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		
    }
    return self;
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
	return [notices count];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PrepCell";
    
    WSNoticeCell *cell = (WSNoticeCell*)[aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		cell = [[WSNoticeCell alloc] init];
		//CAGradientLayer *gradient = [CAGradientLayer layer];
		//gradient.frame = CGRectMake(0, 0, 1200, 160);
		//gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor lightGrayColor] CGColor], nil];
		//[cell.layer insertSublayer:gradient atIndex:0];
	}
	
	cell.description.text = [[notices objectAtIndex:indexPath.row] description];
	cell.title.text = [[notices objectAtIndex:indexPath.row] title];
	cell.expanded = [[notices objectAtIndex:indexPath.row] expanded];
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	//cell.backgroundColor = [UIColor lightGrayColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	//return 200;
	return [self getHeightForRow:indexPath.row];
}

#pragma mark - View lifecycle

-(void)viewDidAppear:(BOOL)animated {
	[[GANTracker sharedTracker] trackPageview:@"/noticeController"
									withError:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self updateNotices];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateNotices) name:@"WSNoticesUpdatedNotification" object:nil];
	tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

-(void)updateNotices {
	[notices release];
	notices = [[WSDataManager sharedInstance] currentNotices];
	[notices retain];
	//self.parentViewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",[notices count]];
	[tableView reloadData];
}

-(IBAction)refresh {
	[[GANTracker sharedTracker] trackEvent:@"notices"
									action:@"refresh"
									 label:nil
									 value:-1
								 withError:nil];
	[[WSDataFetcher sharedInstance] updateNotices];
}

//Components of a row, height wise: 5 px blank, height + 10 +10at top and bottom for bg, 5 px, description,5px
-(int)getHeightForRow:(int)row {
	//if (!expanded) return 55;
	int width = tableView.frame.size.width - 20;
	//Get the height of the title (5 px margin above + below)
    CGSize titleSize = [[[notices objectAtIndex:row] title] sizeWithFont:[UIFont systemFontOfSize:17]constrainedToSize:CGSizeMake(width,10000) lineBreakMode:UILineBreakModeWordWrap];
	if (![[notices objectAtIndex:row] expanded]) {
		return titleSize.height+30;
	}
	//5 px + at top and bottom
    CGSize descriptionSize = [[[notices objectAtIndex:row] description] sizeWithFont:[UIFont systemFontOfSize:14]constrainedToSize:CGSizeMake(width,10000) lineBreakMode:UILineBreakModeWordWrap];
	return descriptionSize.height+35+titleSize.height;
}

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[[notices objectAtIndex:indexPath.row] toggleExpansion];
	[(WSNoticeCell *)[aTableView cellForRowAtIndexPath:indexPath] setExpanded:[[notices objectAtIndex:indexPath.row] expanded]];
	[tableView beginUpdates];
	[tableView endUpdates];
	[tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	[[GANTracker sharedTracker] trackEvent:@"notices"
									action:@"expanded"
									 label:nil
									 value:-1
								 withError:nil];
}
@end

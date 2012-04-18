//
//  WSPrepController.m
//  Westminster
//
//  Created by Tom Hartley on 10/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSPrepController.h"
#import "WSPrepViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "WSDataManager.h"
#import "NSDate+Helper.h"
#import "WSDataFetcher.h"
#import "WSAuthManager.h"
#import "WSAuthController.h"
#import "WSDetailPrep.h"
#import "GANTracker.h"

@implementation WSPrepController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)refresh {
	[[GANTracker sharedTracker] trackEvent:@"prep"
									action:@"refresh"
									 label:nil
									 value:-1
								 withError:nil];
	[[WSDataFetcher sharedInstance] updatePreps];
}

- (IBAction)signOut {
	[[WSAuthManager sharedInstance] signOut];
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Signed Out"];
	WSAuthController *authController = [[WSAuthController alloc] initWithNibName:@"WSAuthController" bundle:nil];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[authController setModalPresentationStyle:UIModalPresentationFormSheet];
	}
#endif
	[self.parentViewController.parentViewController presentModalViewController:authController animated:YES];
	[authController autorelease];
}


-(void)updatePreps {
	[preps release];
	preps = [[WSDataManager sharedInstance] currentPrep];
	[preps retain];
	//self.parentViewController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",[preps count]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self stopLoading];
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self updatePreps];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePreps) name:@"WSPrepUpdatedNotification" object:nil];
	//self.tableView.backgroundColor = [UIColor blackColor];
	self.tableView.separatorColor = [UIColor darkGrayColor];
	self.tableView.rowHeight = 160.0;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[[GANTracker sharedTracker] trackPageview:@"/prepController"
									withError:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
	return YES;
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
    return [preps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PrepCell";
    
    WSPrepViewCell *cell = (WSPrepViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
		UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:@"WSPrepViewCell" bundle:nil];    
		cell = (WSPrepViewCell*)temporaryController.view;
		[temporaryController release];
		CAGradientLayer *gradient = [CAGradientLayer layer];
		gradient.frame = CGRectMake(0, 0, 1200, 160);
		gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor lightGrayColor] CGColor], nil];
		[cell.layer insertSublayer:gradient atIndex:0];
	}
	
	cell.descriptionView.text = [[preps objectAtIndex:indexPath.row] descriptionText];
	cell.subjectLabel.text = [[preps objectAtIndex:indexPath.row] subject];
	cell.dateLabel.text = [[[preps objectAtIndex:indexPath.row] dueDate] stringWithFormat:@"dd/MM/yyyy"];
	cell.initialsLabel.text = [[preps objectAtIndex:indexPath.row] teacherInitials];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 160;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	int row = indexPath.row;
	WSDetailPrep *detail = [[WSDetailPrep alloc]initWithNibName:@"WSDetailPrep" bundle:nil prep:[preps objectAtIndex:row]];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
	 if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		 [detail setModalPresentationStyle:UIModalPresentationFormSheet];
	 }
#endif
	[self.parentViewController.parentViewController presentModalViewController:[detail autorelease] animated:YES];
}

@end

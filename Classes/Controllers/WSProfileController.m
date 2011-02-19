//
//  WSProfileController.m
//  Westminster
//
//  Created by Tom Hartley on 19/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSProfileController.h"
#import <TapkuLibrary/TapkuLibrary.h>
#import "WSAuthManager.h"
#import "WSAuthController.h"
#import "WSDataFetcher.h"
#import "WSDataManager.h"

@implementation WSProfileController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update) name:@"WSProfileUpdatedNotification" object:nil];
		cells = [[NSMutableArray alloc] initWithCapacity:40];
		[self update];
    }
    return self;
}
-(void)setUpTableViewCells {
	
	static NSString *CellIdentifier = @"Cell";

	[cells removeAllObjects];
	TKLabelFieldCell *cell1 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell1.label.text = @"First Name";
	cell1.field.text = profile.firstNames;
	[cells addObject:cell1];
	[cell1 release];
	TKLabelFieldCell *cell2 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell2.label.text = @"Surname";
	cell2.field.text = profile.surname;
	[cells addObject:cell2];
	[cell2 release];
	TKLabelFieldCell *cell3 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell3.label.text = @"Email";
	cell3.field.text = profile.email;
	[cells addObject:cell3];
	[cell3 release];
	TKLabelFieldCell *cell4 = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
	cell4.label.text = @"Phone";
	cell4.field.text = profile.mobileNumber;
	[cells addObject:cell4];
	[cell4 release];

}

#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cells count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	return [cells objectAtIndex:indexPath.row];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 44.0;
	
}

- (void)dealloc
{
	[cells release];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [tableView release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
	[self.parentViewController.parentViewController presentModalViewController:authController animated:YES];
	[authController autorelease];
}

- (IBAction)refresh:(id)sender {
	[[WSDataFetcher sharedInstance] updateProfile];
}

-(void)update {
	[self getProfile];
	[self setUpTableViewCells];
}

-(void)getProfile {
	[profile release];
	profile = [[WSDataManager sharedInstance]currentProfile];
	[profile retain];
}

@end

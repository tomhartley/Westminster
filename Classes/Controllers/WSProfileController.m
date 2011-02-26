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
#import "GANTracker.h"
@implementation WSProfileController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
	[[GANTracker sharedTracker] trackPageview:@"/prepDetailController"
									withError:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update) name:@"WSProfileUpdatedNotification" object:nil];
	[self update];
}

#pragma mark Table view methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	TKLabelFieldCell *cell = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:nil];
	switch (indexPath.row) {
		case 0:
			cell.label.text = @"First Name";
			cell.field.text = profile.firstNames;
			break;
		case 1:
			cell.label.text = @"Surname";
			cell.field.text = profile.surname;
			break;
		case 2:
			cell.label.text = @"Email";
			cell.field.text = profile.email;
			break;
		case 3:
			cell.label.text = @"Phone";
			cell.field.text = profile.mobileNumber;
			break;
		case 4:
			cell.label.text = @"House";
			cell.field.text = profile.house;
			break;
		case 5:
			cell.label.text = @"Tutor";
			cell.field.text = profile.tutor;
			break;
		case 6:
			cell.label.text = @"Previous School";
			cell.field.text = profile.previousSchool;
			break;
		case 7:
			cell.label.text = @"Year";
			cell.field.text = profile.year;
			break;
		case 8:
			cell.label.text = @"Form";
			cell.field.text = profile.form;
			break;
		default:
			break;
	}
	return [cell autorelease];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 44.0;
	
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		return YES;
	}
#endif
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
	[self.parentViewController presentModalViewController:authController animated:YES];
	[authController autorelease];
}

- (IBAction)refresh:(id)sender {
	[[WSDataFetcher sharedInstance] updateProfile];
}

-(void)update {
	[self getProfile];
	[tableView reloadData];
}

-(void)getProfile {
	[profile release];
	profile = [[WSDataManager sharedInstance]currentProfile];
	[profile retain];
}

@end

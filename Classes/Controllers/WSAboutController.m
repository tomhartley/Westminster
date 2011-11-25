//
//  WSAboutController.m
//  Westminster
//
//  Created by Tom Hartley on 19/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSAboutController.h"
#import <TapkuLibrary/TapkuLibrary.h>
#import "GANTracker.h"
#import "WSCreditsController.h"
#import "WSAuthManager.h"
#import "WSAuthController.h"

@implementation WSAboutController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update) name:@"WSProfileUpdatedNotification" object:nil];
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated	{
	NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	versionLabel.text = [NSString stringWithFormat:@"Version: %@",version];
	[[GANTracker sharedTracker] trackPageview:@"/aboutController"
									withError:nil];
		
}

- (void)viewDidUnload
{
    [versionLabel release];
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


- (IBAction)email:(id)sender {
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	[controller setSubject:@"Westminster app feedback"];
	[controller setToRecipients:[NSArray arrayWithObject:@"app@westminster.org.uk"]];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		controller.modalPresentationStyle = UIModalPresentationFormSheet;
	}
#endif
	if (controller) [self presentModalViewController:controller animated:YES];
	[controller release];
}

- (IBAction)credits:(id)sender {
	WSCreditsController *controller = [[WSCreditsController alloc] initWithNibName:@"WSCreditsController" bundle:nil];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		controller.modalPresentationStyle = UIModalPresentationFormSheet;
	}
#endif
	if (controller) [self presentModalViewController:controller animated:YES];
	[controller autorelease];
}

- (IBAction)signOut:(id)sender {
	[[WSAuthManager sharedInstance] signOut];
	
	if ([[WSAuthManager sharedInstance] loggedIn]) {
		[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Signed Out"];
	}
	WSAuthController *authController = [[WSAuthController alloc] initWithNibName:@"WSAuthController" bundle:nil];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[authController setModalPresentationStyle:UIModalPresentationFormSheet];
	}
#endif
	[self.parentViewController presentModalViewController:authController animated:YES];
	[authController autorelease];
}


- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error 
{
	if (result == MFMailComposeResultSent) {
		[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Thanks!"];
	}
	[self dismissModalViewControllerAnimated:YES];
}

-(void)update {
	if ([[WSAuthManager sharedInstance] loggedIn]) {
		self.navigationController.navigationBar.topItem.rightBarButtonItem.title = @"Sign Out";
	} else {
		self.navigationController.navigationBar.topItem.rightBarButtonItem.title = @"Sign In";
	}
}
@end

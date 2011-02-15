//
//  WSAuthController.m
//  Westminster
//
//  Created by Tom Hartley on 06/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSAuthController.h"
#import "WSAuthManager.h"
#import "WSDataFetcher.h"
#import "GANTracker.h"

@implementation WSAuthController

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

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
	CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.frame = self.view.frame;
	gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor lightGrayColor] CGColor], nil];
	[self.view.layer insertSublayer:gradient atIndex:0];
	
	[[GANTracker sharedTracker] trackPageview:@"/authController"
									withError:nil];
}

- (void)viewDidUnload
{
    [uNameField release];
    [pWordField release];
	[keepLoggedInSwitch release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
			return YES;
		}
	#endif
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)login:(id)sender {
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Connecting..."];
	[[WSAuthManager sharedInstance] updateAPITokenUsername:uNameField.text password:pWordField.text saveForNextTime:keepLoggedInSwitch.on progressDelegate:nil delegate:self selector:@selector(loginResponse:)];
	[[GANTracker sharedTracker] trackEvent:@"auth"
									action:@"userLogin"
									 label:nil
									 value:-1
								 withError:nil];
}

-(void)loginResponse:(NSString *)success {
	if ([success isEqualToString:@"YES"]) {
		[self dismissModalViewControllerAnimated:YES];
		[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Login Successful"];
		[[WSDataFetcher sharedInstance] downloadAll];
		
	} else {
		[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Login Failed"];
	}

}

- (IBAction)guestLogin:(id)sender {
	[[WSAuthManager sharedInstance] loginAsGuest];
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Logged in as guest"];
	[[WSDataFetcher sharedInstance] downloadAllAuthFree];
	[self dismissModalViewControllerAnimated:YES];
	[[GANTracker sharedTracker] trackEvent:@"auth"
									action:@"guestLogin"
									 label:nil
									 value:-1
								 withError:nil];
}
- (IBAction)dismissKeyboard:(UITextField *)sender {
	[sender resignFirstResponder];
}

@end

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

@implementation WSAboutController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated	{
	[[GANTracker sharedTracker] trackPageview:@"/prepDetailController"
									withError:nil];
		
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


- (IBAction)email:(id)sender {
	MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	[controller setSubject:@"Westminster app feedback"];
	[controller setToRecipients:[NSArray arrayWithObject:@"tom.hartley@westminster.org.uk"]];
	if (controller) [self presentModalViewController:controller animated:YES];
	[controller release];
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

@end

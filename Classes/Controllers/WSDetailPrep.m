//
//  WSDetailPrep.m
//  Westminster
//
//  Created by Tom Hartley on 12/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSDetailPrep.h"
#import "NSDate+Helper.h"
#import "WSAuthManager.h"
#import "GANTracker.h"

@implementation WSDetailPrep
@synthesize descriptionTextView;
@synthesize locationForProgressView;
@synthesize navigationBar;
@synthesize initialsLabel;
@synthesize dueDate;
@synthesize privateLabel;
@synthesize attachmentLabel;
@synthesize documentNameLabel;
@synthesize downloadButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil prep:(WSPrep *)prep
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		thePrep = prep;
		[thePrep retain];
    }
    return self;
}

- (void)dealloc
{
	[navBar release];
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
	
	//Add a gradient in the background
    [super viewDidAppear:animated];
	CAGradientLayer *gradient = [CAGradientLayer layer];
	gradient.frame = self.view.frame;
	gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor lightGrayColor] CGColor], nil];
	[self.view.layer insertSublayer:gradient atIndex:0];
}


- (void)viewDidLoad
{
	fileDownloaded = NO;
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	//Set up text fields
	initialsLabel.text = thePrep.teacherInitials;
	dueDate.text = [@"Due Date: " stringByAppendingString:[thePrep.dueDate stringWithFormat:@"dd/MM/yyyy"]];
	privateLabel.text = thePrep.editable ? @"Private" : @"Public";
	descriptionTextView.text = thePrep.descriptionText;
	documentNameLabel.text = [thePrep containsDocument] ? ([thePrep.documentDescription isEqualToString:@""]? thePrep.documentFilename : thePrep.documentDescription) : @"No attachment";
	downloadButton.enabled = [thePrep containsDocument];
	[[GANTracker sharedTracker] trackPageview:@"/prepDetailController"
									withError:nil];
	navBar.topItem.title = thePrep.subject;
	[navBar updateColours];
}

- (void)viewDidUnload
{
    [self setInitialsLabel:nil];
    [self setDueDate:nil];
    [self setPrivateLabel:nil];
    [self setAttachmentLabel:nil];
    [self setDocumentNameLabel:nil];
    [self setDownloadButton:nil];
	[self setNavigationBar:nil];
	[self setDescriptionTextView:nil];
	[self setLocationForProgressView:nil];
	[navBar release];
	navBar = nil;
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

- (IBAction)downloadDocument:(id)sender {
	if (!fileDownloaded) {
		downloadButton.hidden = YES;
		NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.westminster.org.uk/api1/1/download.asp?token=%@&documentID=%@",[[[WSAuthManager sharedInstance] apiToken] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],[thePrep.documentID stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
		NSLog(@"%@",url);
		req = [[ASIHTTPRequest alloc] initWithURL:url];
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		NSString *documentsDirectory = [paths objectAtIndex:0];
		req.downloadDestinationPath = [documentsDirectory stringByAppendingPathComponent:thePrep.documentFilename];
		req.delegate = self;
		req.didFailSelector = @selector(documentDownloadFailed:);
		req.didFinishSelector = @selector(documentDownloaded:);
		prog = [[TKProgressBarView alloc] initWithStyle:TKProgressBarViewStyleShort];
		prog.center = CGPointMake(self.view.bounds.size.width/2, locationForProgressView.center.y);
		req.downloadProgressDelegate = prog;
		[self.view addSubview:prog];
		[prog autorelease];
		[req startAsynchronous];
	} else {
		[docControl presentOptionsMenuFromRect:downloadButton.frame inView:self.view animated:YES];
	}
}

- (BOOL) documentInteractionController: (UIDocumentInteractionController *) controller canPerformAction: (SEL) action {
	if (action == @selector (print:) &&
		[NSClassFromString(@"UIPrintInteractionController") canPrintURL: controller.URL]) {
		return YES;
	} else {
		return NO;
	}
}

- (UIViewController *)printInteractionControllerParentViewController:(UIPrintInteractionController *)printInteractionController {
	return self;
}
- (BOOL) documentInteractionController: (UIDocumentInteractionController *) theController performAction: (SEL) action {
	if (action == @selector(print:)) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40200
		UIPrintInteractionController *controller = [NSClassFromString(@"UIPrintInteractionController")  sharedPrintController];
		controller.printingItem = theController.URL;
		controller.delegate = self;
		[controller presentFromRect:downloadButton.frame inView:self.view animated:YES completionHandler:nil];
		return YES;
#endif
	}
	return NO;
}

-(void)documentDownloaded:(ASIHTTPRequest *)reqy {
	//NSLog(req.downloadDestinationPath);
	docControl = [NSClassFromString(@"UIDocumentInteractionController") interactionControllerWithURL:[NSURL fileURLWithPath:req.downloadDestinationPath]];
	if (docControl) {
		docControl.delegate = self;
		[docControl retain];
		fileDownloaded = YES;
		[downloadButton setTitle:@"Open File" forState:UIControlStateNormal];
		[downloadButton setTitle:@"Open File" forState:UIControlStateHighlighted];
		downloadButton.hidden = NO;
		[prog removeFromSuperview];
	} else {
		downloadButton.enabled = false;
		[downloadButton setTitle:@"Upgrade to iOS 4.0" forState:UIControlStateDisabled];
	}
}

- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
	return self;
}

-(void)documentDownloadFailed:(ASIHTTPRequest *)reqy {
	NSLog(@"%@",req.error);
}

- (IBAction)dismiss:(id)sender {
	req.delegate = nil;
	req.downloadProgressDelegate = nil;
	[req release];
	[self dismissModalViewControllerAnimated:YES];
}

@end

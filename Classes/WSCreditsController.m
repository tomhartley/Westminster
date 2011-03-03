//
//  WSCreditsController.m
//  Westminster
//
//  Created by Tom Hartley on 03/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSCreditsController.h"
#import <TapkuLibrary/TapkuLibrary.h>


@implementation WSCreditsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Credits" ofType:@"plist"];  
		NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
		helpers = [[dict objectForKey:@"People"] retain];
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

#pragma mark - Table view data source methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [helpers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	TKLabelFieldCell *cell = [[TKLabelFieldCell alloc] initWithFrame:CGRectZero reuseIdentifier:nil];
	cell.label.text = [[helpers objectAtIndex:indexPath.row] objectForKey:@"Name"];
	cell.field.text = [[helpers objectAtIndex:indexPath.row] objectForKey:@"Job"];
	return [cell autorelease];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)done:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}
@end

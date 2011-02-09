//
//  WestminsterAppDelegate.m
//  Westminster
//
//  Created by Tom Hartley on 07/09/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "WestminsterAppDelegate.h"
#import "WSDataFetcher.h"

@implementation WestminsterAppDelegate


@synthesize window;

@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

	// Override point for customization after application launch.
	// Add the tab bar controller's current view as a subview of the window
	[window addSubview:tabBarController.view];
	if ([[WSAuthManager sharedInstance] needsAuth]) {
		WSAuthController *authController = [[WSAuthController alloc] initWithNibName:@"WSAuthController" bundle:nil];
		authController.modalPresentationStyle= UIModalPresentationFormSheet;
		[tabBarController presentModalViewController:authController animated:YES];
	} else {
		[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Login Successful"];
		[[WSDataFetcher sharedInstance] downloadAll];
	}
	
	[window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

	// Save data if appropriate.
}

- (void)dealloc {

	[window release];
	[tabBarController release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/

@end

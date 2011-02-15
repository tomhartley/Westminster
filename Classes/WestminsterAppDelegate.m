//
//  WestminsterAppDelegate.m
//  Westminster
//
//  Created by Tom Hartley on 07/09/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "WestminsterAppDelegate.h"
#import "WSDataFetcher.h"
#import "GANTracker.h"

@implementation WestminsterAppDelegate


@synthesize window;

@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	openedDate = [[NSDate date] retain];
	[[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-21371417-1"
											   dispatchPeriod:10
													 delegate:nil];
	NSError *error;
	if (![[GANTracker sharedTracker] trackEvent:@"state"
										 action:@"opened"
										  label:nil
										  value:-1
									  withError:&error]) {
		NSLog(@"%@", error);
	}
			
	
	// Override point for customization after application launch.
	// Add the tab bar controller's current view as a subview of the window
	[window addSubview:tabBarController.view];
	if ([[WSAuthManager sharedInstance] needsAuth]) {
		WSAuthController *authController = [[WSAuthController alloc] initWithNibName:@"WSAuthController" bundle:nil];
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_3_2
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [authController setModalPresentationStyle:UIModalPresentationFormSheet];
        }
#endif

		[tabBarController presentModalViewController:authController animated:YES];
		[authController autorelease];
	} else {
		[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Login Successful"];
		[[WSDataFetcher sharedInstance] downloadAll];
	}
	
	[window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[[GANTracker sharedTracker] trackEvent:@"state"
									action:@"quit"
									 label:nil
									 value:([openedDate timeIntervalSinceNow]*-1)
								 withError:nil];
	[[GANTracker sharedTracker] stopTracker];
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

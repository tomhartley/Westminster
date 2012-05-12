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
#import "WSDataManager.h"

@implementation WestminsterAppDelegate


@synthesize window;

@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [TestFlight takeOff:@"02dfea111e830eded7eb92c865e3fbdd_Mzc4NDIwMTItMDMtMjYgMTQ6MzQ6MzMuMzc3OTY1"];
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.window.rootViewController = self.tabBarController;

	openedDate = [[NSDate date] retain];
	NSError *error;
    
    
	//Beta testing:UA-21371417-1 Production: UA-22079240-1
	[[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-21371417-1" dispatchPeriod:60 delegate:nil];
	if (![[GANTracker sharedTracker] trackEvent:@"state"
										 action:@"opened"
										  label:nil
										  value:-1
									  withError:&error]) {
		NSLog(@"%@", error);
	}
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    [self performSelector:@selector(presentAuth) withObject:nil afterDelay:0];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePreps) name:@"WSPrepUpdatedNotification" object:nil];
    [self performSelector:@selector(setUpTabs) withObject:nil afterDelay:0];
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)setUpTabs {
    TBC = [[WSTabBarController alloc] initWithTabBar:tabBarController];
}

-(void)presentAuth {
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
}

-(void)updatePreps {
	/*NSArray *preps = [[WSDataManager sharedInstance] currentPrep];
	if (prepTabBarIndex >= 0) {
		[[[[tabBarController tabBar] items] objectAtIndex:prepTabBarIndex] setBadgeValue: [NSString stringWithFormat:@"%d",[preps count]]];
	}*/
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

/*
 For Managing which tabs are displayed for which visitors
*/

-(void)setSignedOutTabs {
    //prepTabBarIndex = -1;
    [TBC setSignedOutTabs];
}

-(void)setTabsForProfileType:(WSProfileType)type {
	
}

-(void)setSignedInPupilsTabs {
	[TBC setSignedInPupilsTabs];
	//prepTabBarIndex = 0;
}

-(void)setSignedInParentsTabs {
	/*[tabBarController setViewControllers:[NSArray arrayWithObjects:
										  [viewControllers objectAtIndex:1],
										  [viewControllers objectAtIndex:2],
										  [viewControllers objectAtIndex:3],
										  [viewControllers objectAtIndex:5], 
										  nil] animated:YES];
	prepTabBarIndex = -1;*/
}

-(void)setSignedInTeachersTabs {
	/*[tabBarController setViewControllers:[NSArray arrayWithObjects:
										  [viewControllers objectAtIndex:1],
										  [viewControllers objectAtIndex:2],
										  [viewControllers objectAtIndex:3],
										  [viewControllers objectAtIndex:5], 
										  nil] animated:YES];
	prepTabBarIndex = -1;*/
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

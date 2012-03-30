//
//  WSTabBarController.m
//  Westminster
//
//  Created by Network Administrator on 21/02/2012.
//  Copyright (c) 2012 Westminster School. All rights reserved.
//

#import "WSTabBarController.h"

#import "WSPrepController.h"
#import "WSFoodViewController.h"
#import "WSProfileController.h"
#import "WSAboutController.h"
#import "WSTimetableController.h"
#import "WSNoticeController.h"

@implementation WSTabBarController
@synthesize tabBar;

-(id)initWithTabBar:(UITabBarController *)tB {
    if (self = [super init]) {
        tabBar = tB;
        viewControllersContents = [[NSMutableArray alloc] init];
    }

    prepIndex = 0;
    menuIndex = 1;
    noticesIndex = 2;
    timetableIndex = 3;
    profileIndex = 4;
    aboutIndex = 5;

    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    
    //PREPS
    WSPrepController *preps = [[WSPrepController alloc] initWithStyle:UITableViewStylePlain];
    
    UINavigationController *cont1 = [[[UINavigationController alloc] initWithRootViewController:preps] autorelease];
    [viewControllers addObject:cont1];
    [viewControllersContents addObject:preps];
    
    [preps setTitle:@"Prep Reminders"];
    UITabBarItem *prepsTabBarItem = [[UITabBarItem alloc] init];
    [prepsTabBarItem setImage:[UIImage imageNamed:@"117-todo.png"]];
    [prepsTabBarItem setTitle:@"Prep"];
    [preps setTabBarItem:prepsTabBarItem];
    [prepsTabBarItem release];
    
	UIBarButtonItem *refreshPrepsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:[viewControllersContents objectAtIndex:0] action:@selector(refresh)];
    preps.navigationItem.rightBarButtonItem = refreshPrepsButton;
	[refreshPrepsButton autorelease];

	
    //FOOD
    WSFoodViewController *food = [[WSFoodViewController alloc] initWithNibName:@"WSFoodViewController" bundle:nil];
    
    UINavigationController *cont2 = [[[UINavigationController alloc] initWithRootViewController:food] autorelease];
    [viewControllers addObject:cont2];
    [viewControllersContents addObject:food];

    [food setTitle:@"Menu"];
    UITabBarItem *foodTabBarItem = [[UITabBarItem alloc] init];
    [foodTabBarItem setImage:[UIImage imageNamed:@"48-fork-and-knife.png"]];
    [food setTabBarItem:foodTabBarItem];
    [foodTabBarItem setTitle:@"Menu"];
    [foodTabBarItem release];
    
	UIBarButtonItem *refreshFoodButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:[viewControllersContents objectAtIndex:1] action:@selector(refreshFood:)];
    food.navigationItem.rightBarButtonItem = refreshFoodButton;
	[refreshFoodButton autorelease];
	
    //NOTICES
    WSNoticeController *notices = [[WSNoticeController alloc] initWithNibName:@"WSNoticeController" bundle:nil];
    
    UINavigationController *cont3 = [[[UINavigationController alloc] initWithRootViewController:notices] autorelease];
    [viewControllers addObject:cont3];
    [viewControllersContents addObject:notices];

    [notices setTitle:@"Noticeboard"];
    UITabBarItem *noticesTabBarItem = [[UITabBarItem alloc] init];
    [noticesTabBarItem setImage:[UIImage imageNamed:@"166-newspaper.png"]];
    [noticesTabBarItem setTitle:@"Notices"];
    [notices setTabBarItem:noticesTabBarItem];
    [noticesTabBarItem release];

	UIBarButtonItem *refreshNoticesButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:[viewControllersContents objectAtIndex:2] action:@selector(refresh)];
    notices.navigationItem.rightBarButtonItem = refreshNoticesButton;
	[refreshNoticesButton autorelease];
	
    //TIMETABLE
    WSTimetableController *timetable = [[WSTimetableController alloc] initWithNibName:@"WSTimetableController" bundle:nil];

    UINavigationController *cont4 = [[[UINavigationController alloc] initWithRootViewController:timetable] autorelease];
    [viewControllers addObject:cont4];
    [viewControllersContents addObject:timetable];

    [timetable setTitle:@"Timetable"];
    UITabBarItem *timetableTabBarItem = [[UITabBarItem alloc] init];
    [timetableTabBarItem setImage:[UIImage imageNamed:@"11-clock.png"]];
    [timetableTabBarItem setTitle:@"Timetable"];
    [timetable setTabBarItem:timetableTabBarItem];
    [timetableTabBarItem release];

	UIBarButtonItem *refreshTimetableButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:[viewControllersContents objectAtIndex:3] action:@selector(refresh)];
    timetable.navigationItem.rightBarButtonItem = refreshTimetableButton;
	[refreshTimetableButton autorelease];

    //PROFILE
    WSProfileController *profile = [[WSProfileController alloc] initWithNibName:@"WSProfileController" bundle:nil];
    
    UINavigationController *cont5 = [[[UINavigationController alloc] initWithRootViewController:profile] autorelease];
    [viewControllers addObject:cont5];
    [viewControllersContents addObject:profile];

    [profile setTitle:@"Profile"];
    UITabBarItem *profileTabBarItem = [[UITabBarItem alloc] init];
    [profileTabBarItem setImage:[UIImage imageNamed:@"111-user.png"]];
    [profileTabBarItem setTitle:@"Profile"];
    [profile setTabBarItem:profileTabBarItem];
    [profileTabBarItem release];
    
	/*UIBarButtonItem *refreshProfileButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:[viewControllersContents objectAtIndex:4] action:@selector(refresh:)];
    profile.navigationItem.rightBarButtonItem = refreshProfileButton;
	[refreshProfileButton autorelease];*/

	
    //ABOUT
    WSAboutController *about = [[WSAboutController alloc] initWithNibName:@"WSAboutController" bundle:nil];
    
    UINavigationController *cont6 = [[[UINavigationController alloc] initWithRootViewController:about] autorelease];
    [viewControllers addObject:cont6];
    [viewControllersContents addObject:about];

    [about setTitle:@"About"];
    UITabBarItem *aboutTabBarItem = [[UITabBarItem alloc] init];
    [aboutTabBarItem setImage:[UIImage imageNamed:@"18-envelope.png"]];
    [aboutTabBarItem setTitle:@"About"];
    [about setTabBarItem:aboutTabBarItem];
    [aboutTabBarItem release];
    UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStyleBordered target:[viewControllersContents objectAtIndex:5] action:@selector(signOut:)];
    about.navigationItem.rightBarButtonItem = signOutButton;


    [tabBar setViewControllers:viewControllers];
    
    return self;
}

-(void)setSignedOutTabs {
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];

    UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:[viewControllersContents objectAtIndex:1]] autorelease]; //Food
    [viewControllers addObject: nav];
    UINavigationController *nav2 = [[[UINavigationController alloc] initWithRootViewController:[viewControllersContents objectAtIndex:5]] autorelease]; //About
    //UIBarButtonItem *signOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:[viewControllersContents objectAtIndex:5] action:@selector(signOut)];
    //nav2.navigationItem.rightBarButtonItem = signOutButton;
    //nav2.topLevelController.navigationItem.rightBarButtonItem = signOutButton;
    //[signOutButton autorelease];
    [viewControllers addObject: nav2];
    [tabBar setViewControllers:viewControllers animated:YES];
}

-(void)setSignedInPupilsTabs {
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (UIViewController *cont in viewControllersContents) {
        UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:cont] autorelease];
        [viewControllers addObject:nav];
    }
    [tabBar setViewControllers:viewControllers animated:YES];
}

-(void)setSignedInParentsTabs {
    prepIndex = -1;
    menuIndex = 0;
    noticesIndex = 1;
    timetableIndex = -1;
    profileIndex = 2;
    aboutIndex = 3;
    
    
}

-(void)setSignedInTeachersTabs {
    prepIndex = -1;
    menuIndex = 0;
    noticesIndex = 1;
    timetableIndex = 2;
    profileIndex = 2;
    aboutIndex = 5;
    
    
}


@end

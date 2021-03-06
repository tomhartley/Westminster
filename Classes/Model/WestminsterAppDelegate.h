//
//  WestminsterAppDelegate.h
//  Westminster
//
//  Created by Tom Hartley on 07/09/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TapkuLibrary/TapkuLibrary.h>
#import "WSAuthManager.h"
#import "WSAuthController.h"
#import "WSTabBarController.h"

@interface WestminsterAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
	UIWindow *window;
	UITabBarController *tabBarController;
	NSDate *openedDate;
	WSTabBarController *TBC;
	int prepTabBarIndex;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;


-(void)presentAuth;
-(void)setUpTabs;
-(void)updatePreps;
-(void)setSignedOutTabs;
-(void)setSignedInPupilsTabs;
-(void)setSignedInParentsTabs;
-(void)setSignedInTeachersTabs;



-(void)setTabsForProfileType:(WSProfileType)type;

@end

//
//  WSTabBarController.h
//  Westminster
//
//  Created by Network Administrator on 21/02/2012.
//  Copyright (c) 2012 Westminster School. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSTabBarController : NSObject {
    //NSMutableArray *viewControllers;
    NSMutableArray *viewControllersContents;
    UITabBarController *tabBar;
    int menuIndex;
    int prepIndex;
    int noticesIndex;
    int profileIndex;
    int aboutIndex;
    int timetableIndex;
}

-(id)initWithTabBar:(UITabBarController *)tB;

-(void)setSignedOutTabs;
-(void)setSignedInPupilsTabs;
-(void)setSignedInParentsTabs;
-(void)setSignedInTeachersTabs;

@property (assign, readonly) UITabBarController *tabBar;
@end

//
//  WSFoodViewController.h
//  Westminster
//
//  Created by Tom Hartley on 11/10/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSDayFood.h"
#import "MealsTableViewDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "WSProfile.h"

@interface WSFoodViewController : UIViewController <UIScrollViewDelegate> {
	NSArray *weekFoods;
	NSMutableArray *tableViews;
	NSMutableArray *delegates;
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIPageControl *pageControl;
	IBOutlet UILabel *dateLabel;
	WSProfile *profile;
	IBOutlet UINavigationBar *navBar;
}
-(void)getProfile;
- (void)updateTableViews;
- (void)layoutSubviews;
-(void)updateMeals;
- (IBAction)pageControlChanged:(UIPageControl *)sender;
- (void)updateDate;
- (void)scrollToPage:(int)pageNumber;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;


- (IBAction)refreshFood:(id)sender;
- (IBAction)signOut:(id)sender;

@end
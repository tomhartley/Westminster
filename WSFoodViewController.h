//
//  WSFoodViewController.h
//  Westminster
//
//  Created by Tom Hartley on 11/10/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSDayFood.h"
#import "WSMealsTableViewDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "THPagedScrollView.h"

@interface WSFoodViewController : UIViewController <THPagedScrollViewDelegate> {
	NSArray *weekFoods;
	NSMutableArray *tableViews;
	NSMutableArray *delegates;
	IBOutlet THPagedScrollView *pagedScrollView;
	IBOutlet UILabel *dateLabel;
}
- (void)updateTableViews;
- (void)updateMeals;
- (void)updateDate;

- (IBAction)refreshFood:(id)sender;

@end
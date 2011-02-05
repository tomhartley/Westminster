//
//  WSFoodViewController.h
//  Westminster
//
//  Created by Tom Hartley on 11/10/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSDayFood.h"
#import "WSDataFetcher.h"
#import "MealsTableViewDelegate.h"
#import <QuartzCore/QuartzCore.h>


@interface WSFoodViewController : UIViewController <UIScrollViewDelegate> {
	NSArray *weekFoods;
	NSMutableArray *delegatz;
	NSMutableArray *tableViews;
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIPageControl *pageControl;
	IBOutlet UILabel *dateLabel;
}

- (void)setUpScrollView;
- (IBAction)pageControlChanged:(UIPageControl *)sender;
- (void)updateDate;
- (void)scrollToPage:(int)pageNumber;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end
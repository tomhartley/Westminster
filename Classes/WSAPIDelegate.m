//
//  WSAPIDelegate.m
//  Westminster
//
//  Created by Tom Hartley on 06/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSAPIDelegate.h"
#import "WSDataManager.h"


@implementation WSAPIDelegate

-(void)mealsFinished:(ASIHTTPRequest *)request {
	NSArray *meals = [[[[WSXMLDataParser alloc] init] autorelease] parseMeals:[request responseData]];
	[[WSDataManager sharedInstance] setCurrentFood:meals];
	NSLog(@"%@",@"Data Download Finished...");
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Downloaded Meals"];
	NSLog(@"%@",@"Data Download Posting Finished...");
}

-(void)mealsFailed:(ASIHTTPRequest *)request {
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Meals Failed"];
	NSError *error = [request error];
	NSLog(@"%@", error);
}

@end

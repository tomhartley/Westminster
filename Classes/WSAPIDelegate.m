//
//  WSAPIDelegate.m
//  Westminster
//
//  Created by Tom Hartley on 06/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSAPIDelegate.h"
#import "WSDataManager.h"
#import "WSProfile.h"

@implementation WSAPIDelegate

-(void)mealsFinished:(ASIHTTPRequest *)request {
	NSArray *meals = [[[[WSXMLDataParser alloc] init] autorelease] parseMeals:[request responseData]];
	[[WSDataManager sharedInstance] setCurrentFood:meals];
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Downloaded Meals"];
}

-(void)mealsFailed:(ASIHTTPRequest *)request {
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Meals Failed"];
	NSError *error = [request error];
	NSLog(@"%@", error);
}

-(void)prepsFinished:(ASIHTTPRequest *)request {
	NSArray *prep = [[[[WSXMLDataParser alloc] init] autorelease] parsePreps:[request responseData]];
	[[WSDataManager sharedInstance] setCurrentPrep:prep];
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Downloaded Preps"];
}

-(void)prepsFailed:(ASIHTTPRequest *)request {
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Preps Failed"];
	NSError *error = [request error];
	NSLog(@"%@", error);
}

-(void)noticesFinished:(ASIHTTPRequest *)request {
	NSArray *notices = [[[[WSXMLDataParser alloc] init] autorelease] parseNotices:[request responseData]];
	[[WSDataManager sharedInstance] setCurrentNotices:notices];
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Downloaded Notices"];
}

-(void)noticesFailed:(ASIHTTPRequest *)request {
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Notices Failed"];
	NSError *error = [request error];
	NSLog(@"%@", error);
}

-(void)profileFinished:(ASIHTTPRequest *)request {
	WSProfile *profile = [[[[WSXMLDataParser alloc] init] autorelease] parseProfile:[request responseData]];
	[[WSDataManager sharedInstance] setCurrentProfile:profile];
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Downloaded Profile"];
}

-(void)profileFailed:(ASIHTTPRequest *)request {
	[[TKAlertCenter defaultCenter] postAlertWithMessage:@"Profile Failed"];
	NSError *error = [request error];
	NSLog(@"%@", error);
}

@end

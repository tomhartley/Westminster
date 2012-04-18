//
//  WSDataFetcher.h
//  Westminster
//
//  Created by Tom Hartley on 07/09/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "WSAPIDelegate.h"

@interface WSDataFetcher : NSObject {
	ASINetworkQueue *networkQueue;
	WSAPIDelegate *delegate;
}

-(void)downloadAll;
-(void)downloadAllAuthFree;
//Authentication not required
-(void)updateEvents;
//-(NSArray *)downloadEventsWithCategory:(NSString *)category withStartDate:(NSDate *)sDate withEndDate:(NSDate *)eDate;
-(void)updateFood;


//Authentication required
-(void)updatePreps;
-(void)updateProfile;
-(void)updateNotices;
-(void)updateClasses;
-(void)updateTimetable;

+ (WSDataFetcher *)sharedInstance;

@end

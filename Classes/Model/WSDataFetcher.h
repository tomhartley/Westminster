//
//  WSDataFetcher.h
//  Westminster
//
//  Created by Tom Hartley on 07/09/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMLParser.h"

@interface WSDataFetcher : NSObject {
	
}

-(void)downloadAll;

//Authentication not required
-(void)updateEvents;
-(NSArray *)downloadEventsWithCategory:(NSString *)category withStartDate:(NSDate *)sDate withEndDate:(NSDate *)eDate;
-(void)updateFood;


//Authentication required
-(void)updatePreps;
-(void)updateProfile;
-(void)updateNotices;
-(void)updateClasses;


-(void)updateAPIKeyUsername:(NSString *)uName password:(NSString *)pWord;


+ (WSDataFetcher *)sharedInstance;



@end

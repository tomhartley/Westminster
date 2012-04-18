//
//  WSDataManager.m
//  Westminster
//
//  Created by Tom Hartley on 07/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSDataManager.h"
#import "WestminsterAppDelegate.h"
static WSDataManager *sharedInstance  = nil;

@implementation WSDataManager;

-(NSArray *)currentNotices {
	return currentNotices;
}

-(void)setCurrentNotices:(NSArray *)notices {
	[currentNotices release];
	currentNotices = notices;
	[currentNotices retain];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"WSNoticesUpdatedNotification" object:nil];
}

-(NSArray *)currentFood {
	return currentFood;
}

-(void)setCurrentFood:(NSArray *)food {
	[currentFood release];
	currentFood=food;
	[currentFood retain];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"WSFoodUpdatedNotification" object:nil];
}

-(NSArray *)currentPrep {
	return currentPrep;
}

-(void)setCurrentPrep:(NSArray *)prep {
	[currentPrep release];
	currentPrep=prep;
	[currentPrep retain];
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:[currentPrep count]];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"WSPrepUpdatedNotification" object:nil];
}

-(WSProfile *)currentProfile {
	return currentProfile;
}

-(void)setCurrentProfile:(WSProfile *)profile {
	[currentProfile release];
	currentProfile = profile;
	[currentProfile retain];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"WSProfileUpdatedNotification" object:nil];
	if (profile == nil) {
		[(WestminsterAppDelegate *)[[UIApplication sharedApplication] delegate] setSignedOutTabs];
	} else if ([profile.type isEqualToString:@"Pupil"]) {
		[(WestminsterAppDelegate *)[[UIApplication sharedApplication] delegate] setSignedInPupilsTabs];
	} else if ([profile.type isEqualToString:@"Parent"]) {
		[(WestminsterAppDelegate *)[[UIApplication sharedApplication] delegate] setSignedInParentsTabs];
	} else {
		[(WestminsterAppDelegate *)[[UIApplication sharedApplication] delegate] setSignedInTeachersTabs];
	}
}

-(NSArray *)currentTimetable {
	return currentTimetable;
}

-(void)setCurrentTimetable:(NSArray *)timetable {
	[currentTimetable release];
	currentTimetable=timetable;
	[currentTimetable retain];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"WSTimetableUpdatedNotification" object:nil];
}


//WSDeletePersonalData

-(void)deletePersonalInformation {
	self.currentPrep = nil;
	self.currentProfile = nil;
	self.currentNotices = nil;
	self.currentTimetable = nil;
}

//Singleton methods

+ (WSDataManager *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil) {
            sharedInstance = [[WSDataManager alloc] init];
			[[NSNotificationCenter defaultCenter] addObserver:sharedInstance selector:@selector(deletePersonalInformation) name:@"WSDeletePersonalData" object:nil];
		}
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (oneway void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}


@end

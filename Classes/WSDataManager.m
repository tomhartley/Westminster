//
//  WSDataManager.m
//  Westminster
//
//  Created by Tom Hartley on 07/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSDataManager.h"

static WSDataManager *sharedInstance  = nil;

@implementation WSDataManager;
@synthesize currentFood, currentPrep;

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
	[[NSNotificationCenter defaultCenter] postNotificationName:@"WSPrepUpdatedNotification" object:nil];
}
//WSDeletePersonalData

-(void)deletePersonalInformation {
	self.currentPrep = nil;
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

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}


@end
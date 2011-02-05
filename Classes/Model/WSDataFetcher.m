//
//  WSDataFetcher.m
//  Westminster
//
//  Created by Tom Hartley on 07/09/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "WSDataFetcher.h"
#import "WSDayFood.h"
#import "NSDate+Helper.h"

static WSDataFetcher *sharedInstance = nil;

@implementation WSDataFetcher

#pragma mark -
#pragma mark class instance methods

#pragma mark -
#pragma mark Singleton methods

+ (WSDataFetcher *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
            sharedInstance = [[WSDataFetcher alloc] init];
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

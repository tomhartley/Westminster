//
//  WSLesson.m
//  Westminster
//
//  Created by Tom Hartley on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSLesson.h"

@implementation WSLesson

@synthesize period,location,teacher,subject,startTime,endTime;

- (id)initWithPeriod:(NSInteger)periodNumber {
    self = [super init];
    if (self) {
        period=periodNumber;
    }
    return self;
}

@end

//
//  WSTimetableDay.m
//  Westminster
//
//  Created by Tom Hartley on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSTimetableDay.h"
#import "NSDate+Helper.h"

@implementation WSTimetableDay

@synthesize day;

BOOL dayIsShort(int day) {
    switch (day) {
        case 0:
            return NO;
        case 1:
            return YES;
        case 2:
            return NO;
        case 3:
            return YES;
        case 4:
            return NO;
        case 5:
            return YES; //Ugghh saturday...
        default:
            [[NSException exceptionWithName:@"NSInternalErrorException" reason:@"There are only 6 days in a school week" userInfo:nil] raise];
    }
    return NO;
}

- (id)initWithDay:(NSInteger)dayOfWeek {
    self = [super init];
    if (self) {
        // Initialization code here.
		day = dayOfWeek;
        lessons = [[NSMutableDictionary alloc] initWithCapacity:6];
    }
    
    return self;
}

-(BOOL)addLesson:(WSLesson *)lesson {
    if ([lessons objectForKey:[NSNumber numberWithInteger:[lesson period]]]) {
        return NO; //Don't want to overrwrite
    }  else {
        [lessons setObject:lesson forKey:[NSNumber numberWithInteger:[lesson period]]];
        [self addTimeForPeriod:[lesson period]];
        return YES;
    }
}

-(BOOL)removeLessonForPeriod:(NSInteger)period {
    if ([lessons objectForKey:[NSNumber numberWithInteger:period]]) {
        [lessons removeObjectForKey:[NSNumber numberWithInteger:period]];
        return YES; 
    }  else {
        //Can't remove it, because it doesn't exist...
        return NO;
    }
}

- (NSDictionary *)lessons {
    return lessons; //Actually an NSMutableDictionary, but don't tell anyone
}

- (void)addTimeForPeriod:(NSInteger)period {
    BOOL shortDay = dayIsShort(day);
    WSTime startTime;
    WSTime endTime;
    switch (shortDay) {
        case NO: //Long day, monday, wednesday,friday
            switch (period) {
                case 1:
                    startTime.hours=9;
                    startTime.minutes=25;
                    endTime.hours=10;
                    endTime.minutes=05;
                    break;
                case 2:
                    startTime.hours=10;
                    startTime.minutes=10;
                    endTime.hours=10;
                    endTime.minutes=50;
                    break;
                case 3:
                    startTime.hours=11;
                    startTime.minutes=15;
                    endTime.hours=11;
                    endTime.minutes=55;
                    break;
                case 4:
                    startTime.hours=12;
                    startTime.minutes=00;
                    endTime.hours=12;
                    endTime.minutes=40;
                    break;
                case 5:
                    startTime.hours=14;
                    startTime.minutes=00;
                    endTime.hours=14;
                    endTime.minutes=40;
                    break;
                case 6:
                    startTime.hours=14;
                    startTime.minutes=45;
                    endTime.hours=15;
                    endTime.minutes=25;
                    break;
                case 7:
                    startTime.hours=15;
                    startTime.minutes=30;
                    endTime.hours=16;
                    endTime.minutes=10;
                    break;
                default:
                    break;
            }
            break;
        case YES: //Short day, only 5 periods then station/end of school
            switch (period) {
                case 1:
                    startTime.hours=9;
                    startTime.minutes=00;
                    endTime.hours=9;
                    endTime.minutes=40;
                    break;
                case 2:
                    startTime.hours=9;
                    startTime.minutes=45;
                    endTime.hours=10;
                    endTime.minutes=25;
                    break;
                case 3:
                    startTime.hours=10;
                    startTime.minutes=30;
                    endTime.hours=11;
                    endTime.minutes=10;
                    break;
                case 4:
                    startTime.hours=11;
                    startTime.minutes=35;
                    endTime.hours=12;
                    endTime.minutes=15;
                    break;
                case 5:
                    startTime.hours=12;
                    startTime.minutes=20;
                    endTime.hours=13;
                    endTime.minutes=00;
                    break;
                default:
                    break;
            }
            break;
    }
    WSLesson *theLesson = [lessons objectForKey:[NSNumber numberWithInteger:period]];
    theLesson.startTime=startTime;
    theLesson.endTime=endTime;
}

-(NSString *)description {
    return [NSString stringWithFormat:@"%d \n %@", day, lessons];
}

-(NSString *)dateDescription {
	return [NSDate weekdayNameFromInt:day+2];
}

-(BOOL)isShort {
	return dayIsShort(day);
}

@end

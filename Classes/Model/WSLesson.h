//
//  WSLesson.h
//  Westminster
//
//  Created by Tom Hartley on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

struct WSTime {
    int hours; //0-23
    int minutes; //0-59
};
typedef struct WSTime WSTime;

@interface WSLesson : NSObject {
    NSInteger period;
    NSString *location;
    NSString *teacher;
    NSString *class;
    WSTime startTime;
    WSTime endTime;
}

- (id)initWithPeriod:(NSInteger)period;

@property (nonatomic, readonly) NSInteger period;
@property (nonatomic, retain) NSString *location;
@property (nonatomic, retain) NSString *teacher;
@property (nonatomic, retain) NSString *class;
@property (nonatomic) WSTime startTime;
@property (nonatomic) WSTime endTime;
@end

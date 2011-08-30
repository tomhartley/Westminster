//
//  WSTimetableDay.h
//  Westminster
//
//  Created by Tom Hartley on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSLesson.h"

@interface WSTimetableDay : NSObject {
    NSMutableDictionary *lessons;
    NSInteger day;
}

-(id)initWithDay:(NSInteger)day;

-(BOOL)addLesson:(WSLesson *)lesson;
-(BOOL)removeLessonForPeriod:(NSInteger)period;
- (void)addTimeForPeriod:(NSInteger)period;

@property (nonatomic,readonly) NSInteger day;
@property (nonatomic,retain,readonly) NSDictionary *lessons; //Keys are NSNumber encoded period numbers

@end
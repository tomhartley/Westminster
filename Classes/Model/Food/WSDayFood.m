//
//  WSDayFood.m
//  Westminster
//
//  Created by Tom Hartley on 30/09/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "WSDayFood.h"
#import "NSDate+Helper.h"

@implementation WSDayFood
@synthesize breakfastItems, date, lunchItems, dinnerItems;

-(NSString *)dateDescription {
	return [NSDate weekdayNameFromInt:[date weekday]];
}

@end

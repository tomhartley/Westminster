//
//  WSDayFood.h
//  Westminster
//
//  Created by Tom Hartley on 30/09/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSDayFood : NSObject {
	NSDate *date;
	NSArray *breakfastItems;
	NSArray *lunchItems;
	NSArray *dinnerItems;
}

-(NSString *)dateDescription;

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSArray* breakfastItems;
@property (nonatomic, retain) NSArray* lunchItems;
@property (nonatomic, retain) NSArray* dinnerItems;

@end

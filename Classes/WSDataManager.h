//
//  WSDataManager.h
//  Westminster
//
//  Created by Tom Hartley on 07/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSDataManager : NSObject {
    NSArray *currentFood;
	NSArray *currentPrep;
}
-(void)deletePersonalInformation;
+ (WSDataManager *)sharedInstance;

@property (nonatomic, retain) NSArray *currentFood;
@property (nonatomic, retain) NSArray *currentPrep;


@end

//
//  WSNotice.h
//  Westminster
//
//  Created by Tom Hartley on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSNotice : NSObject {
	NSString *noticeID;
    NSString *description;
	NSString *title;
	NSDate *addedDate;
	NSDate *removalDate;
	NSInteger audience;
}

@end

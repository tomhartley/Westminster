//
//  WSNotice.m
//  Westminster
//
//  Created by Tom Hartley on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSNotice.h"


@implementation WSNotice
@synthesize noticeID,description,title,addedDate,removalDate,audience,documentID,expanded;

/*-(NSString *)description {
	return [NSString stringWithFormat:@"\n%@\n%@\nFrom %@ to %@\nID:%@\nDocID:%@\nAudience:%d",title,description,addedDate,removalDate,noticeID,documentID,audience];
}*/

-(void)toggleExpansion {
	expanded=!expanded;
}
@end

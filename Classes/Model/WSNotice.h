//
//  WSNotice.h
//  Westminster
//
//  Created by Tom Hartley on 11/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WSNotice : NSObject {
	NSString *noticeID;
    NSString *description;
	NSString *title;
	NSDate *addedDate;
	NSDate *removalDate;
	NSInteger audience;
	NSString *documentID;
	BOOL expanded;
}

@property(nonatomic,retain) NSString *noticeID;
@property(nonatomic,retain) NSString *description;
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSDate *addedDate;
@property(nonatomic,retain) NSDate *removalDate;
@property(nonatomic,retain) NSString *documentID;
@property(nonatomic) NSInteger audience;
@property(nonatomic) BOOL expanded;

-(void)toggleExpansion;

@end

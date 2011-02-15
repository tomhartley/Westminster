//
//  WSPrep.h
//  Westminster
//
//  Created by Tom Hartley on 10/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WSPrep : NSObject {
    NSString *teacherInitials;
	NSDate *dueDate;
	NSString *descriptionText;
	NSString *subject;
	NSString *documentID;
	NSString *documentDescription;
	NSString *documentFilename;
	BOOL editable;
}

@property (nonatomic, retain) NSString *teacherInitials;
@property (nonatomic, retain) NSDate *dueDate;
@property (nonatomic, retain) NSString *descriptionText;
@property (nonatomic, retain) NSString *subject;
@property (nonatomic, retain) NSString *documentID;
@property (nonatomic, retain) NSString *documentDescription;
@property (nonatomic, retain) NSString *documentFilename;
@property (nonatomic) BOOL editable;

-(BOOL)containsDocument;
@end

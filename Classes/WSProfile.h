//
//  WSProfile.h
//  Westminster
//
//  Created by Tom Hartley on 19/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	WSProfileTypeNone,
	WSProfileTypePupil,
	WSProfileTypeParent,
	WSProfileTypeTeacher,
} WSProfileType;

typedef enum {
	WSGenderMale,
	WSGenderFemale
} WSGender;

@interface WSProfile : NSObject {
	NSString *UWI;
	NSString *type;
	NSString *firstNames;
	NSString *surname;
	NSString *initials;
	NSString *preferredName;
	WSGender gender;
	NSDate *dateOfBirth;
	NSString *email;
	NSDate *dateOfArrival;
	NSString *scholarhsip;
	BOOL boarder;
	NSString *house;
	NSString *year;
	NSString *form;
	NSString *tutor;
	NSString *examID;
	NSString *examUCI;
	NSString *examName;
	NSString *previousSchool;
	NSString *entryMethod;
	NSString *mobileNumber;
}

@property (nonatomic, retain) NSString *UWI;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *firstNames;
@property (nonatomic, retain) NSString *surname;
@property (nonatomic, retain) NSString *initials;
@property (nonatomic, retain) NSString *preferredName;
@property (nonatomic) WSGender gender;
@property (nonatomic, retain) NSDate *dateOfBirth;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSDate *dateOfArrival;
@property (nonatomic, retain) NSString *scholarhsip;
@property (nonatomic) BOOL boarder;
@property (nonatomic, retain) NSString *house;
@property (nonatomic, retain) NSString *year;
@property (nonatomic, retain) NSString *form;
@property (nonatomic, retain) NSString *tutor;
@property (nonatomic, retain) NSString *examID;
@property (nonatomic, retain) NSString *examUCI;
@property (nonatomic, retain) NSString *examName;
@property (nonatomic, retain) NSString *previousSchool;
@property (nonatomic, retain) NSString *entryMethod;
@property (nonatomic, retain) NSString *mobileNumber;

-(UIColor *)primaryColor;
-(UIColor *)secondaryColor;
-(UIColor *)shadowColor;
-(BOOL)shadowOnTop;
@end

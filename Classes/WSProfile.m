//
//  WSProfile.m
//  Westminster
//
//  Created by Tom Hartley on 19/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSProfile.h"


@implementation WSProfile
@synthesize UWI,type,firstNames,surname,initials,preferredName,gender,dateOfBirth,email,dateOfArrival,scholarhsip,boarder,house,year,form,tutor,examID,examUCI,examName,previousSchool,entryMethod,mobileNumber;

-(void)setHouse:(NSString *)thehouse {
	house = thehouse;
}

-(void)setEmail:(NSString *)theEmail {
	email = theEmail;
}

-(UIColor *)primaryColor {
	if ([email isEqualToString:@"william.wood@westminster.org.uk"]) return [UIColor colorWithRed:0.1 green:0.313 blue:0.431 alpha:1];
	if ([UWI isEqualToString:@"P09HAR01"]) return [UIColor colorWithRed:0.188 green:0.123 blue:0 alpha:1];
	if ([self.house isEqualToString:@"Hakluyt's"]) {
		return [UIColor colorWithRed:0 green:0 blue:0.7 alpha:1];	
	} else if ([self.house isEqualToString:@"Grant's"]) {
		return [UIColor colorWithRed:0.666 green:0.8666 blue:0.8666 alpha:1];
	} else if ([self.house isEqualToString:@"Liddell's"]) {
		return [UIColor colorWithRed:0.8 green:0.8 blue:0 alpha:1];
	} else if ([self.house isEqualToString:@"Wren's"]) {
		return [UIColor colorWithWhite:0 alpha:1];
	} else if ([self.house isEqualToString:@"Dryden's"]) {
		return [UIColor colorWithRed:0.7 green:0 blue:0 alpha:0];
	} else if ([self.house isEqualToString:@"Rigaud's"]) {
		return [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1];
	} else if ([self.house isEqualToString:@"Busby's"]) {
		return [UIColor colorWithRed:0.666 green:0 blue:0.2 alpha:1];
	} else if ([self.house isEqualToString:@"Ashburnham"]) {
		return [UIColor colorWithRed:0 green:0 blue:0.4 alpha:1];
	} else if ([self.house isEqualToString:@"Milne's"]) {
		return [UIColor colorWithRed:0.7 green:0 blue:0 alpha:0];
	} else if ([self.house isEqualToString:@"Purcell's"]) {
		return [UIColor colorWithRed:1 green:0.666 blue:0.666 alpha:1];
	} else if ([self.house isEqualToString:@"College"]) {
		return [UIColor colorWithRed:0 green:0.333 blue:0 alpha:1];
	}
	return nil;
}


-(UIColor *)secondaryColor {
	if ([email isEqualToString:@"william.wood@westminster.org.uk"]) return [UIColor colorWithRed:0.403 green:0.078 blue:0.372 alpha:1];
	if ([UWI isEqualToString:@"P09HAR01"]) return [UIColor colorWithRed:0.85 green:0.611 blue:0.16 alpha:1];
	if ([self.house isEqualToString:@"Hakluyt's"]) {
		return [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
	} else if ([self.house isEqualToString:@"Grant's"]) {
		return [UIColor colorWithRed:0.643 green:0.094 blue:0.094 alpha:1];
	} else if ([self.house isEqualToString:@"Liddell's"]) {
		return [UIColor colorWithRed:0 green:0 blue:0.7 alpha:1];	
	} else if ([self.house isEqualToString:@"Wren's"]) {
		return [UIColor colorWithRed:1 green:0.4 blue:0.933 alpha:1];
	} else if ([self.house isEqualToString:@"Dryden's"]) {
		return [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
	} else if ([self.house isEqualToString:@"Rigaud's"]) {
		return [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
	} else if ([self.house isEqualToString:@"Busby's"]) {
		return [UIColor colorWithRed:0.2 green:0 blue:0.666 alpha:1];
	} else if ([self.house isEqualToString:@"Ashburnham"]) {
		return [UIColor colorWithRed:0.3 green:1 blue:1 alpha:1];
	} else if ([self.house isEqualToString:@"Milne's"]) {
		return [UIColor colorWithRed:1 green:1 blue:0 alpha:1];
	} else if ([self.house isEqualToString:@"Purcell's"]) {
		return [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
	} else if ([self.house isEqualToString:@"College"]) {
		return [UIColor colorWithRed:0.666 green:0.8666 blue:0.8666 alpha:0];
	}
	return nil;
}

-(UIColor *)shadowColor {
	if ([email isEqualToString:@"william.wood@westminster.org.uk"]) return [UIColor colorWithWhite:1 alpha:0.3];
	if ([UWI isEqualToString:@"P09HAR01"]) return [UIColor colorWithWhite:0 alpha:1];
	if ([self.house isEqualToString:@"Hakluyt's"]) {
		return [UIColor colorWithWhite:0 alpha:1];
	} else if ([self.house isEqualToString:@"Grant's"]) {
		return [UIColor colorWithWhite:1.0 alpha:0.5];
	} else if ([self.house isEqualToString:@"Liddell's"]) {
		return [UIColor colorWithWhite:1.0 alpha:0.5];
	} else if ([self.house isEqualToString:@"Wren's"]) {
		return [UIColor colorWithWhite:0 alpha:1];
	} else if ([self.house isEqualToString:@"Dryden's"]) {
		return [UIColor colorWithWhite:0 alpha:0.5];
	} else if ([self.house isEqualToString:@"Rigaud's"]) {
		return [UIColor colorWithWhite:1.0 alpha:0.5];
	} else if ([self.house isEqualToString:@"Busby's"]) {
		return [UIColor colorWithWhite:1.0 alpha:0.3];
	} else if ([self.house isEqualToString:@"Ashburnham"]) {
		return [UIColor colorWithWhite:0 alpha:1];
	} else if ([self.house isEqualToString:@"Milne's"]) {
		return [UIColor colorWithWhite:0 alpha:0.5];
	} else if ([self.house isEqualToString:@"Purcell's"]) {
		return [UIColor colorWithWhite:1.0 alpha:0.5];
	} else if ([self.house isEqualToString:@"College"]) {
		return [UIColor colorWithWhite:1.0 alpha:0];
	}
	return [UIColor colorWithWhite:1.0 alpha:0.5];
}
// Black on top, and white on bottom
-(BOOL)shadowOnTop {
	if ([email isEqualToString:@"william.wood@westminster.org.uk"]) return NO;
	if ([UWI isEqualToString:@"P09HAR01"]) return YES;
	if ([self.house isEqualToString:@"Hakluyt's"]) {
		return YES;
	} else if ([self.house isEqualToString:@"Grant's"]) {
		return NO;
	} else if ([self.house isEqualToString:@"Liddell's"]) {
		return NO;
	} else if ([self.house isEqualToString:@"Wren's"]) {
		return YES;
	} else if ([self.house isEqualToString:@"Dryden's"]) {
		return YES;
	} else if ([self.house isEqualToString:@"Rigaud's"]) {
		return NO;
	} else if ([self.house isEqualToString:@"Busby's"]) {
		return NO;
	} else if ([self.house isEqualToString:@"Ashburnham"]) {
		return YES;
	} else if ([self.house isEqualToString:@"Milne's"]) {
		return YES;
	} else if ([self.house isEqualToString:@"Purcell's"]) {
		return NO;
	} else if ([self.house isEqualToString:@"College"]) {
		return YES;
	}
	return NO;
}

@end

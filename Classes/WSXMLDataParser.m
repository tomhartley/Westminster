//
//  WSXMLDataParser.m
//  Westminster
//
//  Created by Tom Hartley on 05/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSXMLDataParser.h"
#import "NSDate+Helper.h"
#import "WSPrep.h"
#import "WSDayFood.h"
#import "WSNotice.h"

@implementation WSXMLDataParser

-(NSDictionary *)parseTokenXML:(NSData *)xmlData {
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
														   options:0 
                                                             error:&error];
	[doc autorelease];
	if (doc == nil) { return nil; }
	//NSLog(@"%@", doc.rootElement);
	NSArray *authenticationStatuses = [doc.rootElement elementsForName:@"authentication"];
	NSString *authStatus = [[authenticationStatuses objectAtIndex:0] stringValue];
	if ([authStatus isEqual:@"successful"]) {
		NSString *token = [[[doc.rootElement elementsForName:@"token"] objectAtIndex:0] stringValue];
		NSString *expiresString = [[[doc.rootElement elementsForName:@"expires"] objectAtIndex:0] stringValue];
		[dict setObject:token forKey:@"token"];
		[dict setObject:expiresString forKey:@"date"];
		[dict setObject:@"YES" forKey:@"success"];
	} else {
		[dict setObject:@"NO" forKey:@"success"];
		return dict;
	}
	return dict;
}

-(NSString *)parseTokenCheckXML:(NSData *)xmlData {
	NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
														   options:0 error:&error];
	if (doc == nil) { return nil; }
	//NSLog(@"%@", doc.rootElement);
	NSArray *statuses = [doc.rootElement elementsForName:@"status"];
	NSString *status = [[statuses objectAtIndex:0] stringValue];
	[doc release];
	return status;
}

-(NSArray *)parseMeals:(NSData *)xmlData {
	NSMutableArray *meals = [NSMutableArray array];
	NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
														   options:0 error:&error];
	if (doc == nil) { return nil; }
	//NSLog(@"%@", doc.rootElement);
	NSArray *mealsToParse = [doc.rootElement elementsForName:@"menu"];
	for(int a = 0;a<[mealsToParse count];a++) {
		WSDayFood *food = [[WSDayFood alloc]init];
		NSArray *breakfast = [[[[[mealsToParse objectAtIndex:a] elementsForName:@"breakfast"] objectAtIndex:0] stringValue] componentsSeparatedByString:@"\n"];
		NSArray *lunch = [[[[[mealsToParse objectAtIndex:a] elementsForName:@"lunch"] objectAtIndex:0] stringValue] componentsSeparatedByString:@"\n"];
		NSArray *dinner = [[[[[mealsToParse objectAtIndex:a] elementsForName:@"supper"] objectAtIndex:0] stringValue] componentsSeparatedByString:@"\n"];
		food.breakfastItems=breakfast;
		food.lunchItems=lunch;
		food.dinnerItems = dinner;
		NSString *dateString = [[[[mealsToParse objectAtIndex:a] elementsForName:@"date"] objectAtIndex:0] stringValue];
		food.date = [NSDate dateFromString:dateString withFormat:@"yyyyMMdd"];
		[meals addObject:food];
		[food release];
	}
	[doc release];
	return meals;
}

-(NSArray *)parsePreps:(NSData *)xmlData {
	NSMutableArray *preps = [NSMutableArray array];
	NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
														   options:0 error:&error];
	if (doc == nil) { return nil; }
	//NSLog(@"%@", doc.rootElement);
	NSArray *prepsToParse = [doc.rootElement elementsForName:@"prep"];
	for(int a = 0;a<[prepsToParse count];a++) {
		WSPrep *prep = [[WSPrep alloc]init];
		[prep autorelease];
		prep.teacherInitials = [[[[prepsToParse objectAtIndex:a] elementsForName:@"teacherinitials"] objectAtIndex:0] stringValue];
		NSString *prepDescription = [[[[prepsToParse objectAtIndex:a] elementsForName:@"note"] objectAtIndex:0] stringValue];
        prep.descriptionText = prepDescription;
		prep.subject = [[[[prepsToParse objectAtIndex:a] elementsForName:@"subject"] objectAtIndex:0] stringValue];
		GDataXMLElement *document;
		@try {
			document = [[[prepsToParse objectAtIndex:a] elementsForName:@"document"] objectAtIndex:0];
		}
		@catch (NSException *exception) {
			document = nil;
		}
		prep.documentDescription = [[[document elementsForName:@"description"] objectAtIndex:0] stringValue];
		prep.documentFilename = [[[document elementsForName:@"filename"] objectAtIndex:0] stringValue];
		prep.documentID = [[[document elementsForName:@"documentID"] objectAtIndex:0] stringValue];
		prep.editable = [[[[[prepsToParse objectAtIndex:a] elementsForName:@"private"] objectAtIndex:0] stringValue] isEqualToString:@"1"];
		NSString *dateString = [[[[prepsToParse objectAtIndex:a] elementsForName:@"datedue"] objectAtIndex:0] stringValue];
		prep.dueDate = [NSDate dateFromString:dateString withFormat:@"yyyyMMdd"];
		[preps addObject:prep];
	}
	[doc release];
	return preps;
}

-(NSArray *)parseNotices:(NSData *)xmlData {
	NSMutableArray *notices = [NSMutableArray array];
	NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
														   options:0 error:&error];
	if (doc == nil) { return nil; }
	//NSLog(@"%@", doc.rootElement);
	NSArray *noticesToParse = [doc.rootElement elementsForName:@"notice"];
	for(int a = 0;a<[noticesToParse count];a++) {
		GDataXMLElement *el = [noticesToParse objectAtIndex:a];
		WSNotice *notice = [[WSNotice alloc] init];
		//ID, title, details,documentID,audience,expires,dateposted
		notice.noticeID = [[el elementsForName:@"ID"] objectAtIndex:0];
		@try {
			notice.noticeID = [[[el elementsForName:@"ID"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			notice.description = [[[el elementsForName:@"details"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			notice.title = [[[el elementsForName:@"title"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			NSString *dateString = [[[el elementsForName:@"dateposted"] objectAtIndex:0] stringValue];
			notice.addedDate = [NSDate dateFromString:dateString withFormat:@"yyyyMMdd"];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			NSString *dateString = [[[el elementsForName:@"expires"] objectAtIndex:0] stringValue];
			notice.removalDate = [NSDate dateFromString:dateString withFormat:@"yyyyMMdd"];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			notice.audience = [[[[el elementsForName:@"audience"] objectAtIndex:0] stringValue] integerValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			notice.documentID = [[[el elementsForName:@"documentID"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		//NSLog(@"%@",notice);
		[notice autorelease];
		[notices addObject:notice];
	}
	
	return notices;
}

-(WSProfile *)parseProfile:(NSData *)xmlData {
	WSProfile *profile = [[WSProfile alloc] init];
	NSError *error;
	GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
	options:0 error:&error];
	if (doc == nil) { return nil; }
	@try {
		GDataXMLElement *root = doc.rootElement;
		@try {
			profile.UWI = [[[root elementsForName:@"uwi"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.type = [[[root elementsForName:@"type"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.firstNames = [[[root elementsForName:@"forenames"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.surname = [[[root elementsForName:@"surname"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.initials = [[[root elementsForName:@"initials"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.preferredName = [[[root elementsForName:@"preferredname"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.gender = [[[[root elementsForName:@"sex"] objectAtIndex:0] stringValue] isEqualToString:@"M"] ? WSGenderMale:WSGenderFemale;
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			NSString *dateString = [[[root elementsForName:@"dateofbirth"] objectAtIndex:0] stringValue];
			profile.dateOfBirth = [NSDate dateFromString:dateString withFormat:@"yyyyMMdd"];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.email = [[[root elementsForName:@"emailaddress"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			NSString *dateString = [[[root elementsForName:@"dateofarrival"] objectAtIndex:0] stringValue];
			profile.dateOfArrival = [NSDate dateFromString:dateString withFormat:@"yyyyMMdd"];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.scholarhsip= [[[root elementsForName:@"scholarship"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.boarder = [[[[root elementsForName:@"boarder"] objectAtIndex:0] stringValue] isEqualToString:@"Yes"];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.house = [[[root elementsForName:@"housename"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.year = [[[root elementsForName:@"yearname"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.form = [[[root elementsForName:@"form"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.tutor = [[[root elementsForName:@"tutor"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.examID = [[[root elementsForName:@"examid"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.examUCI = [[[root elementsForName:@"examuci"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.examName = [[[root elementsForName:@"examname"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.previousSchool= [[[root elementsForName:@"previousschool"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.entryMethod = [[[root elementsForName:@"entrymethod"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
		@try {
			profile.mobileNumber = [[[root elementsForName:@"mobile"] objectAtIndex:0] stringValue];
		}
		@catch (NSException *exception) {
			NSLog(@"%@",exception);
		}
	}
	@catch (NSException *exception) {
		return nil;
	}
	
	return profile;
}

-(NSArray *)parseTimetable:(NSData *)xmlData {
    
}
@end

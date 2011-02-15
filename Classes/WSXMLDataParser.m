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

@implementation WSXMLDataParser

-(NSDictionary *)parseTokenXML:(NSData *)xmlData {
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
														   options:0 error:&error];
	[doc autorelease];
	if (doc == nil) { return nil; }
	NSLog(@"%@", doc.rootElement);
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
	NSLog(@"%@", doc.rootElement);
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
	NSLog(@"%@", doc.rootElement);
	NSArray *prepsToParse = [doc.rootElement elementsForName:@"prep"];
	for(int a = 0;a<[prepsToParse count];a++) {
		WSPrep *prep = [[WSPrep alloc]init];
		[prep autorelease];
		prep.teacherInitials = [[[[prepsToParse objectAtIndex:a] elementsForName:@"teacherinitials"] objectAtIndex:0] stringValue];
		NSString *prepDescription = [[[[prepsToParse objectAtIndex:a] elementsForName:@"note"] objectAtIndex:0] stringValue];
        prep.descriptionText = [prepDescription substringFromIndex:1];
		prep.subject = [[[[prepsToParse objectAtIndex:a] elementsForName:@"subject"] objectAtIndex:0] stringValue];
		prep.documentDescription = [[[[prepsToParse objectAtIndex:a] elementsForName:@"description"] objectAtIndex:0] stringValue];
		prep.documentFilename = [[[[prepsToParse objectAtIndex:a] elementsForName:@"filename"] objectAtIndex:0] stringValue];
		prep.documentID = [[[[prepsToParse objectAtIndex:a] elementsForName:@"documentID"] objectAtIndex:0] stringValue];
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
	/*NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
														   options:0 error:&error];
	if (doc == nil) { return nil; }
	NSLog(@"%@", doc.rootElement);
	NSArray *noticesToParse = [doc.rootElement elementsForName:@"prep"];
	for(int a = 0;a<[noticesToParse count];a++) {
		WSPrep *prep = [[WSPrep alloc]init];
		[prep autorelease];
		prep.teacherInitials = [[[[prepsToParse objectAtIndex:a] elementsForName:@"teacherinitials"] objectAtIndex:0] stringValue];
		NSString *prepDescription = [[[[prepsToParse objectAtIndex:a] elementsForName:@"note"] objectAtIndex:0] stringValue];
        prep.descriptionText = [prepDescription substringFromIndex:1];
		prep.subject = [[[[prepsToParse objectAtIndex:a] elementsForName:@"subject"] objectAtIndex:0] stringValue];
		prep.editable = [[[[[prepsToParse objectAtIndex:a] elementsForName:@"private"] objectAtIndex:0] stringValue] isEqualToString:@"1"];
		NSString *dateString = [[[[prepsToParse objectAtIndex:a] elementsForName:@"datedue"] objectAtIndex:0] stringValue];
		prep.dueDate = [NSDate dateFromString:dateString withFormat:@"yyyyMMdd"];
		[notices addObject:prep];
	}
	*/
	return notices;
}



@end

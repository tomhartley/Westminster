//
//  WSXMLDataParser.m
//  Westminster
//
//  Created by Tom Hartley on 05/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSXMLDataParser.h"
#import "NSDate+Helper.h"
#import "WSDayFood.h"

@implementation WSXMLDataParser

-(NSDictionary *)parseTokenXML:(NSData *)xmlData {
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData 
														   options:0 error:&error];
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
	}
	
	return meals;
}

@end

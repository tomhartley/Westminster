//
//  WSXMLDataParser.h
//  Westminster
//
//  Created by Tom Hartley on 05/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
@interface WSXMLDataParser : NSObject <NSXMLParserDelegate>{
    
}

-(NSDictionary *)parseTokenXML:(NSData *)xmlData;
-(NSString *)parseTokenCheckXML:(NSData *)xmlData;
-(NSArray *)parseMeals:(NSData *)xmlData;
-(NSArray *)parsePreps:(NSData *)xmlData;
-(NSArray *)parseNotices:(NSData *)xmlData;
@end

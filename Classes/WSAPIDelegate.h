//
//  WSAPIDelegate.h
//  Westminster
//
//  Created by Tom Hartley on 06/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import <TapkuLibrary/TapkuLibrary.h>
#import "WSXMLDataParser.h"

@interface WSAPIDelegate : NSObject {
}

-(void)mealsFinished:(ASIHTTPRequest *)request;
-(void)mealsFailed:(ASIHTTPRequest *)request;

-(void)prepsFinished:(ASIHTTPRequest *)request;
-(void)prepsFailed:(ASIHTTPRequest *)request;

-(void)noticesFinished:(ASIHTTPRequest *)request;
-(void)noticesFailed:(ASIHTTPRequest *)request;

@end

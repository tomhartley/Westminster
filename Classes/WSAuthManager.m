//
//  WSAuthManager.m
//  Westminster
//
//  Created by Tom Hartley on 06/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSAuthManager.h"
#import "NSDate+Helper.h"

static WSAuthManager *sharedInstance = nil;

@implementation WSAuthManager

-(void)updateAPITokenUsername:(NSString *)uName password:(NSString *)pWord saveForNextTime:(BOOL)shouldSave progressDelegate:(id)progressDelegate delegate:(id)del selector:(SEL)sely {
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.westminster.org.uk/api1/1/auth.asp?username=%@&password=%@",uName,pWord]];
	ASIHTTPRequest *APIreq = [[ASIHTTPRequest alloc] initWithURL:url];
	[APIreq setDownloadProgressDelegate:progressDelegate];
	[APIreq setShowAccurateProgress:YES];
	[APIreq setDelegate:self];
	[APIreq setUserInfo:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:NSStringFromSelector(sely),del,(shouldSave ? @"YES" : @"NO"), nil] forKeys:[NSArray arrayWithObjects:@"selector",@"delegate",@"shouldSave", nil]]];
	[APIreq setDidFinishSelector:@selector(loginResponse:)];
	[APIreq setDidFailSelector:@selector(loginResponseFailed:)];
	[APIreq startAsynchronous];
}

-(void)loginResponse:(ASIHTTPRequest *)APIReq {
	NSMutableDictionary *APIdict = [[[[[WSXMLDataParser alloc] init] autorelease] parseTokenXML:[APIReq responseData]] mutableCopy];
	SEL sely = NSSelectorFromString([[APIReq userInfo] objectForKey:@"selector"]);
	id del = [[APIReq userInfo] objectForKey:@"delegate"];
	[APIdict setObject:([[APIReq userInfo] objectForKey:@"shouldSave"]) forKey:@"shouldSave"];
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	
	[prefs setObject:APIdict forKey:@"APIToken"];
	[prefs synchronize];
	if ([[APIdict valueForKey:@"success"] isEqual:@"YES"]) {
		[del performSelector:sely withObject:@"YES"];
		return;
	}
	[del performSelector:sely withObject:@"NO"];
	[APIReq release];
}

-(void)loginAsGuest {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:[NSDictionary dictionaryWithObject:@"NO" forKey:@"success"] forKey:@"APIToken"];
}

-(BOOL)needsAuth {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	/*NSString *expires = [[prefs dictionaryForKey:@"APIToken"] objectForKey:@"date"];
	if (!expires) {
		return YES;
	} else if ([[NSDate dateFromString:expires withFormat:@"yyyyMMdd"] compare:[NSDate date]] == NSOrderedAscending){
		return NO;
	} else {
		return YES;
	}*/
	if ([[[prefs dictionaryForKey:@"APIToken"]objectForKey:@"shouldSave"] isEqual:@"NO"]) {
		return YES;
	}
	if ([self apiTokenIsValid:[[prefs dictionaryForKey:@"APIToken"]objectForKey:@"token"] ]) {
		return NO;
	} else {
		return YES;
	}
}

-(BOOL)apiTokenIsValid:(NSString *)token {
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.westminster.org.uk/api1/1/token.asp?token=%@",[token stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
	ASIHTTPRequest *APIreq = [[ASIHTTPRequest alloc] initWithURL:url];
	[APIreq autorelease];
	[APIreq startSynchronous];
	NSString *reply = [[[[WSXMLDataParser alloc] init] autorelease] parseTokenCheckXML :[APIreq responseData]];
	if ([reply isEqual:@"valid"]) {
		return YES;
	} else {
		return NO;
	}
}

-(void)signOut {
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setObject:[NSDictionary dictionaryWithObject:@"NO" forKey:@"success"] forKey:@"APIToken"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"WSDeletePersonalData" object:nil];
}

#pragma mark -
#pragma mark Singleton methods


+ (WSAuthManager *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
            sharedInstance = [[WSAuthManager alloc] init];
    }
    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [super allocWithZone:zone];
            return sharedInstance;  // assignment and return on first allocation
        }
    }
    return nil; // on subsequent allocation attempts return nil
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain {
    return self;
}

- (NSUInteger)retainCount {
    return UINT_MAX;  // denotes an object that cannot be released
}

- (void)release {
    //do nothing
}

- (id)autorelease {
    return self;
}

@end

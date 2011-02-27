//
//  WSDataFetcher.m
//  Westminster
//
//  Created by Tom Hartley on 07/09/2010.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "WSDataFetcher.h"
#import "WSDayFood.h"
#import "NSDate+Helper.h"
#import "WSAuthManager.h"

static WSDataFetcher *sharedInstance = nil;

@implementation WSDataFetcher

#pragma mark -
#pragma mark class instance methods

-(void)downloadAll {
	[self updateFood];
	[self updatePreps];
	[self updateProfile];
    [self updateNotices];
}

-(void)downloadAllAuthFree {
	[self updateFood];
}


-(void)updateEvents {
	
}

-(void)updateFood {
	NSString *fst = [[NSDate date] stringWithFormat:@"yyyyMMdd"];
	NSString *snd = [[[NSDate date] dateByAddingTimeInterval:8*60*24*60]stringWithFormat:@"yyyyMMdd"];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.westminster.org.uk/api1/1/menu.asp?fromdt=%@",fst,snd]];
	ASIHTTPRequest *APIreq = [[ASIHTTPRequest alloc] initWithURL:url];
	[APIreq setUserInfo:[NSDictionary dictionaryWithObject:@"menu" forKey:@"type"]];
	[APIreq setUserInfo:[NSDictionary dictionaryWithObject:@"Downloaded Menu" forKey:@"description"]];
	[APIreq autorelease];
	[APIreq setDidFinishSelector:@selector(mealsFinished:)];
	[APIreq setDidFailSelector:@selector(mealsFailed:)];
	APIreq.delegate=delegate;
	[networkQueue addOperation:APIreq];
	[networkQueue go];
	NSLog(@"%@",@"Data Download Started...");
}

-(void)updatePreps {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.westminster.org.uk/api1/1/prep.asp?token=%@",[[[WSAuthManager sharedInstance] apiToken] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
	ASIHTTPRequest *APIreq = [[ASIHTTPRequest alloc] initWithURL:url];
	[APIreq autorelease];
	[APIreq setDidFinishSelector:@selector(prepsFinished:)];
	[APIreq setDidFailSelector:@selector(prepsFailed:)];
	APIreq.delegate=delegate;
	[networkQueue addOperation:APIreq];
	[networkQueue go];
}

-(void)updateProfile {
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.westminster.org.uk/api1/1/profile.asp?token=%@",[[[WSAuthManager sharedInstance] apiToken] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
	ASIHTTPRequest *APIreq = [[ASIHTTPRequest alloc] initWithURL:url];
	[APIreq autorelease];
	[APIreq setDidFinishSelector:@selector(profileFinished:)];
	[APIreq setDidFailSelector:@selector(profileFailed:)];
	APIreq.delegate=delegate;
	[networkQueue addOperation:APIreq];
	[networkQueue go];
}

-(void)updateNotices {
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.westminster.org.uk/api1/1/notices.asp?token=%@",[[[WSAuthManager sharedInstance] apiToken] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];
	ASIHTTPRequest *APIreq = [[ASIHTTPRequest alloc] initWithURL:url];
	[APIreq autorelease];
	[APIreq setDidFinishSelector:@selector(noticesFinished:)];
	[APIreq setDidFailSelector:@selector(noticesFailed:)];
	APIreq.delegate=delegate;
	[networkQueue addOperation:APIreq];
	[networkQueue go];
}

-(void)updateClasses {
	
}

#pragma mark -
#pragma mark Singleton methods

-(WSDataFetcher *)init {
	[super init];
	delegate = [[WSAPIDelegate alloc] init];
	networkQueue = [[ASINetworkQueue alloc] init];
	networkQueue.delegate=delegate;
	/*
	[networkQueue setRequestDidFinishSelector:@selector(requestFinished:)];
	[networkQueue setRequestDidStartSelector:@selector(requestStarted:)];*/
	//[networkQueue setQueueDidFinishSelector:@selector(:)];
	
	return self;
}


+ (WSDataFetcher *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
            sharedInstance = [[WSDataFetcher alloc] init];
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

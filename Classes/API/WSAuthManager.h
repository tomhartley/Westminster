//
//  WSAuthManager.h
//  Westminster
//
//  Created by Tom Hartley on 06/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "WSXMLDataParser.h"
#import <TapkuLibrary/TapkuLibrary.h>

@interface WSAuthManager : NSObject {
    BOOL loggedIn;
}

+ (WSAuthManager *)sharedInstance;

-(void)updateAPITokenUsername:(NSString *)uName password:(NSString *)pWord saveForNextTime:(BOOL)shouldSave progressDelegate:(id)progressDelegate delegate:(id)del selector:(SEL)sely;
-(void)loginAsGuest;
-(BOOL)needsAuth;
-(BOOL)apiTokenIsValid:(NSString *)token;
-(void)loginResponse:(ASIHTTPRequest *)APIReq;
-(void)signOut;
-(NSString *)apiToken;
-(void)presentAuthController;

@property (readwrite,nonatomic) BOOL loggedIn;
@end

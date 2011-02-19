//
//  WSAboutController.h
//  Westminster
//
//  Created by Tom Hartley on 19/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface WSAboutController : UIViewController <MFMailComposeViewControllerDelegate>{
    
}
- (IBAction)email:(id)sender;

@end

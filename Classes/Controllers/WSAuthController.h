//
//  WSAuthController.h
//  Westminster
//
//  Created by Tom Hartley on 06/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TapkuLibrary/TapkuLibrary.h>


@interface WSAuthController : UIViewController {
	IBOutlet UITextField *pWordField;
	IBOutlet UITextField *uNameField;
	IBOutlet UISwitch *keepLoggedInSwitch;
	IBOutlet UIButton *loginButton;
	IBOutlet UIButton *guestLoginButton;
}
- (IBAction)login:(id)sender;
- (IBAction)guestLogin:(id)sender;
- (IBAction)dismissKeyboard:(UITextField *)sender;

@end

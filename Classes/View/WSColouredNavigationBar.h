//
//  WSColouredNavigationBar.h
//  Westminster
//
//  Created by Tom Hartley on 17/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSProfile.h"

@interface WSColouredNavigationBar : UINavigationBar {
    WSProfile *profile;
}

-(void)updateColours;
@end

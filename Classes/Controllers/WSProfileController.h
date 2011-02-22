//
//  WSProfileController.h
//  Westminster
//
//  Created by Tom Hartley on 19/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSProfile.h"

@interface WSProfileController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    WSProfile *profile;
	IBOutlet UITableView *tableView;
}
- (IBAction)signOut:(id)sender;
- (IBAction)refresh:(id)sender;
-(void)update;
-(void)getProfile;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

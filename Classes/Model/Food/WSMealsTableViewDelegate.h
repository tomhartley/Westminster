//
//  MealsTableViewDelegate.h
//  Westminster
//
//  Created by Tom Hartley on 29/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSDayFood.h"


@interface WSMealsTableViewDelegate : NSObject <UITableViewDataSource, UITableViewDelegate> {
    WSDayFood *foodDay;
}

@property (nonatomic, retain) WSDayFood *foodDay;

- (WSMealsTableViewDelegate *)initWithFood:(WSDayFood *)food;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (NSString *)dateString;

@end

//
//  MealsTableViewDelegate.m
//  Westminster
//
//  Created by Tom Hartley on 29/01/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSMealsTableViewDelegate.h"

@implementation WSMealsTableViewDelegate
@synthesize foodDay;

-(WSMealsTableViewDelegate *)initWithFood:(WSDayFood *)food{
	[super init];
	self.foodDay = food;
	return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)index {

	static NSString *CellIdentifier = @"Cell";

	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	cell.textLabel.textColor=[UIColor whiteColor];
	cell.textLabel.shadowColor = [UIColor blackColor];
	cell.textLabel.shadowOffset = CGSizeMake(0,1);
	cell.textLabel.backgroundColor = [UIColor darkGrayColor];
	cell.textLabel.adjustsFontSizeToFitWidth=YES;
	cell.contentView.backgroundColor=[UIColor darkGrayColor];
	
	int section = index.section;
	int row = index.row;
	
	switch (section) {
		case 0:
			cell.textLabel.text=[[foodDay breakfastItems] objectAtIndex:row];
			break;
		case 1:
			cell.textLabel.text=[[foodDay lunchItems] objectAtIndex:row];
			break;
		case 2:
			cell.textLabel.text=[[foodDay dinnerItems] objectAtIndex:row];
			break;
	}
	
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return [[foodDay breakfastItems] count];
			break;
		case 1:
			return [[foodDay lunchItems] count];
			break;
		case 2:
			return [[foodDay dinnerItems] count];
			break;
	}
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return @"Breakfast";
			break;
		case 1:
			return @"Lunch";
			break;
		case 2:
			return @"Dinner";
			break;
	}
	
	return @"";
}


- (NSString *)dateString {
	return @"Today???";
}
@end

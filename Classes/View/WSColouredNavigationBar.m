//
//  WSColouredNavigationBar.m
//  Westminster
//
//  Created by Tom Hartley on 17/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSColouredNavigationBar.h"
#import "WSDataManager.h"

@implementation WSColouredNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateColours) name:@"WSProfileUpdatedNotification" object:nil];
		[self updateColours];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super initWithCoder:aDecoder])) {
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateColours) name:@"WSProfileUpdatedNotification" object:nil];
		[self updateColours];
	}
	return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)updateColours {
	[profile release];
	profile = [[WSDataManager sharedInstance]currentProfile];
	[profile retain];
	self.tintColor = [profile primaryColor];
	CGRect frame = CGRectMake(0, 0, [self.topItem.title sizeWithFont:[UIFont boldSystemFontOfSize:20.0]].width, 44);
	UILabel *label = [[[UILabel alloc] initWithFrame:frame] autorelease];
	label.backgroundColor = [UIColor clearColor];
	label.font = [UIFont boldSystemFontOfSize:20.0];
	label.shadowColor = [profile shadowColor];
	if ([profile shadowOnTop]) {
		label.shadowOffset = CGSizeMake(0, -1);
	} else {
		label.shadowOffset = CGSizeMake(0, 1);
	}
	if ([profile secondaryColor]) {
		label.textColor = [profile secondaryColor];
	} else {
		label.textColor = [UIColor whiteColor];
		label.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
		label.shadowOffset = CGSizeMake(0, -1);
	}
	self.topItem.titleView = label;
	if (!profile) {
		self.topItem.titleView = nil;
	}
	label.text = self.topItem.title;
}

- (void)dealloc
{
	[profile release];
    [super dealloc];
}

@end

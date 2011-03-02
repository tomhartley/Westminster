//
//  WSNoticeCell.m
//  Westminster
//
//  Created by Tom Hartley on 27/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSNoticeCell.h"


@implementation WSNoticeCell
@synthesize description,title,expanded;

- (id)init{
    self = [super init];
    if (self) {
        // Initialization code
		description = [[UILabel alloc] init];
		title = [[UILabel alloc] init];
		titleBGView = [[UIView alloc] init];
		[self addSubview:titleBGView];
		[self addSubview:description];
		[self addSubview:title];
		description.backgroundColor = [UIColor clearColor];
		description.numberOfLines=0;
		title.numberOfLines=0;
		title.backgroundColor = [UIColor clearColor];
		title.shadowColor = [UIColor whiteColor];
		title.shadowOffset = CGSizeMake(0, 1);
		title.font = [UIFont systemFontOfSize:17];
		title.layer.cornerRadius = 3;
		description.font = [UIFont systemFontOfSize:14];
		description.lineBreakMode = UILineBreakModeWordWrap;
		title.lineBreakMode = UILineBreakModeWordWrap;
		titleBGView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
		
    }
	[self setNeedsLayout];
    return self;
}
//Font sizes: 14 for title, 12 for description, system font
-(int)getHeight {
	//if (!expanded) return 55;
	int width = [self superview].frame.size.width - 20;
	//Get the height of the title (5 px margin above + below)
    CGSize titleSize = [title.text sizeWithFont:[UIFont systemFontOfSize:17]constrainedToSize:CGSizeMake(width,10000) lineBreakMode:UILineBreakModeWordWrap];
	if (!expanded) {
		return titleSize.height+10;
	}
	//5 px + at top and bottom
    CGSize descriptionSize = [description.text sizeWithFont:[UIFont systemFontOfSize:14]constrainedToSize:CGSizeMake(width,10000) lineBreakMode:UILineBreakModeWordWrap];

	return descriptionSize.height+15+titleSize.height;
}
//10 pixel margin on the left and right
-(void)layoutSubviews {
	int width = self.frame.size.width - 20;
	if (expanded) {
		//Layout for expanded version
        CGSize titleSize = [title.text sizeWithFont:[UIFont systemFontOfSize:17]constrainedToSize:CGSizeMake(width,10000) lineBreakMode:UILineBreakModeWordWrap];
        CGSize descriptionSize = [description.text sizeWithFont:[UIFont systemFontOfSize:14]constrainedToSize:CGSizeMake(width,10000) lineBreakMode:UILineBreakModeWordWrap];
		title.frame = CGRectMake(10, 5, width, titleSize.height);
		titleBGView.frame = CGRectMake(0, 5, width+20, titleSize.height);
		description.frame=CGRectMake(10, title.frame.size.height+10, descriptionSize.width, descriptionSize.height);
        [UIView setAnimationsEnabled:YES];
        [UIView beginAnimations:@"alpha" context:nil];
        [UIView setAnimationDuration:0.3];
        [description setAlpha:1];
        [UIView commitAnimations];
	} else {
		//Layout for non-expanded version
        CGSize titleSize = [title.text sizeWithFont:[UIFont systemFontOfSize:17]constrainedToSize:CGSizeMake(width,10000) lineBreakMode:UILineBreakModeWordWrap];
		titleBGView.frame = CGRectMake(0, 5, width+20, titleSize.height);
        [UIView setAnimationsEnabled:YES];
        [UIView beginAnimations:@"alpha" context:nil];
        [UIView setAnimationDuration:0.3];
        [description setAlpha:0];
        [UIView commitAnimations];
		title.frame=CGRectMake(10.0, 5.0, self.frame.size.width-20, titleSize.height);
	}
}

-(void)toggleExpansion {
	self.expanded = !expanded;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

@end

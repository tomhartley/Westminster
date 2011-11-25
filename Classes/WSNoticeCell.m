//
//  WSNoticeCell.m
//  Westminster
//
//  Created by Tom Hartley on 27/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSNoticeCell.h"
#define TITLEFONTSIZE 18
#define DESCRIPTIONFONTSIZE 14
#define SIDEMARGINS 10

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
		//description.backgroundColor = [UIColor clearColor];
		description.numberOfLines=0;
		title.numberOfLines=0;
		title.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
		title.shadowColor = [UIColor whiteColor];
		title.shadowOffset = CGSizeMake(0, 1);
		title.font = [UIFont systemFontOfSize:TITLEFONTSIZE];
		title.layer.cornerRadius = 3;
		description.font = [UIFont systemFontOfSize:DESCRIPTIONFONTSIZE];
		description.lineBreakMode = UILineBreakModeWordWrap;
		//description.hidden=YES;
		description.alpha = 0;
		title.lineBreakMode = UILineBreakModeWordWrap;
		titleBGView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    }
	[self setNeedsLayout];
    return self;
}
//10 pixel margin on the left and right
-(void)layoutSubviews {
	int width = self.frame.size.width - SIDEMARGINS*2;
	if (expanded) {
		//Layout for expanded version
        CGSize titleSize = [title.text sizeWithFont:[UIFont systemFontOfSize:TITLEFONTSIZE]constrainedToSize:CGSizeMake(width,10000) lineBreakMode:UILineBreakModeWordWrap];
        CGSize descriptionSize = [description.text sizeWithFont:[UIFont systemFontOfSize:DESCRIPTIONFONTSIZE]constrainedToSize:CGSizeMake(width,10000) lineBreakMode:UILineBreakModeWordWrap];
		title.frame = CGRectMake(SIDEMARGINS, 15, width, titleSize.height);
		titleBGView.frame = CGRectMake(0, 5, width+SIDEMARGINS*2, titleSize.height+20);
		//description.hidden=NO;
        [UIView setAnimationsEnabled:YES];
        [UIView beginAnimations:@"alpha" context:nil];
        [UIView setAnimationDuration:0.3];
        [description setAlpha:1];
		description.frame=CGRectMake(SIDEMARGINS, title.frame.size.height+10+20, descriptionSize.width, descriptionSize.height);
        [UIView commitAnimations];
	} else {
		//Layout for non-expanded version
        CGSize titleSize = [title.text sizeWithFont:[UIFont systemFontOfSize:TITLEFONTSIZE]constrainedToSize:CGSizeMake(width,10000) lineBreakMode:UILineBreakModeWordWrap];
		titleBGView.frame = CGRectMake(0, 5, width+SIDEMARGINS*2, titleSize.height+20);
        [UIView setAnimationsEnabled:YES];
        [UIView beginAnimations:@"alpha" context:nil];
        [UIView setAnimationDuration:0.3];
        [description setAlpha:0];
		description.frame=CGRectMake(SIDEMARGINS, title.frame.size.height+10+20, width, 0);
        [UIView commitAnimations];
		//description.hidden=YES;
		title.frame=CGRectMake(SIDEMARGINS, 15, width, titleSize.height);
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
	[description release];
	[title release];
	[titleBGView release];
    [super dealloc];
}

@end

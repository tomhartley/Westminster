//
//  WSNoticeCell.h
//  Westminster
//
//  Created by Tom Hartley on 27/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WSNoticeCell : UITableViewCell {
    UILabel *description;
	UILabel *title;
	BOOL expanded;
}

@property (nonatomic,retain)UILabel *description;
@property (nonatomic,retain)UILabel *title;
@property (nonatomic) BOOL expanded;

-(void)toggleExpansion;
-(int)getHeight;
@end

//
//  WSPrepViewCell.h
//  Westminster
//
//  Created by Tom Hartley on 10/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WSPrepViewCell : UITableViewCell {
    IBOutlet UILabel *subjectLabel;
    IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *initialsLabel;
    IBOutlet UITextView *descriptionView;
}

@property (nonatomic, retain) UILabel *subjectLabel;
@property (nonatomic, retain) UILabel *initialsLabel;
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UITextView *descriptionView;

@end

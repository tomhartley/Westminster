//
//  WSClassCell.h
//  Westminster
//
//  Created by Tom Hartley on 23/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSLesson.h"

@interface WSClassCell : UITableViewCell {
    IBOutlet UILabel *subjectLabel;
    IBOutlet UILabel *timeStartLabel;
    IBOutlet UILabel *timeEndLabel;
    IBOutlet UILabel *locationLabel;
    IBOutlet UILabel *teacherLabel;
    IBOutlet UILabel *periodNumberLabel;
    IBOutlet UIView *colourView;
    WSLesson *lesson;
}

@property (nonatomic, retain) UILabel *subjectLabel;
@property (nonatomic, retain) UILabel *timeStartLabel;
@property (nonatomic, retain) UILabel *timeEndLabel;
@property (nonatomic, retain) UILabel *locationLabel;
@property (nonatomic, retain) UILabel *teacherLabel;
@property (nonatomic, retain) UILabel *periodNumberLabel;
@property (nonatomic, retain) UIView *colourView;
@property (nonatomic, retain) WSLesson *lesson;

@end

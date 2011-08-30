//
//  WSClassCell.m
//  Westminster
//
//  Created by Tom Hartley on 10/02/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WSClassCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation WSClassCell

@synthesize colourView,teacherLabel,subjectLabel,periodNumberLabel,timeStartLabel,timeEndLabel,locationLabel,lesson;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.colourView.layer.cornerRadius = 5.0;
    }
    return self;
}

-(void)setLesson:(WSLesson *)theLesson {
    lesson=theLesson;
    subjectLabel.text=lesson.class;
    timeStartLabel.text=[NSString stringWithFormat:@"%d:%d",lesson.startTime.hours,lesson.startTime.minutes];
    timeEndLabel.text=[NSString stringWithFormat:@"%d:%d",lesson.endTime.hours,lesson.endTime.minutes];
    locationLabel.text=lesson.location;
    teacherLabel.text=lesson.teacher;
    periodNumberLabel.text=[NSString stringWithFormat:@"%d",lesson.period];
    colourView.backgroundColor=[UIColor greenColor]; //FIXME
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

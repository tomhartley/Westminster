//
//  WSTimetable.h
//  Westminster
//
//  Created by administrator on 06/05/2011.
//  Copyright 2011 Westminster School. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    WSDayFormatShort,
    WSDayFormatLong
} WSDayFormat;


@interface WSTimetable : NSObject {
    NSMutableArray *days;
}



@end

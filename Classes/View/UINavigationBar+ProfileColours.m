//
//  UINavigationBar+ProfileColours.m
//  Westminster
//
//  Created by Tom Hartley on 31/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UINavigationBar+ProfileColours.h"
#import "WSColouredNavigationBar.h"

@implementation UINavigationBar (ProfileColours)

+(UINavigationBar *) allocWithZone:(NSZone *)zone {
	if (self == [UINavigationBar class]) {
		return NSAllocateObject([WSColouredNavigationBar class], 0, zone);
	} else {
		return [super allocWithZone:zone];
	}
}

@end

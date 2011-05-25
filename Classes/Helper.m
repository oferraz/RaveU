//
//  Helper.m
//  RaveU
//
//  Created by Ofer Raz on 12/28/10.
//  Copyright 2010 Infooar. All rights reserved.
//

#import "Helper.h"


@implementation Helper

+ (NSString *)getRankingImageURLWithRank:(NSString *)rank
{
	NSString *path = [[NSBundle mainBundle] pathForResource:[Helper getRankingImageNameWithRank:rank]  ofType:nil];
	return [NSString stringWithFormat: @"<img src=\"file://%@\" />", path];
}


/**
 * Return the name of the image of the stars
 * @param rank a string with the double value of the amount of stars between 1 to 5
 * @return string with the image file name
 */
+ (NSString *)getRankingImageNameWithRank:(NSString *)rank
{
	double dRank = [rank doubleValue];
	if ( dRank < 1.25) {
		return @"stars-1-0.gif";
	} else if (dRank < 1.75) {
		return @"stars-1-5.gif";
	} else if (dRank < 2.25) {
		return @"stars-2-0.gif";
	} else if (dRank < 2.75) {
		return @"stars-2-5.gif";
	} else if (dRank < 3.25) {
		return @"stars-3-0.gif";
	} else if (dRank < 3.75) {
		return @"stars-3-5.gif";
	} else if (dRank < 4.25) {
		return @"stars-4-0.gif";
	} else if (dRank < 4.75) {
		return @"stars-4-5.gif";
	} else {
		return @"stars-5-0.gif";
	}	
	
}


@end

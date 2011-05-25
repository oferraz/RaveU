//
//  BookReview.m
//  BookHelp
//
//  Created by Ofer Raz on 9/21/10.
//  Copyright 2010 GreenRoad Driving Technologies Ltd. All rights reserved.
//

#import "BookReview.h"
#import "Helper.h"


@implementation BookReview
@synthesize reviewUserName, reviewRating, reviewBody;

- (id) initWithUserName:(NSString *)userName reviewerRating:(NSString *)rating reviewString:(NSString *)review
{
	// Call the superclass's designated initializer 
	if (self = [super init]) {
		[self setReviewUserName:userName];
		[self setReviewRating:rating];
		[self setReviewBody:review];
	}
	
	// Return the address of the newly initialized object
	return self;
}

- (void)dealloc {
	[reviewUserName release]; 
	[reviewRating release];
	[reviewBody release];
	[super dealloc];
}

- (NSString *) getHTMLString
{
	NSMutableString *description = [[[NSMutableString alloc] initWithString:@"By: "] autorelease];
	[description appendString:reviewUserName];
	[description appendString:@"<br>Reviewer rating: "];
	[description appendString:[Helper getRankingImageURLWithRank:reviewRating]];
	[description appendString:@"<br>"];
	[description appendString:reviewBody];
	return description;
	

}


@end

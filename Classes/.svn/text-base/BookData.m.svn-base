//
//  BookData.m
//  BookHelp
//
//  Created by Ofer Raz on 9/21/10.
//  Copyright 2010 GreenRoad Driving Technologies Ltd. All rights reserved.
//

#import "BookData.h"
#import "BookReview.h"



@implementation BookData

@synthesize bookID, 
			bookISBN, 
			bookTitle, 
			bookImageUrl, 
			bookSmallImageUrl,
			bookDescription, 
			bookAverageRating, 
			bookReviewsCount,
			bookAuthor;

-(id) init
{
	// Call the superclass's designated initializer 
	if (self = [super init]) {
		bookReviews = [[NSMutableArray alloc] init];
	}
	return self;
}


- (void) addReviewWithUserName:(NSString *)userName 
				reviewerRating:(NSString *)rating 
				  reviewString:(NSString *)review
{
	BookReview *bookReview = [[BookReview alloc] initWithUserName:userName reviewerRating:rating reviewString:review];
	[bookReviews addObject:bookReview];
	[bookReview release];
	bookReview = nil;
	
}

- (void)dealloc {
	[bookID release];
	[bookISBN release]; 
	[bookTitle release];
	[bookImageUrl release];
	[bookSmallImageUrl release];
	[bookDescription release];
	[bookAverageRating release];
	[bookReviewsCount release];
	[bookReviews release];
	[bookAuthor release];
	
	[super dealloc];
}

- (int) getNumberOfReviews
{
	return [bookReviews count];
}

- (NSString *) getHTMLReviews
{
	NSMutableString *description = [[[NSMutableString alloc] init] autorelease];
	for (int i = 0; i < [bookReviews count]; i++) {
		[description appendString:[NSString stringWithFormat:@"%@ <br><br>", [[bookReviews objectAtIndex:i] getHTMLString]]];
	}
	return description;
}

@end

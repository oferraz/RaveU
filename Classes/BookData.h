//
//  BookData.h
//  BookHelp
//
//  Created by Ofer Raz on 9/21/10.
//  Copyright 2010 GreenRoad Driving Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookData : NSObject 
{
	NSString *bookID;
	NSString *bookISBN;
	NSString *bookTitle;
	NSString *bookImageUrl;
	NSString *bookSmallImageUrl;
	NSString *bookDescription;
	NSString *bookAverageRating;
	NSString *bookReviewsCount;
	NSString *bookAuthor;
	
	NSMutableArray *bookReviews;
}

@property (nonatomic, copy) NSString *bookID;
@property (nonatomic, copy) NSString *bookISBN;
@property (nonatomic, copy) NSString *bookTitle;
@property (nonatomic, copy) NSString *bookImageUrl;
@property (nonatomic, copy) NSString *bookSmallImageUrl;
@property (nonatomic, copy) NSString *bookDescription;
@property (nonatomic, copy) NSString *bookAverageRating;
@property (nonatomic, copy) NSString *bookReviewsCount;
@property (nonatomic, copy) NSString *bookAuthor;

- (void) addReviewWithUserName:(NSString *)userName reviewerRating:(NSString *)rating reviewString:(NSString *)review;
- (int) getNumberOfReviews; 
- (NSString *) getHTMLReviews;
 

@end

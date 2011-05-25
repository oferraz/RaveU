//
//  BookReview.h
//  BookHelp
//
//  Created by Ofer Raz on 9/21/10.
//  Copyright 2010 GreenRoad Driving Technologies Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BookReview : NSObject 
{
	NSString *reviewUserName;
	NSString *reviewRating;
	NSString *reviewBody;
}

@property (nonatomic, copy) NSString *reviewUserName;
@property (nonatomic, copy) NSString *reviewRating;
@property (nonatomic, copy) NSString *reviewBody;

- (id) initWithUserName:(NSString *)userName reviewerRating:(NSString *)rating reviewString:(NSString *)review;
- (NSString *) getHTMLString;

@end

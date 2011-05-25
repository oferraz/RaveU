//
//  BooksTableViewController.h
//  RaveU
//
//  Created by Ofer Raz on 12/3/10.
//  Copyright 2010 Infooar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookData, DetailViewControll;


@interface BooksTableViewController : UITableViewController <NSXMLParserDelegate>
{
	NSMutableData *xmlData;
	NSURLConnection *connectionInProgress;
	DetailViewControll *detailViewController;
	
	NSMutableArray *books;
	BookData *selectedBook;
	
	NSMutableString *xmlString;
	
	BOOL firstImageUrl, firstAverageRating, inReview, errorFlag;
	NSString *reviewName;
	NSString *reviewRating;
	NSString *reviewBody;
	NSString *dataError;
}

@property (nonatomic, retain) NSMutableArray *books;

@end

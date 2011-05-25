//
//  SearchViewController.h
//  BookHelp
//
//  Created by Ofer Raz on 9/20/10.
//  Copyright 2010 GreenRoad Driving Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AboutViewController, BookData, BooksTableViewController; 

@interface SearchViewController : UIViewController <NSXMLParserDelegate>
{
	NSMutableData *xmlData;
	NSURLConnection *connectionInProgress;
	
	BooksTableViewController *booksTableViewController;
	AboutViewController *aboutViewController;
	
	NSMutableArray *books;
	BookData *book;
	NSMutableString *xmlString;
	
	IBOutlet UITextField *ISBNField;
	
	bool newBook, bookId, errorFlag;
	NSString *dataError;
}

- (IBAction)searchBook:(id)sender;
- (void)loadAboutView:(id)sender;
- (void)search;

@end

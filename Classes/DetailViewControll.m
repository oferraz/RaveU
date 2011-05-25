//
//  DetailViewControll.m
//  BookHelp
//
//  Created by Ofer Raz on 9/22/10.
//  Copyright 2010 GreenRoad Driving Technologies Ltd. All rights reserved.
//

#import "DetailViewControll.h"
#import "BookData.h";
#import "Helper.h";


@implementation DetailViewControll

@synthesize bookData;

- (void) loadView
{
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
	
	CGRect imageRect = CGRectMake(0.0f, 0.0f, 320.0f, 416.0f);
	UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:imageRect];
	[backgroundImageView setImage:[UIImage imageNamed:@"background.png"]];
	backgroundImageView.opaque = YES; // explicitly opaque for performance
	[self.view addSubview:backgroundImageView];
	[backgroundImageView release];
	
	// Load placeholder for the image shadow
	CGRect shadowImageRect = CGRectMake(19.0f, 8.0f, 46.0f, 77.0f);
	shadowImage = [[UIImageView alloc] initWithFrame:shadowImageRect];
	[shadowImage setImage:[UIImage imageNamed:@"book_shadow.png"]];
	[self.view addSubview:shadowImage];
	
	CGRect coverImageRect = CGRectMake(5.0f, 5.0f, 54.0f, 74.0f);
	bookCoverImage = [[UIImageView alloc] initWithFrame:coverImageRect];
	[self.view addSubview:bookCoverImage];
	
	bookTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 250, 40)];
	[bookTitleLable setNumberOfLines:2];
	[self.view addSubview:bookTitleLable];
	
	bookISBNLable = [[UILabel alloc] initWithFrame:CGRectMake(70, 45, 200, 20)];
	[bookISBNLable setFont:[UIFont systemFontOfSize:10.0]];
	[self.view addSubview:bookISBNLable];
	
	bookRateLable = [[UILabel alloc] initWithFrame:CGRectMake(130, 61, 100, 20)];
	[bookRateLable setFont:[UIFont systemFontOfSize:14.0]];
	[self.view addSubview:bookRateLable];
	
	CGRect rankingImageRect = CGRectMake(70.0f, 65.0f, 55.0f, 12.0f);
	rankingImage = [[UIImageView alloc] initWithFrame:rankingImageRect];
	[self.view addSubview:rankingImage];
	
	bookDescriptionWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 90, 310, 320)];
	[bookDescriptionWebView setBackgroundColor:[UIColor clearColor]];
	[bookDescriptionWebView setOpaque:NO];
	[self.view addSubview:bookDescriptionWebView];
	
	//Goodreads Reviews
	UILabel *goodreadsLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 400, 320, 10)];
	[goodreadsLable setTextAlignment:UITextAlignmentCenter];
	[goodreadsLable setFont:[UIFont systemFontOfSize:10.0]];
	[goodreadsLable setText:@"Source: Goodreads Reviews"];
	[self.view addSubview:goodreadsLable];
	[goodreadsLable release];

}



- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	UIImage *coverImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[bookData bookSmallImageUrl]]]];
	[bookCoverImage setImage:coverImage];
	
	[bookTitleLable setText:[bookData bookTitle]];
	[bookISBNLable setText:[NSString stringWithFormat:@"ISBN: %@", [bookData bookISBN]]];
	[bookRateLable setText:[NSString stringWithFormat:@"(%@)", [bookData bookAverageRating]]];
	[rankingImage setImage:[UIImage imageNamed:[Helper getRankingImageNameWithRank:[bookData bookAverageRating]]]];
	
	NSMutableString *description = [[NSMutableString alloc] initWithString:[bookData bookDescription]] ;
	[description appendString:@" <br><br> "];
	[description appendString:[bookData getHTMLReviews]];
	[bookDescriptionWebView loadHTMLString:description baseURL:[NSURL URLWithString:@"http://www.hitchhiker.com/message"]];
	NSLog(@"description: %@", description);
	[description release];
	description = nil;
	
	[bookData release];
	bookData = nil;
}



- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



- (void)viewDidUnload 
{
    [super viewDidUnload];

	[shadowImage release];
	shadowImage = nil;
	[bookCoverImage release];
	bookCoverImage = nil;
	[bookTitleLable release];
	bookTitleLable = nil;
	[bookISBNLable release];
	bookISBNLable = nil;
	[bookRateLable release];
	bookRateLable = nil;
	[bookDescriptionWebView release];
	bookDescriptionWebView = nil;
	
	[bookData release];
	bookData = nil;
	
}



- (void)dealloc {
	[shadowImage release];
	[bookCoverImage release];
	[bookTitleLable release];
	[bookISBNLable release];
	[bookRateLable release];
	[bookDescriptionWebView release];
	
	[bookData release];
    [super dealloc];
}


@end

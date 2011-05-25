//
//  BooksTableViewController.m
//  RaveU
//
//  Created by Ofer Raz on 12/3/10.
//  Copyright 2010 Infooar. All rights reserved.
//

#import "BooksTableViewController.h"
#import "BookData.h"
#import "DetailViewControll.h"

NSString *const GOODREADS_KEY1 = @"????";    // replace with your key

@implementation BooksTableViewController

@synthesize books;

#pragma mark -
#pragma mark Initialization



- (id) init
{
	self = [super initWithStyle:UITableViewStyleGrouped];
	return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
	return [self init];
}



#pragma mark -
#pragma mark View lifecycle



- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[[self tableView] reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [books count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
	if (!cell) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
									   reuseIdentifier:@"UITableViewCell"] autorelease];
	}
	
	if ([indexPath row] < [books count]) {
		NSString *bt = [[NSString alloc] initWithString:[[books objectAtIndex:[indexPath row]] bookTitle]];
		[bt release];
		bt = nil;
		BookData *thisBook = [books objectAtIndex:[indexPath row]];
		[[cell textLabel] setText:[thisBook bookTitle]];
	}
	
	return cell;
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// get the selected book 
	selectedBook = [books objectAtIndex:[indexPath row]];
	NSLog(@"selectedBook retain: %i", [selectedBook retainCount]);
	
	// construct the web service URL
	NSString *requestURL = [[[NSString alloc] initWithFormat:@"http://www.goodreads.com/book/show?id=%@&key=%@", [selectedBook bookID], GOODREADS_KEY1] autorelease];
	NSURL *url = [NSURL URLWithString:requestURL]; 
	NSLog(@"%@",requestURL);
	
	// creating a request object with the URL
	NSURLRequest *request = [NSURLRequest requestWithURL:url 
											 cachePolicy:NSURLRequestReloadIgnoringCacheData 
										 timeoutInterval:30];
	// clear out existing connection
	if (connectionInProgress) {
		[connectionInProgress cancel];
		[connectionInProgress release];
	}
	
	// instantiate the object  to hold all the incoming XML
	[xmlData release];
	xmlData = [[NSMutableData alloc] init];
	
	//create and initiate a non-blocking connection
	connectionInProgress = [[NSURLConnection alloc] initWithRequest:request 
														   delegate:self 
												   startImmediately:YES];
	
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

//- (void)viewDidDisappear {
//}

- (void)viewDidUnload {
	[super viewDidUnload];
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark - URL request

/**
 * Collect the request data
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[xmlData appendData:data];
}

/**
 * We have all the data from the URL
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	// for debug - printing the xml to consule
	//NSString *xmlTxt = [[NSString alloc] initWithData:xmlData encoding:NSUTF8StringEncoding]; 
	//NSLog(@"*******************%@*******************", xmlTxt);
	
	// check if we have data to parse
	if ([xmlData length] < 5) {
		NSString *errorString = @"Book not found!";
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:errorString 
																 delegate:nil 
														cancelButtonTitle:@"OK" 
												   destructiveButtonTitle:nil 
														otherButtonTitles:nil];
		[actionSheet showInView:[[self view] window]];
		[actionSheet autorelease];
		return;
	}
	
	// create a parser
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
	[parser setDelegate:self];
	
	// set our parsing flags
	firstImageUrl = YES;
	firstAverageRating = YES;
	inReview = NO;
	errorFlag = NO;
	
	// do the parsing
	[parser parse];
	
	// the parser is done
	[parser release];
	
	// check for error
	if (errorFlag == YES) {
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:dataError 
																 delegate:nil 
														cancelButtonTitle:@"OK" 
												   destructiveButtonTitle:nil 
														otherButtonTitles:nil];
		[actionSheet showInView:[[self view] window]];
		[actionSheet autorelease]; 
		return;
	}
	
	//at this point we need to load the new view controll
	if (!detailViewController) {
		detailViewController = [[DetailViewControll alloc] init];
	}
	
	[detailViewController setBookData:selectedBook];
	NSLog(@"selectedBook retain: %i", [selectedBook retainCount]);
	selectedBook = nil;
	
	[[self navigationController] pushViewController:detailViewController 
										   animated:YES];
}

/**
 * URL connection error
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	[connectionInProgress release];
	connectionInProgress = nil;
	
	[xmlData release];
	xmlData = nil;
	
	NSString *errorString = [NSString stringWithFormat:@"%@", [error localizedDescription]];
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:errorString 
															 delegate:nil 
													cancelButtonTitle:@"OK" 
											   destructiveButtonTitle:nil 
													otherButtonTitles:nil];
	[actionSheet showInView:[[self view] window]];
	[actionSheet autorelease];
}


#pragma mark -
#pragma mark - XML Parsing

/**
 * Start parsing element start
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qualifiedName 
	attributes:(NSDictionary *)attributeDict
{
	//NSLog(@"Tag: %@", elementName);
	if ([elementName isEqual:@"error"]) {
		xmlString = [[NSMutableString alloc] init];
	} else if ([elementName isEqual:@"isbn13"]) {
		xmlString = [[NSMutableString alloc] init];
	} else if ([elementName isEqual:@"description"]) {
		xmlString = [[NSMutableString alloc] init];
	} else if ([elementName isEqual:@"average_rating"] && firstAverageRating == YES) {
		xmlString = [[NSMutableString alloc] init];
	} else if ([elementName isEqual:@"review"]) {
		NSLog(@"found review!");
		inReview = YES;
	} else if ([elementName isEqual:@"name"] && inReview == YES) {
		xmlString = [[NSMutableString alloc] init];
	} else if ([elementName isEqual:@"rating"] && inReview == YES) {
		xmlString = [[NSMutableString alloc] init];
	} else if ([elementName isEqual:@"body"] && inReview == YES) {
		xmlString = [[NSMutableString alloc] init];
	}  
	
}

/**
 * Collecting the element text
 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	[xmlString appendString:string];
}


/**
 * Parsing element end
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName
{
	if ([elementName isEqual:@"error"]) {
		//NSLog(@"ended title: %@", xmlString);
		errorFlag = YES;
		dataError = [xmlString copy];
		[xmlString release];
		xmlString = nil;
	} else if ([elementName isEqual:@"isbn13"]) {
		//NSLog(@"ended isbn: %@", xmlString);
		
		[selectedBook setBookISBN:xmlString];
		[xmlString release];
		xmlString = nil;
	} else if ([elementName isEqual:@"description"]) {
		NSLog(@"ended description: %@", xmlString);
		[selectedBook setBookDescription:xmlString];
		[xmlString release];
		xmlString = nil;
	} else if ([elementName isEqual:@"average_rating"] && firstAverageRating == YES) {
		//NSLog(@"ended average_rating: %@", xmlString);
		firstAverageRating = NO;
		[selectedBook setBookAverageRating:xmlString];
		[xmlString release];
		xmlString = nil;
	} else if ([elementName isEqual:@"review"]) {
		//NSLog(@"ended review: %@", xmlString);
		inReview = NO;
		// check if the review worth somthing
		if ([reviewBody length] > 4) {
			[selectedBook addReviewWithUserName:reviewName reviewerRating:reviewRating reviewString:reviewBody];
		}
		[reviewName release];
		reviewName = nil;
		[reviewRating release];
		reviewRating = nil;
		[reviewBody release];
		reviewBody = nil;
	} else if ([elementName isEqual:@"name"] && inReview == YES) {
		//NSLog(@"ended review: %@", xmlString);
		reviewName = [xmlString copy];
		[xmlString release];
		xmlString = nil;
	} else if ([elementName isEqual:@"rating"] && inReview == YES) {
		//NSLog(@"ended review: %@", xmlString);
		reviewRating = [xmlString copy];
		[xmlString release];
		xmlString = nil;
	} else if ([elementName isEqual:@"body"] && inReview == YES) {
		//NSLog(@"ended review: %@", xmlString);
		reviewBody = [xmlString copy];
		[xmlString release];
		xmlString = nil;
	}
	
	
}	

@end


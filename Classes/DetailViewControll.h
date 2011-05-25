//
//  DetailViewControll.h
//  BookHelp
//
//  Created by Ofer Raz on 9/22/10.
//  Copyright 2010 GreenRoad Driving Technologies Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookData;

@interface DetailViewControll : UIViewController {
	UIImageView *shadowImage;
	UIImageView *bookCoverImage;
	UIImageView *rankingImage;
	
	UILabel *bookTitleLable;
	UILabel *bookISBNLable;
	UILabel *bookRateLable;
	UIWebView *bookDescriptionWebView;
	
	BookData *bookData;
	
}

@property (nonatomic, retain) BookData *bookData;

@end

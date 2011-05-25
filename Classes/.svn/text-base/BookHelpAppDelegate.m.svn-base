//
//  BookHelpAppDelegate.m
//  BookHelp
//
//  Created by Ofer Raz on 9/20/10.
//  Copyright GreenRoad Driving Technologies Ltd. 2010. All rights reserved.
//

#import "BookHelpAppDelegate.h"
#import "SearchViewController.h"

@implementation BookHelpAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions 
{    
	searchViewController = [[SearchViewController alloc] init];
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:searchViewController];
	[window addSubview:[navController view]];
	
    [window makeKeyAndVisible];
	
	return YES;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [window release];
    [super dealloc];
}


@end

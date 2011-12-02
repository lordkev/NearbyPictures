//
//  AppDelegate.m
//  NearbyPictures
//
//  Created by Kevin Lord on 12/1/11.
//  Copyright (c) 2011 Kapps. All rights reserved.
//

#import "AppDelegate.h"

#import "KLPicture.h"

#import "KLPicturesViewController.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Make the status bar sexy black
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = [[[KLPicturesViewController alloc] init] autorelease];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end

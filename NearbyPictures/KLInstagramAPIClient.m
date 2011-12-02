//
//  KLInstagramAPIClient.m
//  NearbyPictures
//
//  Created by Kevin Lord on 12/1/11.
//  Copyright (c) 2011 Kapps. All rights reserved.
//

#import "KLInstagramAPIClient.h"

#import "AFJSONRequestOperation.h"

// Define some constants for the Instagram API we'll be hitting
NSString * const kKLInstagramClientID = @"a68185b330d24363887b4d73cc4e8d94";
NSString * const kKLInstagramBaseURLString = @"https://api.instagram.com/v1/";

@implementation KLInstagramAPIClient

// Create a singleton shared client to be used throughout the app
+ (KLInstagramAPIClient *)sharedClient {
    static KLInstagramAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kKLInstagramBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

@end

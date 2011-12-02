//
//  KLInstagramAPIClient.h
//  NearbyPictures
//
//  Created by Kevin Lord on 12/1/11.
//  Copyright (c) 2011 Kapps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPClient.h"

// This class is a slightly modified version of that provided in the AFNetworking sample
// projects.

extern NSString * const kKLInstagramClientID;
extern NSString * const kKLInstagramBaseURLString;

@interface KLInstagramAPIClient : AFHTTPClient
+ (KLInstagramAPIClient *)sharedClient;
@end

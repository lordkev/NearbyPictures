//
//  KLPicture.m
//  NearbyPictures
//
//  Created by Kevin Lord on 12/1/11.
//  Copyright (c) 2011 Kapps. All rights reserved.
//

#import "KLPicture.h"

#import "KLInstagramAPIClient.h"

@implementation KLPicture

@synthesize thumbnailURLString;
@synthesize standardResURLString;

- (void)dealloc {
    [thumbnailURLString release];
    [standardResURLString release];
    [super dealloc];
}

+ (void)getPicturesNearLatitude:(float)lat longitude:(float)lon block:(void (^)(NSArray *pictures))block {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:kKLInstagramClientID forKey:@"client_id"];
    [params setValue:[NSNumber numberWithFloat:lat] forKey:@"lat"];
    [params setValue:[NSNumber numberWithFloat:lon] forKey:@"lng"];
    [params setValue:[NSNumber numberWithInt:5000] forKey:@"distance"];
    [params setValue:[NSNumber numberWithInt:50] forKey:@"count"];
    
    [[KLInstagramAPIClient sharedClient] getPath:@"media/search" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *returnedImages = [responseObject valueForKeyPath:@"data"];
        NSMutableArray *pictures = [NSMutableArray array];
        
        for (id image in returnedImages) {
            KLPicture *picture = [[[KLPicture alloc] init] autorelease];
            picture.thumbnailURLString = [image valueForKeyPath:@"images.thumbnail.url"];
            picture.standardResURLString = [image valueForKeyPath:@"images.standard_resolution.url"];
            [pictures addObject:picture];
        }
        
        if (block) {
            block(pictures);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", error);
    }];
}

+ (void)getPopularPicturesWithBlock:(void (^)(NSArray *pictures))block {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    [params setValue:kKLInstagramClientID forKey:@"client_id"];
    [params setValue:[NSNumber numberWithInt:50] forKey:@"count"];
    
    [[KLInstagramAPIClient sharedClient] getPath:@"media/popular" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *returnedImages = [responseObject valueForKeyPath:@"data"];
        NSMutableArray *pictures = [NSMutableArray array];
        
        for (id image in returnedImages) {
            KLPicture *picture = [[[KLPicture alloc] init] autorelease];
            picture.thumbnailURLString = [image valueForKeyPath:@"images.thumbnail.url"];
            picture.standardResURLString = [image valueForKeyPath:@"images.standard_resolution.url"];
            [pictures addObject:picture];
        }
        
        if (block) {
            block(pictures);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", error);
    }];
}
@end

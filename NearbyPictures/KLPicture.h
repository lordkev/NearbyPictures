//
//  KLPicture.h
//  NearbyPictures
//
//  Created by Kevin Lord on 12/1/11.
//  Copyright (c) 2011 Kapps. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface KLPicture : NSObject

@property (nonatomic, retain) NSString *thumbnailURLString;
@property (nonatomic, retain) NSString *standardResURLString;

+ (void)getPicturesNearLatitude:(float)lat longitude:(float)lon block:(void (^)(NSArray *pictures))block;
+ (void)getPopularPicturesWithBlock:(void (^)(NSArray *pictures))block;
@end

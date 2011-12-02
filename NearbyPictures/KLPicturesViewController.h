//
//  KLPicturesViewController.h
//  NearbyPictures
//
//  Created by Kevin Lord on 12/1/11.
//  Copyright (c) 2011 Kapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "KLPictureViewController.h"

@interface KLPicturesViewController : UITableViewController <CLLocationManagerDelegate, KLPictureViewControllerDelegate>

@property (nonatomic, retain) NSArray *pictures;

@end

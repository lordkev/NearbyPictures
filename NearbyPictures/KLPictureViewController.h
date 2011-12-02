//
//  KLPictureViewController.h
//  NearbyPictures
//
//  Created by Kevin Lord on 12/1/11.
//  Copyright (c) 2011 Kapps. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KLPicture.h"

@class KLPictureViewController;

// Define a simple delegate so that the viewer can tell it's parent controller
// when the user has indicated he's done with it.
@protocol KLPictureViewControllerDelegate <NSObject>
- (void)userFinishedViewingPicture;
@end

@interface KLPictureViewController : UIViewController

@property (nonatomic, assign) id <KLPictureViewControllerDelegate> delegate;
@property (nonatomic, retain) KLPicture *picture;
@property (nonatomic, retain) UIImageView *pictureImageView;

@end

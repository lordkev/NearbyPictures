//
//  KLPictureViewController.m
//  NearbyPictures
//
//  Created by Kevin Lord on 12/1/11.
//  Copyright (c) 2011 Kapps. All rights reserved.
//

#import "KLPictureViewController.h"

#import "UIImageView+AFNetworking.h"

// Use an anonymous category to define "private" properties / methods
@interface KLPictureViewController ()
- (void)userDidTap;
@end

@implementation KLPictureViewController

@synthesize delegate;
@synthesize picture;
@synthesize pictureImageView;

- (void)dealloc {
    self.delegate = nil;
    [picture release];
    [pictureImageView release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (!self) {
        return nil;
    }
    
    return self;
}

#pragma mark - Actions

// Call the delegate protocal method when the user has tapped, to indicate
// to the parent controller that it should close the viewer
- (void)userDidTap {
    [self.delegate userFinishedViewingPicture];
}

#pragma mark - UIViewController

- (void)loadView
{
    self.view = [[[UIView alloc] init] autorelease];
    self.view.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
    
    self.pictureImageView = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 80.0f, 320.0f, 320.0f)] autorelease];
    [self.view addSubview:pictureImageView];
    
    // Add a gesture recognizer for a single tap so the user can easily dismiss the viewer
    UITapGestureRecognizer *singleTapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userDidTap)] autorelease];
    [self.view addGestureRecognizer:singleTapRecognizer];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set the image using the AFNetworking UIImageView category
    // I <3 AFNetworking
    [self.pictureImageView setImageWithURL:[NSURL URLWithString:self.picture.standardResURLString]];
}

@end

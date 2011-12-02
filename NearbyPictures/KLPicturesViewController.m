//
//  KLPicturesViewController.m
//  NearbyPictures
//
//  Created by Kevin Lord on 12/1/11.
//  Copyright (c) 2011 Kapps. All rights reserved.
//

#import "KLPicturesViewController.h"
#import "KLPictureViewController.h"

#import "KLPicture.h"

#import "UIImageView+AFNetworking.h"

// Use an anonymous category to define "private" properties / methods
@interface KLPicturesViewController ()
@property (nonatomic, retain) KLPictureViewController *pictureViewController;
@property (nonatomic, retain) CLLocationManager *locationManager;
- (void)showPicture:(id)sender;
@end
    
@implementation KLPicturesViewController

@synthesize pictures;
@synthesize pictureViewController;
@synthesize locationManager;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (!self) {
        return nil;
    }
    
    // Initialize and configure our location manager to get location updates.
    // If this was a more complex app, it should be moved to an app-level shared manager
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    self.locationManager.distanceFilter = 500;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    self.pictures = [NSArray array];

    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    return self;
}

- (void)dealloc {
    [locationManager stopUpdatingLocation];
    [pictures release];
    [pictureViewController release];
    [locationManager release];
    [super dealloc];
}

#pragma mark - Actions

// Show the picture viewer controller when a user taps one of the pictures
- (void)showPicture:(id)sender {
    NSUInteger imageIndex = ((UIButton *)sender).tag;
    
    self.pictureViewController = [[[KLPictureViewController alloc] init] autorelease];
    self.pictureViewController.delegate = self;
    self.pictureViewController.picture = (KLPicture *)[self.pictures objectAtIndex:imageIndex];
    
    [self presentModalViewController:pictureViewController animated:YES];
}

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor blackColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Use 4 pictures per row, round up to the next whole number
    return (([self.pictures count] + 4) - 1) / 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PicturesCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // The customizations here were fairly simple and wouldn't be resused, so it seemed to 
    // make more sense to do it in the cell configuration instead of subclassing UITableViewCell
    cell.backgroundColor = [UIColor blackColor];
    
    for (int n = 0; n < 4 && ((indexPath.row * 4) + n) < [self.pictures count]; n++) {
        NSUInteger imageIndex = ((indexPath.row * 4) + n);
        UIImageView *imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(n * 80.0f, 0.0f, 80.0f, 80.0f)] autorelease];
        imageView.backgroundColor = [UIColor blackColor];
        [imageView setImageWithURL:[NSURL URLWithString:((KLPicture *)[self.pictures objectAtIndex:imageIndex]).thumbnailURLString]];
        [cell.contentView addSubview:imageView];
        // Add a transparent button laid over the picture to bring up the photo viewer when tapped
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = imageView.frame;
        // Tag the button so it can be used later to determine which picture to show
        button.tag = imageIndex;
        [button addTarget:self action:@selector(showPicture:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:button];
    }
    
    return cell;
}

#pragma mark - UITableView

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

#pragma mark - KLPictureViewControllerDelegate

// Dismiss the picture viewer when the user has finished
- (void)userFinishedViewingPicture {
    [UIView animateWithDuration:0.2f animations:^{
        self.pictureViewController.view.alpha = 0.0f;
    } completion:^(BOOL finished){
        [self dismissModalViewControllerAnimated:NO];
        self.pictureViewController = nil;
    }];
}

#pragma mark - CLLocationManagerDelegate

// If we receive a location from location services, then pull pictures near our location
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [KLPicture getPicturesNearLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude block:^(NSArray *pics) {
        self.pictures = pics;
        [self.tableView reloadData];
    }];
}

// If we're unable to get a location, simply pull popular pictures
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [KLPicture getPopularPicturesWithBlock:^(NSArray *pics) {
        self.pictures = pics;
        [self.tableView reloadData];
    }];
}

@end

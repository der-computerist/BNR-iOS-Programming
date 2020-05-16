//
//  BNRImageViewController.m
//  Homepwner
//
//  Created by Enrique Aliaga Chavez on 10/29/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageViewController.h"

@interface BNRImageViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) BOOL zoomScaleSet;

@end

@implementation BNRImageViewController

#pragma mark - Controller lifecycle

- (void)loadView
{
    // This scroll view will allow us to zoom on the image
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.delegate = self;

    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;

    [scrollView addSubview:imageView];
    
    // Do not produce translated constraints for these views
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Map used for programatically creating constraints
    NSDictionary *nameMap = @{ @"imageView": imageView };

    // The image view is 0 points from superview on all edges
    NSArray *horizontalPinConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|"
                                                options:0
                                                metrics:nil
                                                  views:nameMap];
    NSArray *verticalPinConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|"
                                                options:0
                                                metrics:nil
                                                  views:nameMap];
    
    [scrollView addConstraints:horizontalPinConstraints];
    [scrollView addConstraints:verticalPinConstraints];

    self.view = scrollView;
    self.imageView = imageView;
    self.scrollView = scrollView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.imageView.image = self.image;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (!self.zoomScaleSet) {
        [self setZoomScale];
        [self centerScaledContent];
    }
}

#pragma mark - Scroll view delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark - Internal

- (void)setZoomScale
{
    CGSize imageViewSize = self.imageView.bounds.size;
    CGSize scrollViewSize = self.scrollView.bounds.size;
    
    float widthScale = scrollViewSize.width / imageViewSize.width;
    float heightScale = scrollViewSize.height / imageViewSize.height;
    float minScale = MIN(widthScale, heightScale);
    
    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.zoomScale = minScale;
    self.zoomScaleSet = YES;
}

- (void)centerScaledContent
{
    CGFloat contentHeight = self.scrollView.contentSize.height;
    CGFloat contentWidth = self.scrollView.contentSize.width;
    CGFloat scrollViewHeight = self.scrollView.bounds.size.height;
    CGFloat scrollViewWidth = self.scrollView.bounds.size.width;

    if (contentHeight < scrollViewHeight) {
        CGFloat yInset = (scrollViewHeight - contentHeight)/2;
        self.scrollView.contentInset = UIEdgeInsetsMake(yInset, 0, yInset, 0);
    }
    if (contentWidth < scrollViewWidth) {
        CGFloat xInset = (scrollViewWidth - contentWidth)/2;
        self.scrollView.contentInset = UIEdgeInsetsMake(0, xInset, 0, xInset);
    }
}

@end

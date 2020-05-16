//
//  BNRWebViewController.m
//  Nerdfeed
//
//  Created by Enrique Aliaga Chavez on 12/24/19.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

#import "BNRWebViewController.h"

@interface BNRWebViewController () <UIWebViewDelegate>

@property (nonatomic) UIWebView *webView;
@property (nonatomic) UIBarButtonItem *backButton;
@property (nonatomic) UIBarButtonItem *forwardButton;

@end


@implementation BNRWebViewController

#pragma mark - View life cycle

- (void)loadView
{
    self.view = [[UIView alloc] init];
    
    [self setUpWebView];
    [self setUpToolbar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.toolbarHidden = NO;
    // Make sure the navigation buttons are disabled when first loading a web page.
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
    
    if (_URL) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_URL];
        [self.webView loadRequest:req];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.toolbarHidden = YES;
}

#pragma mark - Button actions

- (void)goBack:(id)sender
{
    [self.webView goBack];
}

- (void)goForward:(id)sender
{
    [self.webView goForward];
}

#pragma mark - UIWebView delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.backButton.enabled = self.webView.canGoBack
        && ![[self.webView.request URL] isEqual:self.URL];
    self.forwardButton.enabled = self.webView.canGoForward;
}

#pragma mark - Internal

- (void)setUpWebView
{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    webView.translatesAutoresizingMaskIntoConstraints = NO;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // Constraints
    
    NSDictionary *nameMap = @{ @"webView": webView };
    
    NSArray *horizontalConstraints = [NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|[webView]|" options:0 metrics:nil views:nameMap];
    NSArray *verticalConstraints = [NSLayoutConstraint
        constraintsWithVisualFormat:@"V:|[webView]|" options:0 metrics:nil views:nameMap];
    
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
    
    self.webView = webView;
}

- (void)setUpToolbar
{
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
        initWithImage:[UIImage imageNamed:@"Back.png"] style:UIBarButtonItemStylePlain target:self
        action:@selector(goBack:)];
    backButton.enabled = NO;
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
        initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpace.width = 10.0;
    
    UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc]
        initWithImage:[UIImage imageNamed:@"Forward.png"] style:UIBarButtonItemStylePlain
        target:self action:@selector(goForward:)];
    forwardButton.enabled = NO;
    
    NSArray *toolbarButtons = @[ backButton, fixedSpace, forwardButton ];
    self.toolbarItems = toolbarButtons;
    
    self.backButton = backButton;
    self.forwardButton = forwardButton;
}

@end

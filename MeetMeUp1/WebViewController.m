//
//  WebViewController.m
//  MeetMeUp1
//
//  Created by Kyle Magnesen on 1/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:req];

    [self.backButton setEnabled:NO];
    [self.forwardButton setEnabled:NO];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
    
    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
}

- (IBAction)onBackButtonTapped:(UIButton *)sender {
    [self.webView goBack];
}

- (IBAction)onForwardButtonTapped:(UIButton *)sender {
    [self.webView goForward];
}


@end
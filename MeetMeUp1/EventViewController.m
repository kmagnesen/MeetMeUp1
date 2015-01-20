//
//  EventViewController.m
//  MeetMeUp1
//
//  Created by Kyle Magnesen on 1/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "EventViewController.h"
#import "WebViewController.h"
#import "CommentsViewController.h"

@interface EventViewController ()
@property (strong, nonatomic) IBOutlet UITextView *eventName;
@property (strong, nonatomic) IBOutlet UITextView *rsvpLabel;
@property (strong, nonatomic) IBOutlet UITextView *hostedLabel;
@property (strong, nonatomic) IBOutlet UIWebView *descWebView;


@end

@implementation EventViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Details";
    // setting name text
    NSString *name = [self.event objectForKey:@"name"];
    if (name.length > 50) {
        [self.eventName setFont:[UIFont systemFontOfSize:10]];
    }
    self.eventName.text = [self.event objectForKey:@"name"];
    self.eventName.editable = NO;
    // setting rsvp count
    NSString *rsvp = [NSString stringWithFormat:@"RSVP COUNT: %@", [self.event objectForKey:@"yes_rsvp_count"]];
    self.rsvpLabel.text = rsvp;
    self.rsvpLabel.textColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1];
    self.rsvpLabel.editable = NO;
    // setting group info
    NSString *groupName = [[self.event objectForKey:@"group"] objectForKey:@"name"];
    self.hostedLabel.text = [NSString stringWithFormat:@"HOSTED BY: \n %@", groupName];
    self.hostedLabel.editable = NO;
    // setting description
    NSString *desc = [self.event objectForKey:@"description"];
    NSString *htmlString = [NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-family: \"%@\"; font-size: %@;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>%@</body> \n"
                            "</html>", @"helvetica-light", [NSNumber numberWithInt:15], desc];
    [self.descWebView loadHTMLString:htmlString baseURL:nil];

    //NSLog(@"%@", self.event);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"GoComments"]) {
        CommentsViewController *detailVC = segue.destinationViewController;
        detailVC.event = self.event;
    } else {
        WebViewController *detailVC = segue.destinationViewController;
        detailVC.urlString = [self.event objectForKey:@"event_url"];
}
}
@end

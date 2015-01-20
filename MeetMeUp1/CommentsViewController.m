//
//  CommentsViewController.m
//  MeetMeUp1
//
//  Created by Kyle Magnesen on 1/20/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentTableViewCell.h"

@interface CommentsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSMutableArray *comments;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Comments";
    // get the id
    NSString *eID = [self.event objectForKey:@"id"];
    NSLog(@"real id: %@", [self.event objectForKey:@"id"]);
    NSLog(@"converted: %@", eID);
    // get the new query

    NSString *urlString = [NSString stringWithFormat:@"https://api.meetup.com/2/event_comments.json?event_id=%@&key=7747177c3d2f6a1d60543e7e76b2240", eID];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)

     {
         // putting results in a dictionary
         NSDictionary *commentDict = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:NSJSONReadingAllowFragments
                                                                       error:&connectionError];


//         NSLog(@"%@", commentDict);
         self.comments = [commentDict objectForKey:@"results"];

         [self.tableView reloadData];
     }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    NSDictionary *comment = [self.comments objectAtIndex:indexPath.row];

    NSString *timeString = [NSString stringWithFormat:@"%@", [comment objectForKey:@"time"]];
    timeString = [timeString substringToIndex:[timeString length] - 3];
    NSLog(@"timestring: %@", timeString);

    NSTimeInterval interval = [timeString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString *dateString = [NSString stringWithFormat:@"%@", date];
    dateString = [dateString substringToIndex:[dateString length] - 6];
    NSLog(@"%@", date);

    cell.commentTextView.text = [comment objectForKey:@"comment"];
    cell.memberLabel.text = [comment objectForKey:@"member_name"];
    cell.dateLabel.text = dateString;

    return cell;
}


@end

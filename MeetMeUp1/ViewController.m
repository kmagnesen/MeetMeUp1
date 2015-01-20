//
//  ViewController.m
//  MeetMeUp1
//
//  Created by Kyle Magnesen on 1/19/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "ViewController.h"
#import "EventViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property NSMutableArray *events;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self getEventsWithSubject:@"mobile"];

}

// helper that gets events
-(void)getEventsWithSubject:(NSString *)subject {

    NSString *urlString = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=477d1928246a4e162252547b766d3c6d"];

    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         // put results in a dictionary
         NSDictionary *eventDict = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:&connectionError];

         // extract events array
         self.events = [eventDict objectForKey:@"results"];
         //NSLog(@"%@", self.events);
         [self.tableView reloadData];
     }];
}

// search bar methods
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    //NSLog(@"Search Bar Entered");
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    // dismiss keyboard
    [self.searchBar resignFirstResponder];
    [self getEventsWithSubject:self.searchBar.text];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    // get event dictionary
    NSDictionary *eventsDict = [self.events objectAtIndex:indexPath.row];
    // get name and address
    cell.textLabel.text = [eventsDict objectForKey:@"name"];
    // get address
    NSString *address = [[eventsDict objectForKey:@"venue"] objectForKey:@"address_1"];
    cell.detailTextLabel.text = address;
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    EventViewController *detailVC = segue.destinationViewController;
    // get event dictionary
    NSDictionary *eventDict = [self.events objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    detailVC.event = eventDict;
    
}


@end
//
//  CommentTableViewCell.h
//  MeetMeUp1
//
//  Created by Kyle Magnesen on 1/20/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UITextView *commentTextView;
@property (strong, nonatomic) IBOutlet UILabel *memberLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;


@end

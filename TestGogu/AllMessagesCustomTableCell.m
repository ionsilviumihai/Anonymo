//
//  AllMessagesCustomTableCell.m
//  TestGogu
//
//  Created by Ion Silviu on 4/18/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "AllMessagesCustomTableCell.h"

@implementation AllMessagesCustomTableCell
@synthesize messageLabel, detailsLabel, likesLabel, dislikesLabel, commentsLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - UI IBActions
- (IBAction)likeButton:(id)sender {
}

- (IBAction)dislikeButton:(id)sender {
}

- (IBAction)commentButton:(id)sender {
}
- (IBAction)fileButton:(id)sender {
}
@end

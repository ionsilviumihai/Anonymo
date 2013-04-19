//
//  AllMessagesCustomTableCell.h
//  TestGogu
//
//  Created by Ion Silviu on 4/18/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllMessagesCustomTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dislikesLabel;
- (IBAction)likeButton:(id)sender;
- (IBAction)dislikeButton:(id)sender;
- (IBAction)commentButton:(id)sender;
- (IBAction)fileButton:(id)sender;

@end

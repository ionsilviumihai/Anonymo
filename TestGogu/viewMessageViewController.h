//
//  viewMessageViewController.h
//  TestGogu
//
//  Created by Ion Silviu on 4/14/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface viewMessageViewController : UIViewController<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (nonatomic, strong) NSString* mesaj;
@property (nonatomic, strong) NSString* details;
@property (nonatomic, strong) NSString* idMesaj;

- (IBAction)likeButton:(id)sender;
- (IBAction)dislikeButton:(id)sender;
- (IBAction)shareButton:(id)sender;
- (IBAction)commentButton:(id)sender;

@end

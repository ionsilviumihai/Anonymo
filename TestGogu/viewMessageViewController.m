//
//  viewMessageViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 4/14/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "viewMessageViewController.h"

@interface viewMessageViewController ()

@end

@implementation viewMessageViewController
@synthesize messageLabel, dateLabel, authorLabel, mesaj, details, idMesaj;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [messageLabel setText:mesaj];
    NSLog(@"S-a accesat mesajul cu id: %@", idMesaj);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)likeButton:(id)sender {
}

- (IBAction)dislikeButton:(id)sender {
}
- (IBAction)shareButton:(id)sender {
}

- (IBAction)commentButton:(id)sender {
}
@end

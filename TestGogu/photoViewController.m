//
//  photoViewController.m
//  TestGogu
//
//  Created by Meeshoo on 3/17/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "photoViewController.h"

@interface photoViewController ()

@end

@implementation photoViewController

- (IBAction)closeView:(id)sender {
    [self.delegate closePhotoWithTimeInterval:[[NSDate date] timeIntervalSinceDate:self.upTime]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

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
    
    [self.pozaImage setImage:self.poza];
    
    self.upTime = [NSDate date];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

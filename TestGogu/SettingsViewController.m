//
//  SettingsViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 4/17/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    
    UIBarButtonItem* newMessage = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStyleBordered target:self action:@selector(logOut:)];
                                   

    self.navigationItem.rightBarButtonItem = newMessage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)logOut:(id) sender
{
    AppDelegate* appdegate = (AppDelegate*)[[UIApplication sharedApplication]delegate]; //pentru a apela o functie din app delegate
    [appdegate logOutSession];
}

@end

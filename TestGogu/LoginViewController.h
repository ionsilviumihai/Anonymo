//
//  LoginViewController.h
//  TestGogu
//
//  Created by Ion Silviu on 4/7/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController <FBLoginDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)LogInButton:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)SignUpButton:(id)sender;



@end

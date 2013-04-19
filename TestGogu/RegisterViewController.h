//
//  RegisterViewController.h
//  TestGogu
//
//  Created by Ion Silviu on 4/8/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "httpRequests.h"
#import "RegisterViewController.h"

@interface RegisterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

- (IBAction)SignUpButton:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;

@end

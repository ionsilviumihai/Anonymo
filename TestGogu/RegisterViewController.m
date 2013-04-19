//
//  RegisterViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 4/8/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

@synthesize userTextField, passwordTextField, emailTextField;



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
    
    self.title = @"Register";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SignUpButton:(id)sender {
    if([userTextField.text isEqualToString:@""] || [passwordTextField.text isEqualToString:@""] || [emailTextField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration error" message:@"Please complete all fields." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
    [userTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    [emailTextField resignFirstResponder];
    
    NSString* username = userTextField.text;
    NSString* password = passwordTextField.text;
    NSString* email = emailTextField.text;
    [httpRequests createUserWithUsername:username
                                    password:password
                                       email:email
                                     success:^(id data) {
                                         NSLog(@"S-a creat un user nou");
                                         [self dismissViewControllerAnimated:YES completion:nil];
                                     }
                                       error:^(AFHTTPRequestOperation *operation, NSError *error) {
            
                                       }];
    }
}

- (IBAction)dismissKeyboard:(id)sender {
    [userTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    [emailTextField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField*)textField {
    if([textField.text isEqualToString:@""]) {
        return YES;
    }
    
    if (textField == passwordTextField) {
        NSString *regEx = @"^[A-Z0-9a-z._%+-]";
        NSRange r = [textField.text rangeOfString:regEx options:NSRegularExpressionSearch];
        if (r.location == NSNotFound) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Entry Error" message:@"Invalid password!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            passwordTextField.text = @"";
            return NO;
        }
        
    }

    if(textField == emailTextField) {
        NSString *regEx = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSRange r = [textField.text rangeOfString:regEx options:NSRegularExpressionSearch];
        if(r.location == NSNotFound) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Entry Error" message:@"Invalid email adddres!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
            emailTextField.text = @"";
            return NO;
        }
    }
    return YES;
}

@end

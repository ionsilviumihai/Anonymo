//
//  LoginViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 4/7/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "httpRequests.h"
#import "RegisterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize userTextField , passwordTextField;

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
    self.title = @"Anonymo";
    

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)authButtonAction:(id)sender {
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    // The user has initiated a login, so call the openSession method
    // and show the login UX if necessary.
    [appDelegate setDelegate:self];
    [appDelegate openSessionWithAllowLoginUI:YES];
}

-(void)LoginWasSuccesfull:(BOOL)success
{
    if(success)
    {
        NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
        NSString* email = [user objectForKey:@"Email"];
        NSString* idUser = [user objectForKey:@"FacebookID"];
        NSString* username = [user objectForKey:@"Username"];
        [httpRequests createUserWithUsername:username
                                    password:idUser
                                       email:email
                                     success:^(id data) {
                                         [self dismissViewControllerAnimated:YES completion:nil];
        }
                                       error:^(AFHTTPRequestOperation *operation, NSError *error) {

            
        }];
        
        
        
    }
}

- (IBAction)LogInButton:(id)sender {
    [userTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    if([userTextField.text isEqualToString:@""] && [passwordTextField.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Entry error" message:@"You did not provide any details for authentication." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        if([userTextField.text isEqualToString:@""] || [passwordTextField.text isEqualToString:@""])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Entry error" message:@"Please complete all fields." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            //luam toti userii din baza de date
            __block BOOL ok = NO;
            [httpRequests getAllUserssuccess:^(id data) {
                
                for (NSDictionary* userInfo in data)
                {
                    //            NSDate* date1=[NSDate dateWithTimeIntervalSince1970:1234567890];
                    if([userTextField.text isEqualToString:[userInfo objectForKey:@"name"]])
                    {
                        if([passwordTextField.text isEqualToString:[userInfo objectForKey:@"password"]])
                        {
                            ok = YES;
                            AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                            appDelegate.idUser = [userInfo objectForKey:@"id"];
                            NSLog(@"Userul cu id:%@ s-a logat!", appDelegate.idUser);
                            [self dismissViewControllerAnimated:YES completion:nil];
                            break;
                        }
                    }
                }
                if(!ok)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authentication error" message:@"Email/Password combination is not valid." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alert show];
                }
                
            } error:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
    }
}

- (IBAction)dismissKeyboard:(id)sender {
    [userTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)SignUpButton:(id)sender{
    RegisterViewController* registerVC = [[RegisterViewController alloc]initWithNibName:@"RegisterViewController" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
    //[self.navigationController pushViewController:cvc animated:YES];
}
@end

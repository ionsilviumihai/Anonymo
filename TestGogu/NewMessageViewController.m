//
//  NewMessageViewController.m
//  TestGogu
//
//  Created by Ion Silviu on 4/14/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "NewMessageViewController.h"
#import "httpRequests.h"
#import "AppDelegate.h"

@interface NewMessageViewController ()

@end

@implementation NewMessageViewController
@synthesize messageUITextView, charsLeftButton, coordonataMesaj;

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
    
    [messageUITextView becomeFirstResponder];
    
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    UIBarButtonItem* sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(send:)];
    self.navigationItem.rightBarButtonItem = sendButton;
    [charsLeftButton setEnabled:NO];
    NSLog(@"%f", coordonataMesaj.longitude);
}

-(void)textViewDidChange:(UITextView *)textView {
    int maxChars = 150;
    int charsLeft = maxChars - [textView.text length];
    [charsLeftButton setTitle:[NSString stringWithFormat:@"%d", charsLeft] forState:UIControlStateNormal];
    if(charsLeft == 0)
    {
        charsLeftButton.titleLabel.backgroundColor = [UIColor redColor];
    }
    else
        charsLeftButton.titleLabel.backgroundColor = [UIColor whiteColor];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSUInteger oldLength = [textView.text length];
    NSUInteger replacementLength = [text length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [text rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= 150 || returnKey;
    
    /*
    if ([textField.text length] > MAXLENGTH) {
        textField.text = [textField.text substringToIndex:MAXLENGTH-1];
        return NO;
    }
    return YES;
    */
}


-(void)send:(id) sender{
    NSString* mesaj = messageUITextView.text;
    NSLog(@"%@",mesaj);

    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSString *UserID = appDelegate.idUser;
    //NSNumber *UserID = [NSNumber ]
    //NSLog(@"Id-ul cautat este %@", appDelegate.idUser);
    //NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    //[f setNumberStyle:NSNumberFormatterCurrencyStyle];
    //NSNumber *UserID =[f numberFromString:appDelegate.idUser];
    //NSLog(@"Initial este %@", appDelegate.idUser);
    //long user_id = appDelegate.idUser;
    //NSNumber *UserID = [NSNumber numberWithLong: user_id];
    //NSLog(@"Iar apoi se schimba in %ld", user_id);
    NSString *messageText = mesaj;
    NSString *latitude = [[NSString alloc] initWithFormat:@"%f",coordonataMesaj.latitude ];
    NSString *longitiude = [[NSString alloc] initWithFormat:@"%f", coordonataMesaj.longitude];
    double interval = [[NSDate date] timeIntervalSince1970];
    long interv = (long)interval;
    NSNumber *date = [NSNumber numberWithLong:interv];
    NSLog(@"User:%@ messageText:%@ latitude:%@ longitude:%@ interval:%ld",UserID,messageText,latitude,longitiude,interv);
    [httpRequests createMessageWithUserID:UserID
                              messageText:messageText
                                 latitude:latitude  
                                longitude:longitiude
                                     date:date
                                  success:^(id data){
                                      NSLog(@"S-a creat un mesaj nou");
                                      [self dismissViewControllerAnimated:YES completion:nil];
                                      
                                  }
                                    error:^(AFHTTPRequestOperation *operation, NSError *error){
                                        NSLog(@"A avut loc o eroare!");
                                        
                                    }];
}

-(void) cancel:(id) sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)saveCoordinates: (CLLocationCoordinate2D) coordonata {
    NSLog(@"A intrat");
}

@end

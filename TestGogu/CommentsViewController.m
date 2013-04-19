//
//  CommentsViewController.m
//  TestGogu
//
//  Created by Meeshoo on 3/2/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "CommentsViewController.h"
#import "photoViewController.h"

@interface CommentsViewController ()

@end

@implementation CommentsViewController


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
    
    [self.imagePoza setUserInteractionEnabled:YES];
    
    UITapGestureRecognizer *tapPhoto = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)];
    [self.imagePoza addGestureRecognizer:tapPhoto];
    
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];//
    if([userDefault objectForKey:@"Comentariu"])
    {
        [self.myComment setText:[userDefault objectForKey:@"Comentariu"]];
    }
    if(self.navigationController)
    {
        [self.closeButton setHidden:YES];
    }
    
    [self.myComment setDelegate:self];
    
    [self.titleLabel setText:self.titlu];
    [self.subtitleLabel setText:self.subtitlu];
    
    
    UIGestureRecognizer* tappedScreen=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedScreen:)];
    [self.view addGestureRecognizer:tappedScreen];
    
// cum iei inaltimea la text    
//    [@"textCommetatiu" sizeWithFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]
//                  constrainedToSize:CGSizeMake(100,20 )
//                      lineBreakMode:NSLineBreakByWordWrapping].height;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeVC:(id)sender
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)postCommnet:(id)sender
{
    NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];//
    [userDefault setValue:self.myComment.text forKey:@"Comentariu"];
    [userDefault synchronize];
    //send comment to server
    [self.myComment setText:@""];
    [self.myComment resignFirstResponder];

}

-(void)tappedScreen:(id)sender
{
    
    UIView* selectedView = [(UIGestureRecognizer*)sender view];
    
    if(selectedView != self.myComment)
    {
        [self.myComment resignFirstResponder];
    }
        
}

- (IBAction)buttonTakeAPhoto:(id)sender {
    UIAlertView *alerta = [[UIAlertView alloc] initWithTitle:@"Select source:" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Camera", @"Photo Library", nil];
    [alerta show];
    
}

#pragma mark textField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



#pragma mark alert Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [alertView dismissWithClickedButtonIndex:0 animated:YES];
        return;
    }
    UIImagePickerController* camera =[[UIImagePickerController alloc]init];
    if(buttonIndex == 1)
    {
    [camera setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    else{
        [camera setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    [camera setDelegate:self];
    
    [self presentViewController:camera animated:NO completion:^{}];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
        
    [self.imagePoza setImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];

}

-(void)showPicture{
    photoViewController *pVC = [[photoViewController alloc] initWithNibName:@"photoViewController" bundle:nil];
    [pVC setDelegate:self]; 
    pVC.poza = [self.imagePoza image];
    //[self.navigationController pushViewController:pVC animated:YES];
    
    [self presentViewController:pVC animated:YES completion:nil];
}

-(void)closePhotoWithTimeInterval:(NSTimeInterval)seconds{
    NSLog(@"%f seconds", seconds);
}

@end

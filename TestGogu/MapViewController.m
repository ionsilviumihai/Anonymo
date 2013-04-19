//
//  MapViewController.m
//  TestGogu
//
//  Created by Meeshoo on 3/2/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "MapViewController.h"
#import "Annotation.h"
#import "MBProgressHUD.h"
#import "CommentsViewController.h"
#import "AppDelegate.h"
#import "httpRequests.h"
#import "NewMessageViewController.h"
#import "MessagesFromCalloutViewController.h"


@interface MapViewController ()

@end

@implementation MapViewController

@synthesize vectorCoordonate;
#pragma mark - UIViewControllerMethods


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
    
    [self.mapView setDelegate:self];
    
    [self.mapView setShowsUserLocation:YES];
    
    //adaugare buton sign out
    //UIBarButtonItem* logOutButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStyleBordered target:self action:@selector(logOut:)];
   // self.navigationItem.rightBarButtonItem = logOutButton;
    
   // UIBarButtonItem* newMessage = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"email_send"] style:UIBarButtonItemStylePlain target:self action:@selector(logOut:)];
     
   // self.navigationItem.rightBarButtonItem = newMessage;
    
    //incercare buton navbar
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    /*
     * Insert button styling
     */
    CGRect frameBtn = CGRectMake(0, 0, 30 , 30);
    [button setImage:[UIImage imageNamed:@"email_send"] forState:UIControlStateNormal];
    [button setFrame:frameBtn];
  
    [button addTarget:self
               action:@selector(broadcastNewMessage:)
     forControlEvents:UIControlEventTouchUpInside];
    
    button.frame = CGRectMake(0, 0, 35, 35);
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    //incercare
    
    
    
    //modificare
    //UIImage *barButtonImage = [[UIImage imageNamed:@"18-envelope"]
                              // resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 6)];
   //[logOutButton setBackgroundImage:barButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //modificare
    
    /*
    UIBarButtonItem* refreshButton = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStylePlain target:self action:@selector(buttonPressed:)];
    //initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(buttonPressed:)];
    self.navigationItem.leftBarButtonItem = refreshButton;
    */
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                                          target:self
                                                                                          action:@selector(buttonPressed:)];
    
    // Do any additional setup after loading the view from its nib.
    
    vectorCoordonate = [[NSMutableArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated
{
    CLLocationCoordinate2D coordonate = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude);
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.01, 0.01);
    MKCoordinateRegion regiune =  MKCoordinateRegionMake(coordonate, zoom);
    [self.mapView setRegion:regiune animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MapViewDelegateMethods


-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    CLLocationCoordinate2D coordonate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.01, 0.01);	
    MKCoordinateRegion regiune =  MKCoordinateRegionMake(coordonate, zoom);
    [self.mapView setRegion:regiune animated:YES];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if(![annotation isMemberOfClass:[MKUserLocation class]])
    {
        MKPinAnnotationView *returnedAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"anotatie"];
        [returnedAnnotation setPinColor:MKPinAnnotationColorGreen];
        //[returnedAnnotation setImage:[UIImage imageNamed:@"pin_black"]];
        [returnedAnnotation setCanShowCallout:YES];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
        [imageView setImage: [UIImage imageNamed: @"Romania-icon"]];
        [returnedAnnotation setLeftCalloutAccessoryView:imageView];
        UIButton *butonMesaj = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [returnedAnnotation setRightCalloutAccessoryView: butonMesaj];
        return returnedAnnotation;
    }
    else return nil;
}



-(void)                 mapView:(MKMapView *)mapView
                 annotationView:(MKAnnotationView *)view
  calloutAccessoryControlTapped:(UIControl *)control
{
    /* parte gogu comentata
    
//alert example
//    [[[UIAlertView alloc]initWithTitle:@"Alerta"
//                               message:@"Ati apasat pe buton"
//                              delegate:nil
//                     cancelButtonTitle:@"Cancel"
//                     otherButtonTitles:nil] show];
    
    CommentsViewController* cVC=[[CommentsViewController alloc] initWithNibName:@"CommentsViewController" bundle:nil];
    Annotation* selectedAnnotation = (Annotation*)view.annotation;
    
    if(cVC.ti)
    cVC.titlu = selectedAnnotation.title;
    cVC.subtitlu = selectedAnnotation.subtitle;
      //modal
    [self presentViewController:cVC
                       animated:YES
                     completion:^{}];
     
    //cu nav controller
    [cVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:cVC animated:YES];
     
*/
    
    MessagesFromCalloutViewController *messagesFromCalloutVC = [[MessagesFromCalloutViewController alloc] initWithNibName:@"MessagesFromCalloutViewController" bundle:nil];
    Annotation* selectedAnnotation = (Annotation*)view.annotation;
    CLLocationCoordinate2D locatie = CLLocationCoordinate2DMake(selectedAnnotation.coordonata.latitude, selectedAnnotation.coordonata.longitude);
    NSString *latitude = [[NSString alloc] initWithFormat:@"%f",locatie.latitude ];
    NSString *longitiude = [[NSString alloc] initWithFormat:@"%f", locatie.longitude];
    messagesFromCalloutVC.latitudine = latitude;
    messagesFromCalloutVC.longitudine = longitiude;
    [messagesFromCalloutVC setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:messagesFromCalloutVC animated:YES];

    
}

#pragma mark - Actions

-(IBAction)buttonPressed:(UIButton *)sender
{
    //------------------------------------------------------------------------------------------------------------
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //CLLocation *userLocation = [[CLLocation alloc] initWithLatitude:self.mapView.userLocation.coordinate.latitude longitude:self.mapView.userLocation.coordinate.longitude];
    /*
    for(int i = 0;i<10;i++)
    {

        Annotation *anotatie = [[Annotation alloc] init];
        anotatie.subiect = @"Aici sunt eu!";
        anotatie.coment = @"Da, da, aici sunt eu!";
        anotatie.coordonata = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude + i/10.0, self.mapView.userLocation.coordinate.longitude - i/10.0);
        CLLocation *secondUserLocation = [[CLLocation alloc] initWithLatitude:anotatie.coordonata.latitude longitude:anotatie.coordonata.longitude];
        float distance = [userLocation distanceFromLocation:secondUserLocation];
        NSLog(@"Distanta dintre punctul pus si user este %f km",distance/1000);
        [vectorCoordonate addObject:anotatie];
    }

    [self.mapView performSelectorInBackground:@selector(addAnnotations:) withObject:vectorCoordonate]; //implementare thread
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    */
    //------------------------------------------------------------------------------------------------------------
    
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [httpRequests getAllMessagessuccess:^(id data) {
        for (NSDictionary* messagesDict in data)
        {
            NSLog(@"%@ , %@, %@",[messagesDict objectForKey:@"text"], [messagesDict objectForKey:@"latitude"], [messagesDict objectForKey:@"longitude"]);
            CLLocationCoordinate2D locatie = CLLocationCoordinate2DMake([[messagesDict objectForKey:@"latitude"] doubleValue], [[messagesDict objectForKey:@"longitude"] doubleValue]);
            BOOL ok = true;
            for (Annotation *anotatie1 in vectorCoordonate)
            {
                if (anotatie1.coordonata.latitude == locatie.latitude && anotatie1.coordonata.longitude == locatie.longitude) {
                    anotatie1.counter++;
                    anotatie1.coment = [NSString stringWithFormat:@"%d messages", anotatie1.counter];
                    ok = false;
                }
            }
            if (ok == true) {
                Annotation *anotatie = [[Annotation alloc] init];
                anotatie.subiect = @"Mesaj!";
                anotatie.coment = [NSString stringWithFormat:@"%@", [messagesDict objectForKey:@"text"]];
                anotatie.coordonata = CLLocationCoordinate2DMake([[messagesDict objectForKey:@"latitude"] doubleValue], [[messagesDict objectForKey:@"longitude"] doubleValue]);
                anotatie.counter = 1;
                [vectorCoordonate addObject:anotatie];
                [self.mapView addAnnotation:anotatie];
            }
        }
    } error:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Mare Eroare!");
    }];
    [self.mapView performSelectorInBackground:@selector(addAnnotations:) withObject:vectorCoordonate];
    //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)broadcastNewMessage:(id) sender {
    
    NewMessageViewController *newMessVC = [[NewMessageViewController alloc] initWithNibName:@"NewMessageViewController" bundle:nil];
    newMessVC.coordonataMesaj =  CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude);
    [self.delegate saveCoordinates: CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude, self.mapView.userLocation.coordinate.longitude)];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:newMessVC];
    [self presentViewController:navC animated:YES completion:nil];
}

-(void)cancel:(id) sender {
    
}



@end

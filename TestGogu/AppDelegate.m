//
//  AppDelegate.m
//  TestGogu
//
//  Created by Meeshoo on 3/2/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import "AppDelegate.h"
#import "MapViewController.h"
#import "MessageViewController.h"
#import "LoginViewController.h"

#import "SettingsViewController.h"
#import "EventsViewController.h"
#import "MissingViewController.h"

@implementation AppDelegate

@synthesize idUser;

NSString *const FBSessionStateChangedNotification =
@"com.Anonymous.Login:FBSessionStateChangedNotification";



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //MapView---------------------------
    MapViewController *mapVC = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    [mapVC setTitle:@"Map"];
   // [mapVC setTabBarItem:[[UITabBarItem alloc] initWithTabBarSystemItem:
                        //  UITabBarSystemItemSearch tag:0]];
    [mapVC setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Map"
                                                       image:[UIImage imageNamed:@"maps.png"]
                                                         tag:0]];
                          
    //[[[[[mapVC tabBarController] tabBar] items] objectAtIndex:1] setFinishedSelectedImage:[UIImage imageNamed:@"maps_selected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"maps.png"]];
                          
    //MessageView----------------------
    MessageViewController *messageVC = [[MessageViewController alloc] initWithNibName:@"MessageViewController" bundle:nil];
    [messageVC setTitle:@"Messages"];
   // [messageVC setTabBarItem:[[UITabBarItem alloc] initWithTabBarSystemItem:
                         // UITabBarSystemItemDownloads tag:0]];
    [messageVC setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Messages" image:[UIImage imageNamed:@"18-envelope.png"] tag:0]];
    //SettingsView
    SettingsViewController *settingsVC = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    [settingsVC setTitle:@"Settings"];
    [settingsVC setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Settings"
                                                           image:[UIImage imageNamed:@"settings.png"]
                                                             tag:0]];
    UINavigationController *settingsVCNav = [[UINavigationController alloc] initWithRootViewController:settingsVC];
    
    //EventsView
    EventsViewController *eventsVC = [[EventsViewController alloc] initWithNibName:@"EventsViewController" bundle:nil];
    [eventsVC setTitle:@"Events"];
    [eventsVC setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Events" image:[UIImage imageNamed:@"events.png"]tag:0]];
    
    //MissingView
    MissingViewController *missingVC = [[MissingViewController alloc] initWithNibName:@"MissingViewController" bundle:nil];
    [missingVC setTitle:@"Missing"];
    [missingVC setTabBarItem:[[UITabBarItem alloc] initWithTitle:@"Missing" image:[UIImage imageNamed:@"missing.png"] tag:0]];
    
    
    self.tabController = [[UITabBarController alloc] init];
    
    //adaugat
    UITabBar *tabBar = self.tabController.tabBar;
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:3];
    
    tabBarItem3.title = @"Home";
    //adaugat
    
    UINavigationController *mapVCNav = [[UINavigationController alloc] initWithRootViewController:mapVC];
    

    [self.tabController setViewControllers:[NSArray arrayWithObjects:missingVC, eventsVC, mapVCNav, messageVC, settingsVCNav, nil]];
    [self.tabController setSelectedIndex:2];
    

    
    self.window.rootViewController = self.tabController;
    [self.window makeKeyAndVisible];
    
    LoginViewController* loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    UINavigationController* loginVCNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [self.tabController presentViewController:loginVCNav animated:NO completion:nil];
    
    
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
    [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], UITextAttributeTextColor,
    [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],UITextAttributeTextShadowColor,
    [NSValue valueWithUIOffset:UIOffsetMake(0, 1)],
    UITextAttributeTextShadowOffset,
    [UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], UITextAttributeFont, nil]];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    // We need to properly handle activation of the application with regards to Facebook Login
    // (e.g., returning from iOS 6.0 Login Dialog or from fast app switching).
    [FBSession.activeSession handleDidBecomeActive];
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [FBSession.activeSession close];
}

#pragma mark Facebook Methods

/*
 * Callback for session changes.
 */
- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            if (!error) {
                // We have a valid session
                NSLog(@"User session found");
                [[FBRequest requestForGraphPath:@"me"] startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                    if(!error)
                    {
                        [FBSession activeSession].accessTokenData.accessToken;
                        NSString* firstName = [result objectForKey:@"first_name"];
                        NSString* lastName = [result objectForKey:@"last_name"];
                        
                        NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
                        NSString* username = [NSString stringWithFormat:@"%@_%@",firstName,lastName];
                        [user setValue:username forKey:@"Username"];
                        
                        NSString* facebookID = [result objectForKey:@"id"];
                        [user setValue:facebookID forKey:@"FacebookID"];
                        
                        NSString* email = [result objectForKey:@"email"];
                        [user setValue:email forKey:@"Email"];
                        [user synchronize]; //pentru a face modificarile
                        NSLog(@"%@ %@", firstName, lastName);
                        [self.delegate LoginWasSuccesfull:YES];
                    }
                }];
            }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:FBSessionStateChangedNotification
     object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

/*
 * Opens a Facebook session and optionally shows the login UX.
 */
- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    return [FBSession openActiveSessionWithReadPermissions:[NSArray arrayWithObject:@"email"]
                                              allowLoginUI:allowLoginUI
                                         completionHandler:^(FBSession *session,
                                                             FBSessionState state,
                                                             NSError *error) {
                                             [self sessionStateChanged:session
                                                                 state:state
                                                                 error:error];
                                         }];
}

/*
 * If we have a valid session at the time of openURL call, we handle
 * Facebook transitions by passing the url argument to handleOpenURL
 */
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    // attempt to extract a token from the url
    return [FBSession.activeSession handleOpenURL:url];
}

//metoda logout

-(void)logOutSession
{
    [[FBSession activeSession]closeAndClearTokenInformation];
    LoginViewController* loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    UINavigationController* loginVCNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.tabController presentViewController:loginVCNav animated:NO completion:nil];
    
}

@end

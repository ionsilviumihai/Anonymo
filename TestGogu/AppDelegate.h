//
//  AppDelegate.h
//  TestGogu
//
//  Created by Meeshoo on 3/2/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

extern NSString *const FBSessionStateChangedNotification;

@class ViewController;

@protocol FBLoginDelegate <NSObject>

-(void)LoginWasSuccesfull:(BOOL) success;

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) NSString *idUser;

@property (strong, nonatomic) id<FBLoginDelegate> delegate;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabController;

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

- (void)logOutSession;

@end

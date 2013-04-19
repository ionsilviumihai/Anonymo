//
//  photoViewController.h
//  TestGogu
//
//  Created by Meeshoo on 3/17/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol photoDelegate <NSObject>

-(void)closePhotoWithTimeInterval: (NSTimeInterval) seconds;

@end

@interface photoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *pozaImage;
@property (strong, nonatomic) UIImage *poza;
@property (strong, nonatomic) NSDate *upTime;
@property (strong, nonatomic) id<photoDelegate> delegate;
@end

//
//  NewMessageViewController.h
//  TestGogu
//
//  Created by Ion Silviu on 4/14/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"


@interface NewMessageViewController : UIViewController <getCoordinates>
@property (weak, nonatomic) IBOutlet UITextView *messageUITextView;
@property (weak, nonatomic) IBOutlet UIButton *charsLeftButton;
@property (nonatomic) CLLocationCoordinate2D coordonataMesaj;

@end

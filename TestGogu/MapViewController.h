//
//  MapViewController.h
//  TestGogu
//
//  Created by Meeshoo on 3/2/13.
//  Copyright (c) 2013 Meeshoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>


@protocol getCoordinates <NSObject>
-(void)saveCoordinates: (CLLocationCoordinate2D) coordonata;
@end

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) id<getCoordinates> delegate;
@property (strong, nonatomic) NSMutableArray *vectorCoordonate;
@end

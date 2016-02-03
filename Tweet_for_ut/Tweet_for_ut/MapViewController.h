//
//  MapViewController.h
//  Tweet_for_ut
//
//  Created by YAMAMOTO Yuta on 2013/09/18.
//  Copyright (c) 2013年 yuta. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController
<MKMapViewDelegate> {
    
    IBOutlet MKMapView *myMapView;
}
- (IBAction)changeMapType:(id)sender;

- (IBAction)showHere:(id)sender;

@end

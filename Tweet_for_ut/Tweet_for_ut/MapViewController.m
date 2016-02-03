//
//  MapViewController.m
//  Tweet_for_ut
//
//  Created by YAMAMOTO Yuta on 2013/09/18.
//  Copyright (c) 2013年 yuta. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)changeMapType:(id)sender {
    static int mapTypeCount = 0;
    switch (mapTypeCount % 3) {
        case0:
            myMapView.mapType = MKMapTypeSatellite;
            break;
        case1:
            myMapView.mapType = MKMapTypeHybrid;
            break;
        case2:
            myMapView.mapType = MKMapTypeStandard;
            break;
    }
    mapTypeCount++;
}

- (IBAction)showHere:(id)sender {
    myMapView.showsUserLocation = YES;
}
@end

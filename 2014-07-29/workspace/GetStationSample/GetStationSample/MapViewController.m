//
//  MapViewController.m
//  GetStationSample
//
//  Created by student on 2014/07/30.
//  Copyright (c) 2014年 student. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController () {
    UIColor *defaultColor;
    MKMapCamera *defaultCamera;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIToolbar *mapToolBar;
@property (weak, nonatomic) IBOutlet UISearchBar *searchInput;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trackingButton;
- (IBAction)mapTypeChanged:(UISegmentedControl *)sender;
- (IBAction)trackingModeChanged:(UIBarButtonItem *)sender;
- (IBAction)spotButtonTapped:(UIBarButtonItem *)sender;
- (IBAction)threeDButtonTapped:(UIBarButtonItem *)sender;
@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _mapView.delegate = self;
    _mapView.showsBuildings = NO;
    _searchInput.delegate = self;

    defaultColor = self.view.window.tintColor;
   
    if ([CLLocationManager locationServicesEnabled]) {
        [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        _trackingButton.image = [UIImage imageNamed:@"trackingFollow.png"];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:NSLocalizedString(@"confirm", nil)
                              message:NSLocalizedString(@"gps-invalid-message", nil)
                              delegate:nil
                              cancelButtonTitle:NSLocalizedString(@"ok", nil)
                              otherButtonTitles:nil];
        [alert show];
        return;
    }
}

- (void) viewDidAppear:(BOOL)animated {
    defaultCamera = _mapView.camera;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// -------------------------
// UI EventHander Method
// -------------------------
- (IBAction)mapTypeChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            _mapView.mapType = MKMapTypeStandard;
            _mapToolBar.alpha = 1.0;
            self.view.window.tintColor = defaultColor;
            break;
        case 1:
            _mapView.mapType = MKMapTypeSatellite;
            _mapToolBar.alpha = 0.5;
            self.view.window.tintColor = [UIColor whiteColor];
            break;
        case 2:
            _mapView.mapType = MKMapTypeHybrid;
            _mapToolBar.alpha = 0.5;
            self.view.window.tintColor = [UIColor whiteColor];
            break;
        default:
            break;
    }
}

- (IBAction)trackingModeChanged:(UIBarButtonItem *)sender {
    switch (_mapView.userTrackingMode) {
        case MKUserTrackingModeNone:
            [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
            _trackingButton.image = [UIImage imageNamed:@"trackingFollow.png"];
            break;
        case MKUserTrackingModeFollow:
            [_mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
            _trackingButton.image = [UIImage imageNamed:@"trackingHeading.png"];
            break;
        case MKUserTrackingModeFollowWithHeading:
            [_mapView setUserTrackingMode:MKUserTrackingModeNone animated:YES];
            _trackingButton.image = [UIImage imageNamed:@"trackingNone.png"];
            break;
        default:
            break;
    }
}

- (IBAction)spotButtonTapped:(UIBarButtonItem *)sender {
    CLLocationCoordinate2D current = _mapView.userLocation.location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(current, 1000, 1000);
    [_mapView setRegion:region animated:YES];
    
    [self removeAnnotations];
    [_mapView removeOverlays:_mapView.overlays];
   
    [self pinNearByStationsByX:current.longitude andY:current.latitude];
}

- (IBAction)threeDButtonTapped:(UIBarButtonItem *)sender {
    if (_mapView.showsBuildings) {
        _mapView.showsBuildings = NO;
        _mapView.camera.altitude = defaultCamera.altitude;
        _mapView.camera.pitch = defaultCamera.pitch;
        _mapView.camera.centerCoordinate = defaultCamera.centerCoordinate;
        
    } else {
        _mapView.showsBuildings = YES;
        _mapView.camera.altitude = 200;
        _mapView.camera.pitch = 70;
    }
}


// -------------------------
// UISearchBarDelegate Method
// -------------------------
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:searchBar.text completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error != nil) {
            NSLog(@"ERROR -> %@", error);
            return;
        }
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks[0];
            [self removeAnnotations];
            [self addPinAt:placemark.location.coordinate withTitle:NSLocalizedString(@"destination", nill) AndSubTitle:@""];
            
            CLLocationCoordinate2D start = _mapView.userLocation.coordinate;
            CLLocationCoordinate2D goal = placemark.location.coordinate;
            
            [self displayDirectionsFrom:start to:goal];
            
            [self movePoint:start goal:goal];
            
        } else {
            NSLog(@"%@", @"NotFound.");
        }
    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    [self.view endEditing:YES];
}

// -------------------------
// MKMapViewDelegate Method
// -------------------------
- (void) mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated {
    _trackingButton.image = [UIImage imageNamed:@"trackingNone.png"];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    // アノテーション表示に実行される
    if (annotation == _mapView.userLocation) {
        return nil;
    }
    NSString *identifier = @"Station";
    MKPinAnnotationView *cachedPin = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (cachedPin != nil) {
        return cachedPin;

    } else {
        MKPinAnnotationView *newPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        newPin.animatesDrop = YES;
        newPin.pinColor = MKPinAnnotationColorPurple;
        newPin.canShowCallout = YES;
        newPin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return newPin;
    }
}

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    if ([view.annotation isKindOfClass: [MKPointAnnotation class]]) {
        MKPointAnnotation *stationPoint = (MKPointAnnotation *)view.annotation;

        [self displayDirectionsFrom:_mapView.userLocation.location.coordinate to:stationPoint.coordinate];
    }
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
        routeRenderer.lineWidth = 3.0;
        routeRenderer.strokeColor = [UIColor blueColor];
        return routeRenderer;
    } else {
        return nil;
    }
}
// -------------------------
// Private Method
// -------------------------
- (void) displayDirectionsFrom:(CLLocationCoordinate2D) start to:(CLLocationCoordinate2D)goal {
    MKPlacemark *startMark = [[MKPlacemark alloc] initWithCoordinate:start addressDictionary:nil];
    MKMapItem *startMapItem = [[MKMapItem alloc] initWithPlacemark:startMark];
    
    MKPlacemark *goalMark = [[MKPlacemark alloc] initWithCoordinate:goal addressDictionary:nil];
    MKMapItem *goalMapItem = [[MKMapItem alloc] initWithPlacemark:goalMark];
    
    MKDirectionsRequest *directionRequest = [[MKDirectionsRequest alloc] init];
    directionRequest.source = startMapItem;
    directionRequest.destination = goalMapItem;
    directionRequest.transportType = MKDirectionsTransportTypeAny;
    directionRequest.requestsAlternateRoutes = NO;
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionRequest];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        [_mapView removeOverlays:_mapView.overlays];
        if (error != nil) {
            NSLog(@"Error -> %@", error);
            return;
        }
        if (response.routes.count > 0) {
            MKRoute *route = response.routes[0];
            [_mapView addOverlay:route.polyline];
        } else {
            NSLog(@"Not found.");
        }
    }];
}

- (void) pinNearByStationsByX:(double) xLocation andY:(double) yLocation {
    NSString *parameterizedUrlString = [NSString stringWithFormat:@"http://express.heartrails.com/api/json?method=getStations&x=%f&y=%f", xLocation, yLocation];
    NSURL *url = [NSURL URLWithString:parameterizedUrlString];
    
    NSLog(@"%@", parameterizedUrlString);
    
    [self getRequestWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"ERROR -> %@", error);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
        [self pinStations: jsonResult[@"response"][@"station"]];
    }];
}

- (void) pinStations:(NSArray *) stations {
    for (NSDictionary *station in stations) {
        CLLocationDegrees longitude = [station[@"x"] doubleValue];
        CLLocationDegrees latitude = [station[@"y"] doubleValue];
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(latitude, longitude);
        MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
        pin.coordinate = center;
        NSString *title = [NSString stringWithFormat:@"%@ : %@%@", station[@"line"], station[@"name"], NSLocalizedString(@"station-suffix", nil)];
        [self addPinAt:center withTitle:title AndSubTitle:station[@"distance"]];
    }
}

- (void) addPinAt:(CLLocationCoordinate2D) coordinate withTitle:(NSString *)title AndSubTitle:(NSString *)subtitle {
    MKPointAnnotation *pin = [[MKPointAnnotation alloc] init];
    pin.coordinate = coordinate;
    pin.title = title;
    pin.subtitle = subtitle;
    [_mapView addAnnotation:pin];
}


- (void)getRequestWithURL:(NSURL *)url completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionTask *task = [session dataTaskWithURL:url completionHandler:completionHandler];
    [task resume];
}

-(void) removeAnnotations {
    for (id<MKAnnotation> annotaion in _mapView.annotations) {
        if ( annotaion != _mapView.userLocation) {
            [_mapView removeAnnotation:annotaion];
        }
    }
}

- (void) movePoint:(CLLocationCoordinate2D)start goal:(CLLocationCoordinate2D)goal {
    float moveToLongitude = (start.longitude + goal.longitude) / 2;
    float moveToLaditude = (start.latitude + goal.latitude) / 2;
    CLLocationCoordinate2D moveToCoordinate = CLLocationCoordinate2DMake(moveToLaditude, moveToLongitude);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(fabs(start.latitude - goal.latitude) * 1.2, fabs(start.longitude - goal.longitude) * 1.2);
    MKCoordinateRegion moveTo = MKCoordinateRegionMake(moveToCoordinate, span);
    [_mapView setRegion:moveTo];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end

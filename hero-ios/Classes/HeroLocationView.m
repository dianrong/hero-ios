//
//  HeroLocationView
//  WYYScanBarCode
//
//  Created by GPLIU on 15/1/6.
//  Copyright (c) 2015年 GPLIU. All rights reserved.
//

#import "HeroLocationView.h"
#import <MapKit/MapKit.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface HeroLocationView()<CLLocationManagerDelegate>
@end

@implementation HeroLocationView
{
    CLLocationManager *lm;
    NSDictionary *_fetch_coordinate;
}
-(void)on:(NSDictionary *)json{
    [super on:json];
    if (json[@"coordinate"]) {
        if (!json[@"hidden"]) {
            self.hidden = false;
        }
        NSDictionary *cordinate = json[@"coordinate"];
        float lat = [cordinate[@"la"] floatValue];
        float lo = [cordinate[@"lo"] floatValue];
        MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.bounds];
        mapView.autoresizingMask = 0x111111;
        [self addSubview:mapView];
        mapView.centerCoordinate = CLLocationCoordinate2DMake(lat, lo);
    }
    if (json[@"fetch_coordinate"]) {
        _fetch_coordinate = json[@"fetch_coordinate"];
        if (!json[@"hidden"]) {
            self.hidden = true;
        }
        if (![CLLocationManager locationServicesEnabled])
        {
            if (_fetch_coordinate) {
                NSMutableDictionary *fetch_coordinate = [NSMutableDictionary dictionaryWithDictionary:_fetch_coordinate];
                [fetch_coordinate setValue:@"err" forKey:@"location"];
                [self.controller on:fetch_coordinate];
            }
        }else{
            CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
            if (authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted)
            {
                if (_fetch_coordinate) {
                    NSMutableDictionary *fetch_coordinate = [NSMutableDictionary dictionaryWithDictionary:self.json[@"fetch_coordinate"]];
                    [fetch_coordinate setValue:@"err" forKey:@"location"];
                    [self.controller on:fetch_coordinate];
                }
            }
            lm = [[CLLocationManager alloc]init];
            lm.desiredAccuracy = kCLLocationAccuracyHundredMeters;
            lm.distanceFilter = 100;      //100米的变化敏感度
            if (IOS8_OR_LATER)
            {
                [lm requestWhenInUseAuthorization];
            }
            lm.delegate = self;
            [lm startUpdatingLocation];
        }
    }

}

#pragma mark delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (_fetch_coordinate) {
        NSMutableDictionary *fetch_coordinate = [NSMutableDictionary dictionaryWithDictionary:_fetch_coordinate];
        CLLocation *location = locations.lastObject;
        [fetch_coordinate setValue:@(location.coordinate.latitude) forKey:@"la"];
        [fetch_coordinate setValue:@(location.coordinate.longitude) forKey:@"lo"];
        [self.controller on:fetch_coordinate];
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSMutableDictionary *fetch_coordinate = [NSMutableDictionary dictionaryWithDictionary:self.json[@"fetch_coordinate"]];
    [fetch_coordinate setValue:@"err" forKey:@"location"];
    [self.controller on:fetch_coordinate];
    switch ([error code])
    {
        case kCLErrorNetwork: // general, network-related error
        {

        }
        break;
        case kCLErrorDenied:
        {

        }
        break;
        default:
        {
            
        }
        break;
    }
}
-(void)dealloc{
    [lm stopUpdatingLocation];
}
@end

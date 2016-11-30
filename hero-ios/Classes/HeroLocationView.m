//
//  HeroLocationView
//  WYYScanBarCode
//
//  Created by GPLIU on 15/1/6.
//  Copyright (c) 2015年 GPLIU. All rights reserved.
//

#import "HeroLocationView.h"
#import <MapKit/MapKit.h>
#import "UIAlertView+blockDelegate.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface HeroLocationView()<CLLocationManagerDelegate>
@end

@implementation HeroLocationView
{
    CLLocationManager *lm;
    NSDictionary *_fetch_coordinate;
    BOOL _leadUsrToSetting;
}
-(void)on:(NSDictionary *)json{
    [super on:json];
    if (json[@"leadUsrToSetting"]) {
        if (IOS8_OR_LATER) {
            _leadUsrToSetting = [json[@"leadUsrToSetting"] boolValue];
        }
    }
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
                if (authorizationStatus == kCLAuthorizationStatusDenied && _leadUsrToSetting) {
                    NSMutableDictionary *fetch_coordinate = [NSMutableDictionary dictionaryWithDictionary:self.json[@"fetch_coordinate"]];
                    [fetch_coordinate setValue:@{@"status":@"STATUSDENIED",} forKey:@"location"];
                    [UIAlertView showAlertViewWithTitle:@"定位服务关闭" message:@"请在系统设置中开启定位服务。" cancelButtonTitle:@"取消" otherButtonTitles:@[@"去设置"] onDismiss:^(NSInteger buttonIndex) {
                        [self.controller on:fetch_coordinate];
                        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        [[UIApplication sharedApplication] openURL:url];
                    } onCancel:^{
                        [fetch_coordinate setValue:@"err" forKey:@"location"];
                        [self.controller on:fetch_coordinate];
                    }];
                } else {
                    NSMutableDictionary *fetch_coordinate = [NSMutableDictionary dictionaryWithDictionary:self.json[@"fetch_coordinate"]];
                    [fetch_coordinate setValue:@"err" forKey:@"location"];
                    [self.controller on:fetch_coordinate];
                }
            } else {
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
        [lm stopUpdatingLocation];
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSMutableDictionary *fetch_coordinate = [NSMutableDictionary dictionaryWithDictionary:_fetch_coordinate];
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

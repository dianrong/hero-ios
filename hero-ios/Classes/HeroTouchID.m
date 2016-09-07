//
//  SLTouchID.m
//  SLMobile
//
//  Created by 朱成尧 on 2/10/15.
//
//

#import "HeroTouchID.h"
#import <LocalAuthentication/LAContext.h>
@implementation HeroTouchID
{
    LAContext *_laContext;
    id _actionObject;
}
-(void)on:(NSDictionary *)json{
    [super on:json];
    if (json[@"action"]) {
        _actionObject = json[@"action"];
    }
    if (json[@"checkEnable"]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:json[@"checkEnable"]];
        [dict setObject:[NSNumber numberWithBool:[self supportTouchID]] forKey:@"value"];
        [self.controller on:dict];
    }
    if (json[@"max"]) {
        _laContext.maxBiometryFailures = json[@"max"];
    }
    if (json[@"check"]) {
        [_laContext setLocalizedFallbackTitle:@""];
        return [_laContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:json[@"check"][@"title"] reply:^(BOOL success, NSError * _Nullable error) {
            if (error || (!success)) {
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:json[@"check"][@"action"]];
                [dict setObject:@"fail" forKey:@"value"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.controller on:dict];
                });
            }else{
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:json[@"check"][@"action"]];
                [dict setObject:@"success" forKey:@"value"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.controller on:dict];
                });
            }
        }];

    }
}
- (BOOL)supportTouchID {
#ifdef __IPHONE_8_0
    _laContext = [[LAContext alloc] init];
    return [_laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:NULL];
#else
    return NO;
#endif
}

@end

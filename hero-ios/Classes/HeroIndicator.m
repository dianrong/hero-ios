//
//  HeroToastView.m
//  hero
//
//  Created by Liu Guoping on 3/25/16.
//  Copyright © 2015 Liu Guoping. All rights reserved.
//

#import "HeroIndicator.h"

@implementation HeroIndicator {

}

-(void)on:(NSDictionary *)json {
    [super on:json];
    self.hidesWhenStopped = YES;
    [self startAnimating];
    if (json[@"style"]) {
        NSString *style = json[@"style"];
        if ([@"largeWhite" isEqualToString:style]) {
            self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        }else if([@"white" isEqualToString:style]){
            self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        }else{
            self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        }
    }
}

@end

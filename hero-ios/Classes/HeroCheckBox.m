//
//  HeroCheckBox.m
//  hero
//
//  Created by zhuyechao on 11/25/15.
//  Copyright © 2015 Liu Guoping. All rights reserved.
//

#import "HeroCheckBox.h"
#import "UILazyImageView.h"
#import "UIImage+alpha.h"

@implementation HeroCheckBox {
    id actionObject;
    UIImage *image_on;
    UIImage *image_off;
    BOOL checked;
}

-(void)on:(NSDictionary *)json{
    [super on:json];
    self.reversesTitleShadowWhenHighlighted = YES;
    self.clipsToBounds = YES;
    [self addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (json[@"enable"]) {
        BOOL enable = ((NSNumber*)(json[@"enable"])).boolValue;
        if (!enable) {
            [self setBackgroundColor:[UIColor grayColor]];
            [self setTintColor:[UIColor lightGrayColor]];
        }
    }
    checked = [json[@"checked"] boolValue];
    if (json[@"selectedImage"]) {
        NSString *imageStr = json[@"selectedImage"];
        if ([imageStr hasPrefix:@"http"]) {
            int scale = [[UIScreen mainScreen]scale];
            [UILazyImageView registerForName:imageStr block:^(NSData *data) {
                image_on = [UIImage imageWithData:data scale:scale];
                if (checked) {
                    [self setImage:image_on forState:UIControlStateNormal];
                }
            }];
        } else{
            if ([imageStr isEqualToString:@""]) {
                image_on = [UIImage imageNamed:@"hero_check_on.png"];
            } else {
                image_on = [UIImage imageNamed:imageStr];
            }
        }
    }
    if (json[@"unselectedImage"]) {
        NSString *imageStr = json[@"unselectedImage"];
        if ([imageStr hasPrefix:@"http"]) {
            int scale = [[UIScreen mainScreen]scale];
            [UILazyImageView registerForName:imageStr block:^(NSData *data) {
                image_off = [UIImage imageWithData:data scale:scale];
                if (!checked) {
                    [self setImage:image_off forState:UIControlStateNormal];
                }
            }];
        } else{
            if ([imageStr isEqualToString:@""]) {
                image_off = [UIImage imageNamed:@"hero_check_off.png"];
            } else {
                image_off = [UIImage imageNamed:imageStr];
            }
        }
    }
    if (checked) {
        [self setImage:image_on forState:UIControlStateNormal];
    } else {
        [self setImage:image_off forState:UIControlStateNormal];
    }

    if (json[@"click"]) {
        actionObject = json[@"click"];
    }
}

-(void)onClicked:(id)sender
{
    checked = !checked;
    if (checked) {
        [self setImage:image_on forState:UIControlStateNormal];
    }
    else {
        [self setImage:image_off forState:UIControlStateNormal];
    }
    [self.controller.view endEditing:YES];
    if (actionObject) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:actionObject];
        [dict setObject:[NSNumber numberWithBool:checked] forKey:@"value"];
        [self.controller on:dict];
    }
}

@end

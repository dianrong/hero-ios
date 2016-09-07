

#import "HeroButton.h"
#import "UILazyImageView.h"
#import "UIImage+alpha.h"
#import "common.h"
@implementation HeroButton
{
    id actionObject;
    NSString *backgroundColor;
    NSString *backgroundDisabledColor;
}

-(instancetype)init{
    self = [self.class buttonWithType:UIButtonTypeSystem];
    if(self){
    }
    return self;
}
-(void)on:(NSDictionary *)json{
    [super on:json];
    self.reversesTitleShadowWhenHighlighted = YES;
    self.clipsToBounds = YES;
    [self addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (json[@"title"]) {
        [self setTitle:json[@"title"] forState:UIControlStateNormal];
        [self setTitle:json[@"title"] forState:UIControlStateDisabled];
    }
    if (json[@"size"]) {
        double size = ((NSNumber*)json[@"size"]).doubleValue;
        self.titleLabel.font = [UIFont systemFontOfSize:size];
//        self.font = [UIFont systemFontOfSize:size];
    }
    if (json[@"titleH"]) {
        [self setTitle:json[@"titleH"] forState:UIControlStateHighlighted];
    }
    if (json[@"titleColor"]) {
        [self setTitleColor:UIColorFromStr(json[@"titleColor"]) forState:UIControlStateNormal];
    }
    if (json[@"backgroundColor"]) {
        backgroundColor = json[@"backgroundColor"];
        [self setBackgroundColor:UIColorFromStr(backgroundColor)];
    }
    if (json[@"titleDisabledColor"]) {
        [self setTitleColor:UIColorFromStr(json[@"titleDisabledColor"]?:@"999999") forState:UIControlStateDisabled];
    }
    if (json[@"backgroundDisabledColor"]) {
        backgroundDisabledColor = json[@"backgroundDisabledColor"];
    }
    if (json[@"titleColorH"]) {
        [self setTitleColor:UIColorFromStr(json[@"titleColorH"]) forState:UIControlStateHighlighted];
    }
    if (json[@"tinyColor"]) {
        [self setTintColor:UIColorFromStr(json[@"tinyColor"])];
    }
    if (json[@"enable"]) {
        BOOL enable = ((NSNumber*)(json[@"enable"])).boolValue;
        [self setEnabled:enable];
        if (!enable) {
            [self setBackgroundColor:UIColorFromStr(backgroundDisabledColor?:@"aaaaaa")];
        }else{
            [self setBackgroundColor:UIColorFromStr(backgroundColor)];
        }
    }
    if (json[@"imageN"]) {
        NSString *imageStr = json[@"imageN"];
        if ([imageStr hasPrefix:@"#"]) {
            imageStr = [imageStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
            [self setBackgroundImage:[UIImage imageWithColor:UIColorFromStr(imageStr)] forState:UIControlStateNormal];
        }else if([imageStr hasPrefix:@"http"]){
            int scale = [[UIScreen mainScreen]scale];
            [UILazyImageView registerForName:imageStr block:^(NSData *data) {
                [self setBackgroundImage:[UIImage imageWithData:data scale:scale] forState:UIControlStateNormal];
            }];
        }else{
            [self setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        }
    }
    if (json[@"imageH"]) {
        NSString *imageStr = json[@"imageH"];
        if ([imageStr hasPrefix:@"#"]) {
            imageStr = [imageStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
            [self setBackgroundImage:[UIImage imageWithColor:UIColorFromStr(imageStr)] forState:UIControlStateHighlighted];
        }else if([imageStr hasPrefix:@"http"]){
            int scale = [[UIScreen mainScreen]scale];
            [UILazyImageView registerForName:imageStr block:^(NSData *data) {
                [self setBackgroundImage:[UIImage imageWithData:data scale:scale] forState:UIControlStateHighlighted];
            }];
        }else{
            [self setBackgroundImage:[UIImage imageNamed:imageStr] forState:UIControlStateHighlighted];
        }
    }
    if (json[@"click"]) {
        actionObject = json[@"click"];
    }
}
-(void)onClicked:(id)sender
{
    [KEY_WINDOW endEditing:YES];
    if (actionObject) {
        [self.controller on:actionObject];
    }
}

@end
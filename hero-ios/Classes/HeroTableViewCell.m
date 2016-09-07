//
//  HeroTableViewCell.m
//  hero
//
//  Created by Liu Guoping on 15/9/5.
//  Copyright (c) 2015年 Liu Guoping. All rights reserved.
//

#import "HeroTableViewCell.h"
#import "HeroSwitch.h"
#import "UILazyImageView.h"

@implementation HeroTableViewCell
-(instancetype)initWithJson:(NSDictionary *)json viewController:(HeroViewController *)viewController
{
    if (json[@"res"]) {
        self = [[NSBundle mainBundle]loadNibNamed:json[@"res"] owner:nil options:nil][0];
        self.controller = viewController;
        self.json = json;
        [self on:json];
    }else{
        self.controller = viewController;
        self = [self initWithJson:json];
    }
    return self;
}

-(instancetype)initWithJson:(NSDictionary*)json{
    NSString *boolValue   = json[@"boolValue"];
    NSString *textValue   = json[@"textValue"];
    NSString *imageValue   = json[@"imageValue"];
    if (boolValue) {
        self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"%@",self]];
    }else if (imageValue) {
        self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"%@",self]];
    }else if (textValue) {
        self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[NSString stringWithFormat:@"%@",self]];
    }else{
        self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[NSString stringWithFormat:@"%@",self]];
    }
    return self;
}

-(void)on:(NSDictionary *)json{
    [super on:json];
    NSString *imageStr = json[@"image"];
    NSString *title    = json[@"title"];
    NSString *detail   = json[@"detail"];
    NSString *boolValue   = json[@"boolValue"];
    NSString *textValue   = json[@"textValue"];
    NSString *imageValue   = json[@"imageValue"];
    if (boolValue) {
        HeroSwitch *valueElement = [[HeroSwitch alloc]init];
        [valueElement on:@{@"name":title,@"value":boolValue}];
        self.accessoryView = valueElement;
    }
    else if (imageValue) {
        UIImageView *valueElement = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
        [UILazyImageView registerForName:imageValue block:^(NSData *data) {
            valueElement.image = [UIImage imageWithData:data scale:[UIScreen mainScreen].scale];
        }];
        self.accessoryView = valueElement;
    }
    else if (textValue) {
        self.detailTextLabel.text = [NSString stringWithFormat:@"%@",textValue ];
    }
    else
    {
        self.detailTextLabel.numberOfLines = 10;
        self.detailTextLabel.text = detail;
    }
    self.textLabel.text = title;
    if (imageStr) {
        [UILazyImageView registerForName:imageStr block:^(NSData *data) {
            self.imageView.image = [UIImage imageWithData:data scale:[UIScreen mainScreen].scale];
            [self layoutSubviews];
        }];
    }
    if (json[@"AccessoryType"]) {
        NSString *type = json[@"AccessoryType"];
        if ([@"None" isEqualToString:type]) {
            self.accessoryType = UITableViewCellAccessoryNone;
        }else if ([@"DisclosureIndicator" isEqualToString:type]){
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if ([@"DetailDisclosureButton" isEqualToString:type]){
            self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }else if ([@"Checkmark" isEqualToString:type]){
            self.accessoryType = UITableViewCellAccessoryCheckmark;
        }else if ([@"DetailButton" isEqualToString:type]){
            self.accessoryType = UITableViewCellAccessoryDetailButton;
        }
    }
    if (json[@"selectionStyle"]) {
        NSString *style = json[@"selectionStyle"];
        if ([@"None" isEqualToString:style]) {
            self.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end

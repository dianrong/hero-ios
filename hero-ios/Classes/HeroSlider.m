

#import "HeroSlider.h"
#import "UILazyImageView.h"
#import "UIImage+alpha.h"
#import "common.h"
@implementation HeroSlider
-(void)on:(NSDictionary *)json{
    [super on:json];
    self.clipsToBounds = YES;
    [self addTarget:self action:@selector(onChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self addTarget:self action:@selector(onEndWithValue:) forControlEvents:UIControlEventTouchUpInside];
    if (json[@"value"]) {
        self.value = ((NSNumber*)json[@"value"]).floatValue;
    }
}
-(void)onChangeValue:(id)sender
{
    if (self.json[@"change"]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.json[@"change"]];
        [dic setObject:@(self.value) forKey:@"value"];
        [self.controller on:dic];
    }
}
-(void)onEndWithValue:(id)sender
{
    if (self.json[@"end"]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.json[@"end"]];
        [dic setObject:@(self.value) forKey:@"value"];
        [self.controller on:dic];
    }
}

@end
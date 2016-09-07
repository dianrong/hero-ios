

#import "HeroCustomButton.h"
#import "UILazyImageView.h"
#import "UIImage+alpha.h"
#import "common.h"
@implementation HeroCustomButton
{
    id actionObject;
    NSString *backgroundColor;
    NSString *backgroundDisabledColor;
}
-(instancetype)init{
    self = [self.class buttonWithType:UIButtonTypeCustom];
    if(self){
    }
    return self;
}

@end
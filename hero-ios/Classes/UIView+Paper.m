
#import "UIView+Paper.h"
#import <objc/runtime.h>
#import <CoreImage/CoreImage.h>

static void *s_ripple = &s_ripple;
static void *s_raised = &s_raised;

@implementation UIView (Paper)
@dynamic raised;
@dynamic ripple;

-(BOOL)raised{
    return [objc_getAssociatedObject(self, s_raised) boolValue];
}
-(BOOL)ripple{
    return [objc_getAssociatedObject(self, s_ripple) boolValue];
}
-(void)setRaised:(BOOL)raised
{
    objc_setAssociatedObject(self, s_raised,[NSNumber numberWithBool: raised], OBJC_ASSOCIATION_ASSIGN);
    if (raised) {
        self.clipsToBounds = NO;
        self.layer.shadowColor = [UIColor grayColor].CGColor;//shadowColor阴影颜色
        self.layer.shadowOffset = CGSizeMake(4,4);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
        self.layer.shadowOpacity = 0.4;//阴影透明度，默认0
        self.layer.shadowRadius = 4;//阴影半径，默认3
    }
}
-(void)setRipple:(BOOL)ripple
{
    objc_setAssociatedObject(self, s_ripple,[NSNumber numberWithBool: ripple], OBJC_ASSOCIATION_ASSIGN);
    if (ripple) {
        self.userInteractionEnabled = YES;
        UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(touchesBeganRipple:)];
        tap.minimumPressDuration = 0.0001f;
        tap.cancelsTouchesInView = NO;
        tap.delaysTouchesEnded = YES;
        [self addGestureRecognizer:tap];
    }
}
-(void)touchesBeganRipple:(UITapGestureRecognizer *)ges
{
    if (self.ripple && ges.state == UIGestureRecognizerStateBegan) {
        CGPoint aPntTapLocation = [ges locationInView:self];
        CALayer *backgroundLayer = [CALayer layer];
        backgroundLayer.masksToBounds = YES;
        backgroundLayer.frame = self.bounds;
        [self.layer addSublayer:backgroundLayer];
        CALayer *aLayer = [CALayer layer];
        aLayer.name = @"ripple";
        UIColor *rippleColor = self.backgroundColor?self.backgroundColor:[UIColor colorWithWhite:1.0 alpha:0.3];
        CGFloat red ,green,blue;
        [rippleColor getRed:&red green:&green blue:&blue alpha:nil];
        rippleColor = [UIColor colorWithRed:red>0.8?red-0.2:red+0.2 green:green>0.8?green-0.2:green+0.2 blue:blue>0.8?blue-0.2:blue+0.2 alpha:0.2];
        aLayer.backgroundColor = rippleColor.CGColor;
        aLayer.frame = CGRectMake(0, 0, 20, 20);
        aLayer.cornerRadius = 20/2;
        aLayer.masksToBounds =  YES;
        aLayer.position = aPntTapLocation;
        [backgroundLayer addSublayer:aLayer];
        // Create a basic animation changing the transform.scale value
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        
        // Set the initial and the final values
        [animation setToValue:[NSNumber numberWithFloat:(2.5*MAX(self.frame.size.height, self.frame.size.width))/20]];
        // Set duration
        [animation setDuration:0.6f];
        
        // Set animation to be consistent on completion
        [animation setRemovedOnCompletion:NO];
        [animation setFillMode:kCAFillModeForwards];
        
        // Add animation to the view's layer
        CAKeyframeAnimation *fade = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        fade.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:1.0],[NSNumber numberWithFloat:0.5],[NSNumber numberWithFloat:0.0], nil];
        fade.duration = 0.5;
        
        CAAnimationGroup *animGroup = [CAAnimationGroup animation];
        animGroup.duration  = 0.5f;
        animGroup.delegate=self;
        animGroup.animations = [NSArray arrayWithObjects:animation,fade, nil];
        [animGroup setValue:aLayer forKey:@"animationLayer"];
        [aLayer addAnimation:animGroup forKey:@"scale"];
    }
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CALayer *layer = [anim valueForKey:@"animationLayer"];
    if(layer && [layer.name isEqualToString:@"ripple"]){
        [layer removeAnimationForKey:@"scale"];
        [layer.superlayer removeFromSuperlayer];
        layer = nil;
        anim = nil;
    }
}

@end
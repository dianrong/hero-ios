//
//  HeroLockPatternView
//  HeroLockPatternView
//
//  Created by GPLIU on 5/11/16.
//
//


#import "HeroLockPatternView.h"

@implementation HeroLockPatternView {
    NSMutableArray *_buttons;
    NSMutableArray *_buffer;
    CGPoint _currentPoint;
    float _width;
    float _diameter;
    BOOL _hasTrack;
    BOOL _bigTrack;
    UIColor *_tintColor;
    UIColor *_color;
    NSDictionary *_actionObject;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        _tintColor = UIColorFromStr(@"00bc8d");
        _color = UIColorFromStr(@"cccccc");
    }
    return self;
}
/*
 (16 + (28 + 28) + 16) + (16 + 56 + 16) + (16 + 56 + 16)
 */
-(void)on:(NSDictionary *)json{
    if (json[@"tintColor"]) {
        _tintColor = UIColorFromStr(json[@"tintColor"]);
    }
    if (json[@"color"]) {
        _color = UIColorFromStr(json[@"color"]);
    }
    if (json[@"track"]) {
        _hasTrack = [json[@"track"] boolValue];
    }
    if (json[@"bigTrack"]) {
        _bigTrack = [json[@"bigTrack"] boolValue];
    }
    if (json[@"action"]) {
        _actionObject = json[@"action"];
    }
    [super on:json];
    if (json[@"values"]) {
        [self reset];
        _buffer = json[@"values"];
        for (int i = 0; i < _buffer.count; ++i) {
            [self setOn:YES forIndex:[_buffer[i] intValue]];
        }
        [self setNeedsDisplay];
    }
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (frame.size.width > 0 && frame.size.height > 0) {
        for(UIView *v in self.subviews)
        {
            [v removeFromSuperview];
        }
        _width = self.bounds.size.width / 3;
        _diameter = _width - 16 * 2;
        _buttons = [NSMutableArray array];
        for (int i = 0; i < 9; i++) {
            UIView *button = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _diameter, _diameter)];
            button.layer.cornerRadius = _diameter / 2;
            button.center = CGPointMake(_width / 2 + (i % 3) * _width, _width / 2 + (i / 3) * _width);
            [_buttons addObject:button];
            [self addSubview:button];
            UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _bigTrack?_diameter:18, _bigTrack?_diameter:18)];
            dotView.center = CGPointMake(_diameter / 2, _diameter / 2);
            dotView.backgroundColor = _tintColor;
            dotView.layer.cornerRadius = dotView.bounds.size.width / 2;
            dotView.hidden = NO;
            [button addSubview:dotView];
        }
        [self reset];
        self.opaque = NO;
    }
}
- (void)setOn:(BOOL)on forIndex:(NSUInteger)index {
    UIView *button = _buttons[index];
    on = _hasTrack ? on : NO;
    if (on) {
        button.layer.borderWidth = 1;
        button.layer.borderColor = _tintColor.CGColor;
    } else {
        button.layer.borderWidth = 1;
        button.layer.borderColor =  _color.CGColor;
    }
    [button.subviews[0] setHidden:_hasTrack ? !on : YES];
    [button setNeedsDisplay];
}

- (void)reset {
    for (int i = 0; i < 9; ++i) {
        [self setOn:NO forIndex:i];
    }
    _buffer = [NSMutableArray array];
    _currentPoint = CGPointZero;
    [self setNeedsDisplay];
}

- (CGPoint)centerForIndex:(NSUInteger)index {
    return CGPointMake(_width / 2 + (index % 3) * _width, _width / 2 + (index / 3) * _width);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self changePoint:point end:NO];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self changePoint:point end:NO];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self changePoint:CGPointZero end:YES];
}

- (void)changePoint:(CGPoint)p end:(BOOL)end {
    if (!end) {
        for (int i = 0; i < 9; ++i) {
            CGPoint c = [self centerForIndex:i];
            CGFloat dx = c.x - p.x;
            CGFloat dy = c.y - p.y;
            if (sqrt(dx * dx + dy * dy) <= _diameter / 2) {
                if ([_buffer indexOfObject:@(i)] == NSNotFound) {
                    [self setOn:YES forIndex:i];
                    [_buffer addObject:@(i)];
                    if (_actionObject) {
                        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:_actionObject];
                        [dict setObject:@{@"values":_buffer,@"end":@"false"} forKey:@"value"];
                        [self.controller on:dict];
                    }
                    DLog(@"%@",_buffer);
                }
                break;
            }
        }
        _currentPoint = p;
        [self setNeedsDisplay];
    } else {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:_actionObject];
        [dict setObject:@{@"values":_buffer,@"end":@"true"} forKey:@"value"];
        [self.controller on:dict];
        [self reset];
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (_buffer.count && _hasTrack) {
        for (int i = 0; i < _buffer.count; ++i) {
            CGPoint p = [self centerForIndex:[_buffer[i] intValue]];
            if (i == 0) {
                CGContextMoveToPoint(context, p.x, p.y);
            } else {
                CGContextAddLineToPoint(context, p.x, p.y);
            }
            if ((i == _buffer.count - 1) && _currentPoint.x !=0 && _currentPoint.y !=0 ) {
                CGContextAddLineToPoint(context, _currentPoint.x, _currentPoint.y);
            }
        }
        CGContextSetStrokeColorWithColor(context, _tintColor.CGColor);
        CGContextSetLineWidth(context, 1);
        CGContextStrokePath(context);
    }
    // hide lines inside circle
    CGContextSetStrokeColorWithColor
    (context, [UIColor whiteColor].CGColor);
//    CGContextSetFillColorWithColor(context, _color.CGColor);
//    for (int i = 0; i < 9; ++i) {
//        CGContextStrokeEllipseInRect(context, CGRectMake(_width / 2 + (i % 3) * _width - _diameter / 2, _width / 2 + (i / 3) * _width - _diameter / 2, _diameter, _diameter));
//    }
}

@end

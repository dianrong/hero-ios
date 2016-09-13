

#import "HeroTextView.h"
@interface HeroTextView()
@end

@implementation HeroTextView{
    UILabel *_placeHolderLabel ;
    BOOL enableReturn;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        enableReturn = NO;
    }
    return self;
}

-(void)on:(NSDictionary *)json{
    [super on:json];
    self.delegate = self;
    if (json[@"text"]) {
        self.text = json[@"text"];
        if (self.text.length > 0) {
            _placeHolderLabel.hidden = true;
        }else{
            _placeHolderLabel.hidden = false;
        }
    }
    if (json[@"enableReturn"]) {
        enableReturn = [json[@"enableReturn"] boolValue];
    }
    if (json[@"appendText"]) {
        self.text = [NSString stringWithFormat:@"%@\r%@",self.text,json[@"appendText"]];
    }
    if (json[@"placeHolder"]) {
        if (!_placeHolderLabel) {
            _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 34)];
            _placeHolderLabel.adjustsFontSizeToFitWidth = YES;
            _placeHolderLabel.minimumScaleFactor = 0.5f;
            _placeHolderLabel.text = json[@"placeHolder"];
            _placeHolderLabel.textColor = [UIColor lightGrayColor];
            [self addSubview:_placeHolderLabel];
        }
    }
    if (json[@"editable"]) {
        NSString *editable =  json[@"editable"];
        if ([@"false" isEqualToString:editable]) {
            self.editable = false;
        }
    }
    if (json[@"size"]) {
        double size = ((NSNumber*)json[@"size"]).doubleValue;
        self.font = [UIFont systemFontOfSize:size];
        if (_placeHolderLabel) {
            _placeHolderLabel.font = [UIFont systemFontOfSize:size];
        }
    }
    if (json[@"textColor"]) {
        self.textColor = UIColorFromStr(json[@"textColor"]);
    }
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
    if (_placeHolderLabel) {
        _placeHolderLabel.hidden = true;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView;
{
    if (_placeHolderLabel) {
        if (self.text.length > 0) {
            _placeHolderLabel.hidden = true;
        }else{
            _placeHolderLabel.hidden = false;
        }
    }
}
-(void)textViewDidChange:(UITextView *)textView{
    if (self.json[@"textFieldDidEditing"]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.json[@"textFieldDidEditing"]];
        [dic setObject:self.text forKey:@"value"];
        [self.controller on:dic];
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (!enableReturn) {
        if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound) {
            return YES;
        }
        [textView resignFirstResponder];
        return NO;
    }
    return YES;

}
@end
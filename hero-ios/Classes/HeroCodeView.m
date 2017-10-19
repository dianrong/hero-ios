//
//  BSD License
//  Copyright (c) Hero software.
//  All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//
//  * Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
//  * Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  * Neither the name Facebook nor the names of its contributors may be used to
//  endorse or promote products derived from this software without specific
//  prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

//
//  Created by gpliu@icloud.com
//

#import "HeroCodeView.h"

@interface HeroCodeTextField : UITextField
@end
@implementation HeroCodeTextField
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return NO;
}
- (CGRect)caretRectForPosition:(UITextPosition *)position {
    return CGRectZero;
}
- (NSArray *)selectionRectsForRange:(UITextRange *)range {
    return nil;
}
@end


@interface HeroCodeView () <UITextFieldDelegate>

@property HeroCodeTextField *codeTextField;

@end

@implementation HeroCodeView {
    int count;
    float fontSize;
    UIColor *textColor;
    NSArray<UITextField *> *textFieldArray;
    BOOL secure;
    UIColor *borderColor;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        count = 6;
        fontSize = 20;
        textColor = UIColorFromStr(@"0f2348");
        borderColor = UIColorFromStr(@"d7d7d7");
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 2;
        self.backgroundColor = [UIColor whiteColor];
        self.codeTextField = [[HeroCodeTextField alloc] init];
        self.codeTextField.hidden = YES;
        self.codeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.codeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.codeTextField.returnKeyType = UIReturnKeyDone;
        self.codeTextField.keyboardType = UIKeyboardTypeASCIICapable;
        self.codeTextField.textColor = [UIColor clearColor];
        _codeTextField.delegate = self;
        [_codeTextField addTarget:self action:@selector(onTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)on:(NSDictionary *)json {
    [super on:json];
    if (json[@"size"]) {
        fontSize = [json[@"size"] floatValue];
    }
    if (json[@"color"]) {
        textColor = UIColorFromStr(json[@"color"]);
    }
    if (json[@"borderColor"]) {
        borderColor = UIColorFromStr(json[@"borderColor"]);
        self.layer.borderColor = borderColor.CGColor;
    }
    if (json[@"secure"]) {
        secure = [json[@"secure"] boolValue];
    }
    if (json[@"frame"]) {
        _codeTextField.frame = self.bounds;
        [self reloadViews];
    }
    if (json[@"count"]) {
        count = [json[@"count"] intValue];
        [self reloadViews];
    }
    if (json[@"focus"]) {
        if ([json[@"focus"] boolValue])
            [_codeTextField becomeFirstResponder];
        else
            [_codeTextField resignFirstResponder];
    }
}

- (void)reloadViews {
    float width = self.bounds.size.width / count;
    float height = self.bounds.size.height;
    if ([self.subviews count] > 0)
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIView *separatorView;
    NSMutableArray<UITextField *> *array = [NSMutableArray<UITextField *> array];
    UITextField *textField;
    BOOL isFirst = YES;
    for (int i = 0; i < count; i++) {
        textField = [[UITextField alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        textField.textAlignment = NSTextAlignmentCenter;
        textField.font = [UIFont systemFontOfSize:fontSize];
        textField.textColor = textColor;
        textField.userInteractionEnabled = NO;
        [self addSubview:textField];
        if (isFirst) {
            isFirst = NO;
        } else {
            separatorView = [[UIView alloc] initWithFrame:CGRectMake(i * width, 0, 0.5, height)];
            separatorView.backgroundColor = borderColor;
            [self addSubview:separatorView];
        }
        [array addObject:textField];
    }
    textFieldArray = array;
    [self addSubview:_codeTextField];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_codeTextField becomeFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _codeTextField) {
        NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSUInteger length = [textFieldArray count];
        if ([newText length] > length)
            return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

- (void)onTextFieldChanged:(UITextField *)textField {
    NSUInteger length = [_codeTextField.text length];
    for (int i = 0; i < length; i++) {
        if (i >= [textFieldArray count])
            continue;
        textFieldArray[i].secureTextEntry = secure;
        textFieldArray[i].text = [_codeTextField.text substringWithRange:NSMakeRange(i, 1)];
    }
    for (NSUInteger i = length; i < [textFieldArray count]; i++) {
        textFieldArray[i].text = 0;
    }
    if (self.json[@"textFieldDidEditing"]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.json[@"textFieldDidEditing"]];
        [dic setObject:self.name forKey:@"name"];
        [dic setObject:_codeTextField.text forKey:@"value"];
        [dic setObject:@"textFieldDidEditing" forKey:@"event"];
        [self.controller on:dic];
    }
}

@end



#import "HeroTextField.h"
@interface HeroTextFieldDelegate :NSObject<UITextFieldDelegate>
@property (nonatomic,weak) HeroTextField *textField;
@property (nonatomic,assign) NSInteger maxLen;
@property (nonatomic,assign) NSInteger minLen;
@property (nonatomic,copy) NSString *allowString;
@end
@implementation HeroTextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.textField.json[@"return"]) {
        [self.textField.controller on:self.textField.json[@"return"]];
    }
    [textField resignFirstResponder];
    return true;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.textField.json[@"textFieldDidEndEditing"]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.textField.json[@"textFieldDidEndEditing"]];
        [dic setObject:textField.text forKey:@"value"];
        [dic setObject:textField.name forKey:@"name"];
        [dic setObject:@"textFieldDidEndEditing" forKey:@"event"];
        [self.textField.controller on:dic];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (self.textField.json[@"textFieldDidBeginEditing"]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.textField.json[@"textFieldDidBeginEditing"]];
        [dic setObject:textField.text forKey:@"value"];
        [dic setObject:textField.name forKey:@"name"];
        [dic setObject:@"textFieldDidBeginEditing" forKey:@"event"];
        [self.textField.controller on:dic];
    }
}


- (BOOL)textField:(HeroTextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Note textField's current state before performing the change, in case
    // reformatTextField wants to revert it
    textField.previousTextFieldContent = textField.text;
    textField.previousSelection = textField.selectedTextRange;

    return YES;
}

@end

@interface HeroTextField()
@property (nonatomic,strong)HeroTextFieldDelegate *outDelegate;
@end
@implementation HeroTextField
{
    HeroViewController *controller;
}

-(void)on:(NSDictionary *)json{
    [super on:json];
    self.outDelegate = [[HeroTextFieldDelegate alloc]init];
    self.outDelegate.textField = self;
    self.delegate = self.outDelegate;
    if (json[@"text"]) {
        if (![json[@"text"] isKindOfClass:[NSString class]]) {
            self.text = NULL;
        }else{
            self.text = json[@"text"];
            controller = self.controller;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.json[@"textFieldDidEditing"]) {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.json[@"textFieldDidEditing"]];
                    [dic setObject:self.text forKey:@"value"];
                    [controller on:dic];
                }
            });
        }
    }
    if (json[@"clear"]) {
        self.text = NULL;
    }
    if (json[@"secure"]) {
        self.secureTextEntry = [json[@"secure"] boolValue];
    }
    if (json[@"placeHolder"]) {
        self.placeholder = json[@"placeHolder"];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: UIColorFromStr(@"cccccc")}];
    }
    if (json[@"type"]) {
        NSString *type = json[@"type"];
        if ([@"number" isEqualToString:type]) {
            self.keyboardType = UIKeyboardTypeDecimalPad;
        }
        if ([@"email" isEqualToString:type]) {
            self.keyboardType = UIKeyboardTypeEmailAddress;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
        }
        if ([@"phone" isEqualToString:type]) {
            self.keyboardType = UIKeyboardTypePhonePad;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
        }
        if ([@"pin" isEqualToString:type]) {
            self.keyboardType = UIKeyboardTypeNumberPad;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
        }
    }
    if (json[@"return"]) {
        self.returnKeyType = UIReturnKeyDone;
    }
    if (json[@"maxLength"]) {
        self.outDelegate.maxLen = ((NSNumber*)json[@"maxLength"]).integerValue;
    }
    if (json[@"minLength"]) {
        self.outDelegate.minLen = ((NSNumber*)json[@"minLength"]).integerValue;
    }
    if (json[@"_allowString"]) {
        self.outDelegate.allowString = json[@"_allowString"];
    }
    if (json[@"textColor"]) {
        self.textColor = UIColorFromStr(json[@"textColor"]);
    }
    if (json[@"placeHolderColor"]) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: UIColorFromStr(json[@"placeHolderColor"])}];
    }
    if (json[@"size"]) {
        double size = ((NSNumber*)json[@"size"]).doubleValue;
        self.font = [UIFont systemFontOfSize:size];
    }
    if (json[@"whileEditing"]) {
        if ([json[@"whileEditing"] boolValue]) {
            self.clearButtonMode = UITextFieldViewModeWhileEditing;
        }
    }

    if (self.json[@"textFieldDidEditing"]) {
        [self addTarget:self action:@selector(onTextChanged:) forControlEvents:UIControlEventEditingChanged];
    }
}

- (void)onTextChanged:(HeroTextField *)sender {
    if (sender.json[@"textFieldDidEditing"]) {
        if ([sender markedTextRange] == NULL) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:sender.json[@"textFieldDidEditing"]];
            [dic setObject:sender.text forKey:@"value"];
            [dic setObject:self.name forKey:@"name"];
            [dic setObject:@"UIControlEventEditingChanged" forKey:@"event"];
            [sender.controller on:dic];
        }
    }
}

@end


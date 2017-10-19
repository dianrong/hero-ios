//
//  HeroPaperTextField
//  mafia
//
//  Created by 朱成尧 on 4/1/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import "HeroPaperTextField.h"
#import "UIView+Addition.h"
#import "UILazyImageView.h"

static NSString *lockedStringInBase64 = @"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";

static NSString *eyeOpenStringInBase64 = @"iVBORw0KGgoAAAANSUhEUgAAAEIAAABCCAYAAADjVADoAAAElklEQVR4Ae2aA5A0SRCF39m2bdu2bdu27aus5dm2fZ3du2fbtm3f9YvduagdV/cs/t36IjLwo6cmK/Plq+pBIBAIBAKBQCAQCAQCgcCQ4fnLxkDSPik6m2dC0jorVKbAYy1j499/h8eg5KELx0Iiq0LNiYjkBqh5MY1fEZl/K8TfabyDSO5OoxmJ3YJJGka/fPPUiOUgqDwGNX/yC+YOlTcRGYNEFsSAJzarQ6UjjX+4+N4LeQMqu+Ll60bGgOHff4dDbDZAZJ7hIvs0VD5MY08kF4+KfkXtZojkFb/Fs1rkUagcCm1eHImdll8Ej7dNgE6ZqyupckkaX3lUyCdQsy+SZMS+1wCVezPs4u2IZQ7Uw1PnjgS1e0HlC48kP83n900bRGYXqPnBs6e/R9K0JrLAkarmZo/P+g1qD+y9MfyAnQwqmqGP30Wnna1ot8fpSqjcyb/nOGUrQOW5NAQddrHSDbAne372g40fu2rnpzBlUPfvmYQiYd27vv6Xu2m24KJynreYRk1zoyF0idfPmVTdbYdHZDSoXO/5Rb5F1LRSD92I5BHvzVBZGbmI7ME5PMHtbiU4SfALtk1H00IoQEPluyaaOk64TMRyXI75/o+r3myHCrv1c7cBa4Kaq9J4q1KJp9UwutMi1/qviQ7XrgsvVI7M6fwedYWxrCZw/CYtU6KYSHZgOZf590eiQNy0SsZ1/ea2WnWo5vkd36FVn8ckVCNpXpKHr6L/9zFbDITW2kmWV3D007hVJbErIpK/cieCjrEAR2RxO7ASaqGmpeS5rlaouS/z+tiCrNSKRHJHI84AtM1OIt4tqoYO1ENily19rmzjrPWSnFW7XrUPn7cRFeEegtiXRQtoqjMR45bZyUMcb3NqDg27HzVxHVzW4AGqQLFQcjrUw4NtM5fZxT2dSmvNmISv6DjrPOyYh3MlwhUj2ubi/qwHtVuVPtsZfyo3Zljb337mihmLzOdZE0E36jxLyuzKDqgGXWhkXi/6P3/hERnfEcsXM4jkvnDxEKvfM5bfJSjAA1QZ28sRWSUJV1QduRRj/3UZZIalmOnOUb5iizk6cXf5MjUtTDiFkZrQ3Q6vl6+ypkVQILb7e66nHbmJZeNMk4SXKgV4iuQBKrvKtxcd3j7yGJNSMGL54ZW6bzJ4s8RLlQK0ts41vkfc0+MKLjaH1S2MvKBpNFRbb1vLmyVnN+gM/e41pL1HEhKzKH1JHZ/7DdSuht6Clyz+am1PLnnD1XWo+7jCl/+LwthDE4i2TQM1n9ZRiQ/hQTs9eg+3R81Znm1yHsWz+PqNFULbTMdIs0RxdkekWwk1k6DyS567yuxEspRfdcgjvFTxTjo1oVY70K3yZr3fYP+q3Q2RvF/3hY3KtbxPqPaWij6BI5LToeqzqEEqC2Mg4LyD2NHvbZd833WUlkt4gOLZgba5dpXJVxRRxE2zDPT3n/NARdJ4rYGv9z6GymVprMWkY5ijs30qqN2Wr/e734x9UP3ilV5F3v7/JwGsMpqxQQlVnUaLBzv+QCSRGfmDEY5V13MEAoFAIBAIBAKBQCAQCAx2/gOW5lnFb0YfQgAAAABJRU5ErkJggg==";
static NSString *eyeCloseStringInBase64 = @"iVBORw0KGgoAAAANSUhEUgAAAEIAAABCCAYAAADjVADoAAADrklEQVR4AezBgQAAAADDoPtTH2TVIgAAAAAAAADg3JgDsARJDIb/s23btm3btm3bl8zqbJuFU6fnbNu2bU2q5nVlNfO8+KpS2kGSCf7eOJo+seWh5niZrolFogXRJx4ozwBHPyf2nxriwmboRJ6+YEwIvxPi8HQE+oyPjgkPEP4usanQaQhdZGL4Ew9GU6BP+MJsEPo4PERNoscRXzY6OgVHuwXfg/HLvU+G9pHw1+bmvxGSQTfiv/9GQLsjvE7wW/hfOHrWxPA+Yp4ZmXheDo5/MjddBF9cCY5MMrjc1smIo5Xh6Lfgr+dD8MqNo8LxzSaur+oHp82i8O+mlKhpmQldhv9uHAnthuPNIfSn8fMs9KD+OrrExKHLYAVY9AtD+MFwkQ7K+pfsV9NvtydTeTy0HvV/RDg+UtvAJOF4GEycbGJ4rL66Hzp3Agg/D0/7ohEPVWaF8I+wyfD0Yct1hpRmgtAjdYPR8wmZG1H4dTxy3qRoiPZSA3R1atAm25/BDlPhkxDHI7dgKO4Ox7+YBHwOoS/NptsHzXjhyrGQT12lvGoefjr0IcJX1rTKK1DhpWU6lGgpe14Pjp6sa9UnKhPB03wQ+jFsDM9bDooy0z4yG+NK2J5ytDU8f1kzSN+C8A7JvaNgMHmrNBqEdoHjN2ta4FN42rZ++9EfqT9/IebVBzqFLzcvvbdhcI+XxtXpbAdVal/A88UQ2gSP8oT9Pic43gnC10Dou/Bsu94f5THQCE8bwdE/abX8goeL06Lf6M1Cr0AFSXzO2BlKdDHjYCP7B0JPwlMlle67QXgDSHFJ+OJCyf2rpdV1AFx0amJXwNH7DZ8l9EZIutBt+epSZ1i0BwaMfnGdrlkI3RgcjYtLQ0v1PrrbCLGBmdC3iZ0L4UWhCN0REvxAcRZkoSpyONCTqpHh98KiwysurA2JjoPwndqveZVj5tE98NGOiMuz1+56Tba57rx2UXPF4JTK22boenVpIoRvgSvNiQdKC+CBaA48XJ5SB7NqFbOdjso5Ez2e9v/veLA0CVqKrlZHv6YOvYAMNHDzFQ+HxcpgoR6Zfz2y0GFoVWRL8dFauC9dUzn7WreHScQ6GQPu+TS413Jltad30+c9g5bjCpNB6LA8ZamSNyTioWjGDLV4Zdj/qnSz0M2jIk7f3SmYY/Bvmcd4Fx0aEvYAz4NuQ0s9HYJP5/T+mmZgboGuQxWgfuH7C4vkyPrxoP8T6Cb5vz04kAEAAAAY5G99j696AAAAIJCMZKJ6VaiBAAAAAElFTkSuQmCC";

static CGFloat const kFloatingLabelShowAnimationDuration = 0.3f;
static CGFloat const kFloatingLabelHideAnimationDuration = 0.3f;

typedef NS_ENUM(NSInteger, FormatStyle) {
    DefaultStyle,
    BankCardStyle,
    MoneyStyle,
    FixPhoneStyle,
};

@interface HeroPaperTextField () {
    BOOL _isFloatingLabelFontDefault;
}

@property (nonatomic) UIView *bottomLine;
@property (nonatomic) UILabel *bottomTextLabel;
@property (nonatomic) UILabel *titleLabel;

@property (nonatomic) UILabel * floatingLabel;
@property (nonatomic) CGFloat floatingLabelYPadding;
@property (nonatomic) CGFloat floatingLabelXPadding;
@property (nonatomic) UIFont *floatingLabelFont;
@property (nonatomic) UIColor *floatingLabelTextColor;
@property (nonatomic) UIColor *floatingLabelActiveTextColor;

@property (nonatomic) CGFloat placeholderYPadding;

@property (nonatomic) BOOL animateEvenIfNotFirstResponder;
@property (nonatomic) NSTimeInterval floatingLabelShowAnimationDuration;
@property (nonatomic) NSTimeInterval floatingLabelHideAnimationDuration;

@property (nonatomic) BOOL adjustsClearButtonRect;
@property (nonatomic) BOOL keepBaseline;
@property (nonatomic) BOOL alwaysShowFloatingLabel;

@property (nonatomic) NSString *theme;
@property (nonatomic) UIColor *bottomLineHightColor;
@property (nonatomic) UIColor *bottomLoneNormalColor;
@property (nonatomic) UIColor *placeHoldColor;

@property (nonatomic) UIView *rightImageContentView;
@property (nonatomic) UIImageView *rightImageView;

@property (nonatomic) UIButton *rightBtnContentView;
@property (nonatomic) UIButton *rightButton;
@property (nonatomic) CALayer *maskLayer;
@property (nonatomic) UILabel *countLbl;

@property (nonatomic) NSDictionary *countDownDic;

@property (nonatomic) UIButton *eyeButton;
@property (nonatomic) UIImageView *eyeImageView;
@property (nonatomic) UILabel *unitLbl;

@property (nonatomic) id actionObject;

@property (nonatomic) FormatStyle formatStyle;

@end

@implementation HeroPaperTextField

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
        _rightImageContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 20, 20)];
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        _rightImageView.layer.masksToBounds = YES;
        [_rightImageContentView addSubview:_rightImageView];
        [_rightImageContentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onImageTapped)]];
        
        _eyeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 55, 50)];
        [_eyeButton addTarget:self action:@selector(onEyeClick) forControlEvents:UIControlEventTouchUpInside];
        _eyeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _eyeImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_eyeButton addSubview:_eyeImageView];
        _eyeImageView.centerY = _eyeButton.height / 2 - 5;
        _eyeImageView.right = _eyeButton.width;
        _unitLbl = [[UILabel alloc] init];
        _unitLbl.font = [UIFont systemFontOfSize:16];
        _unitLbl.textColor = UIColorFromRGB(0x333333);
        _unitLbl.textAlignment = NSTextAlignmentRight;
        
        _rightBtnContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 28)];
        _rightButton.borderColor = UIColorFromRGB(0x00bc8d);
        _rightButton.layer.cornerRadius = 2;
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_rightButton setTitleColor:UIColorFromRGB(0x00bc8d) forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_rightBtnContentView addSubview:_rightButton];
        _rightButton.centerY = _rightBtnContentView.height / 2 - 5;
        _rightButton.right = _rightBtnContentView.width;
        _countLbl = [[UILabel alloc] initWithFrame:CGRectMake(80 - 28, 25 - 5 - 14, 28, 28)];
        _countLbl.font = [UIFont systemFontOfSize:12];
        _countLbl.textColor = UIColorFromRGB(0x333333);
        _countLbl.textAlignment = NSTextAlignmentCenter;
        
        _formatStyle = DefaultStyle;
    }
    return self;
}

- (void)onEyeClick {
    [self resignFirstResponder];
    _eyeButton.tag = _eyeButton.tag == 1 ? 0 : 1;
    if (_eyeButton.tag == 1) {
        _eyeImageView.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:eyeCloseStringInBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters]];
        self.secureTextEntry = YES;
    } else {
        _eyeImageView.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:eyeOpenStringInBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters]];
        self.secureTextEntry = NO;
    }
}

-(void)on:(NSMutableDictionary *)json {
    json = [NSMutableDictionary dictionaryWithDictionary:json];
    [super on:json];
    // 暂时无法完美的解决清空icon的配置
    if (json[@"placeHolder"]) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:json[@"placeHolder"]
                                                                     attributes:@{NSForegroundColorAttributeName: _placeHoldColor}];
    }
    self.clearButtonMode = UITextFieldViewModeNever;
    
    if (json[@"hideBottomLine"]) {
        self.bottomLine.hidden = [json[@"hideBottomLine"] boolValue];
    }
    if (json[@"infoText"]) {
        self.clipsToBounds = false;
        self.bottomTextLabel.text = json[@"infoText"];
        CGRect textBounds = [self.bottomTextLabel textRectForBounds:self.bounds limitedToNumberOfLines:5];
        self.bottomTextLabel.frame = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, textBounds.size.height);
    }
    if (json[@"title"]) {
        [self setFloatingLabelText:json[@"title"]];
        self.alwaysShowFloatingLabel = true;
    }
    if (json[@"theme"]) {
        self.theme = json[@"theme"];
    }
    if (json[@"rightImage"]) {
        NSString *imageStr = json[@"rightImage"][@"image"];
        if ([imageStr hasPrefix:@"http"]) {
            NSString *animation = json[@"animation"];
            int scale = [[UIScreen mainScreen]scale];
            [UILazyImageView registerForName:imageStr block:^(NSData *data) {
                self.rightImageView.alpha = 0.0f;
                self.rightImageView.image = [UIImage imageWithData:data scale:scale];
                [UIView animateWithDuration:animation?0.2:0.0 animations:^{
                    self.rightImageView.alpha = 1.0f;
                }];
            }];
        } else{
            self.rightImageView.image = [UIImage imageNamed:imageStr];
        }
        if (json[@"rightImage"][@"click"]) {
            _rightImageContentView.userInteractionEnabled = YES;
            _actionObject = json[@"rightImage"][@"click"];
        } else {
            _rightImageContentView.userInteractionEnabled = NO;
        }
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = _rightImageContentView;
    }
    else if (json[@"rightButton"]) {
        NSDictionary *dic = json[@"rightButton"];
        _actionObject = dic[@"click"];
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = _rightBtnContentView;
        [_rightButton setTitle:dic[@"title"] forState:UIControlStateNormal];
        _countDownDic = dic;
        if ([dic[@"isSendFirst"] boolValue]) {
            [self onClicked:nil];
        }
    }
    else if (json[@"unitText"]) {
        _unitLbl.text = json[@"unitText"];
        [_unitLbl sizeToFit];
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = _unitLbl;
    }
    else if (json[@"drSecure"]) {
        _eyeButton.centerY = self.height / 2;
        _eyeButton.right = self.width;
        NSDictionary *dic = json[@"drSecure"];
        if (dic[@"secure"] && [dic[@"secure"] boolValue]) {
            self.secureTextEntry = YES;
            _eyeButton.tag = 1;
            _eyeImageView.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:eyeCloseStringInBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters]];
        } else {
            self.secureTextEntry = NO;
            _eyeButton.tag = 0;
            _eyeImageView.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:eyeOpenStringInBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters]];
        }
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = _eyeButton;
    }
    else if (json[@"drLocked"]) {
        _rightImageView.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:lockedStringInBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters]];
        [self addSubview:_rightImageView];
        _rightImageView.right = self.width;
        _rightImageView.centerY = self.height / 2;
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = [[UIView alloc] initWithFrame:_rightImageView.bounds];
        self.enabled = NO;
    } else {
        // 不支持重置
        //        self.enabled = YES;
        //        [_rightImageView removeFromSuperview];
        //        self.rightView = nil;
    }
    if (json[@"startCountDown"]) {
        [self startCount];
    }
    if (json[@"formatStyle"]) {
        if ([json[@"formatStyle"] isEqualToString:@"bankCard"]) {
            _formatStyle = BankCardStyle;
            self.keyboardType = UIKeyboardTypeNumberPad;
        } else if ([json[@"formatStyle"] isEqualToString:@"money"]) {
            _formatStyle = MoneyStyle;
            self.keyboardType = UIKeyboardTypeDecimalPad;
        } else if ([json[@"formatStyle"] isEqualToString:@"fixPhone"]) {
            _formatStyle = FixPhoneStyle;
            self.keyboardType = UIKeyboardTypePhonePad;
        } else {
            _formatStyle = DefaultStyle;
        }
    }
}

- (void)onTextChanged:(HeroTextField *)textField {
    if (_formatStyle == BankCardStyle) {
        NSUInteger targetCursorPosition = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
        NSString *cardNumberWithoutSpaces = [self removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPosition];
        if ([cardNumberWithoutSpaces length] > 19) {
            // If the user is trying to enter more than 19 digits, we prevent
            // their change, leaving the text field in  its previous state.
            // While 16 digits is usual, credit card numbers have a hard
            // maximum of 19 digits defined by ISO standard 7812-1 in section
            // 3.8 and elsewhere. Applying this hard maximum here rather than
            // a maximum of 16 ensures that users with unusual card numbers
            // will still be able to enter their card number even if the
            // resultant formatting is odd.
            [textField setText:self.previousTextFieldContent];
            textField.selectedTextRange = self.previousSelection;
            return;
        }
        
        NSString *cardNumberWithSpaces = [self insertSpacesEveryFourDigitsIntoString:cardNumberWithoutSpaces andPreserveCursorPosition:&targetCursorPosition];
        textField.text = cardNumberWithSpaces;
        UITextPosition *targetPosition =
        [textField positionFromPosition: [textField beginningOfDocument] offset: targetCursorPosition];
        [textField setSelectedTextRange: [textField textRangeFromPosition: targetPosition toPosition: targetPosition]];
        if (textField.json[@"textFieldDidEditing"]) {
            if ([textField markedTextRange] == NULL) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:textField.json[@"textFieldDidEditing"]];
                [dic setObject:[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"value"];
                [textField.controller on:dic];
            }
        }
    }if (_formatStyle == MoneyStyle) {
        if ([textField.text componentsSeparatedByString:@"."].count > 2) {
            [textField setText:self.previousTextFieldContent];
            textField.selectedTextRange = self.previousSelection;
            return;
        }else if([textField.text componentsSeparatedByString:@"."].count == 2 && [textField.text componentsSeparatedByString:@"."][1].length>2){
            [textField setText:self.previousTextFieldContent];
            textField.selectedTextRange = self.previousSelection;
            return;
        }
        NSUInteger targetCursorPosition = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
        NSString *money = [textField.text stringByReplacingOccurrencesOfString:@"," withString:@""];
        NSString *moneyLeft = [[money componentsSeparatedByString:@"."] count]>1?[money componentsSeparatedByString:@"."][0]:money;
        NSMutableString *mTemp = [NSMutableString string];
        for (int i = moneyLeft.length,j = 0; i > 0; i--,j++) {
            if (j>0 && (j)%3==0 && j<moneyLeft.length) {
                [mTemp insertString:@"," atIndex:0];
            }
            [mTemp insertString:[moneyLeft substringWithRange:NSMakeRange(i-1, 1)] atIndex:0];
        }
        if ([[money componentsSeparatedByString:@"."] count]>1) {
            [mTemp appendString:@"."];
            [mTemp appendString:[money componentsSeparatedByString:@"."][1]];
        }
        targetCursorPosition += [mTemp componentsSeparatedByString:@","].count -[textField.previousTextFieldContent componentsSeparatedByString:@","].count;
        textField.text = mTemp;
        UITextPosition *targetPosition =
        [textField positionFromPosition: [textField beginningOfDocument] offset: targetCursorPosition];
        [textField setSelectedTextRange: [textField textRangeFromPosition: targetPosition toPosition: targetPosition]];
        
        if (textField.json[@"textFieldDidEditing"]) {
            if ([textField markedTextRange] == NULL) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:textField.json[@"textFieldDidEditing"]];
                [dic setObject:[textField.text stringByReplacingOccurrencesOfString:@"," withString:@""] forKey:@"value"];
                [textField.controller on:dic];
            }
        }
    }if (_formatStyle == FixPhoneStyle) {
        if (textField.previousTextFieldContent.length>=textField.text.length) {
            if (([textField.text hasPrefix:@"01"] || [textField.text hasPrefix:@"02"]) && textField.text.length == 3) {
                textField.text = [NSString stringWithFormat:@"%@-",textField.text];
            }else if ([textField.text hasPrefix:@"0"] && textField.text.length == 4) {
                textField.text = [NSString stringWithFormat:@"%@-",textField.text];
            }
        }
        if (textField.json[@"textFieldDidEditing"]) {
            if ([textField markedTextRange] == NULL) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:textField.json[@"textFieldDidEditing"]];
                [dic setObject:[textField.text stringByReplacingOccurrencesOfString:@"-" withString:@""] forKey:@"value"];
                [textField.controller on:dic];
            }
        }
    } else {
        if (self.json[@"theme"]) {
            NSString *theme = self.json[@"theme"];
            if ([@"drlender" isEqualToString:theme]) {
                self.layer.borderColor = UIColorFromStr(self.json[@"tintColor"]).CGColor;
                if (self.layer.borderWidth == 0) {
                    if (SCALE >2 ) {
                        self.layer.borderWidth = 0.33f;
                    }else{
                        self.layer.borderWidth = 0.5f;
                    }
                }
            }
        }
        if (textField.json[@"textFieldDidEditing"]) {
            if ([textField markedTextRange] == NULL) {
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:textField.json[@"textFieldDidEditing"]];
                [dic setObject:textField.text forKey:@"value"];
                [dic setObject:self.name forKey:@"name"];
                [textField.controller on:dic];
            }
        }
    }

}

- (void)setTheme:(NSString *)theme {
    _theme = [theme copy];
    if ([_theme isEqualToString:@"black"]) {
        _floatingLabelTextColor = [UIColor colorWithWhite:1 alpha:.5];
        _floatingLabelActiveTextColor = [UIColor colorWithWhite:1 alpha:.5];
        _bottomLineHightColor = [UIColor colorWithWhite:1 alpha:1];
        _bottomLoneNormalColor = [UIColor colorWithWhite:1 alpha:.4];
        _placeHoldColor = UIColorFromRGB(0xcccccc);
        self.textColor = UIColorFromRGB(0xffffff);
        _countLbl.textColor = [UIColor whiteColor];
    }else if ([_theme isEqualToString:@"blue"]) {
        _floatingLabelTextColor = UIColorFromRGB(0x999999);
        _floatingLabelActiveTextColor = UIColorFromRGB(0x999999);
        _bottomLineHightColor = UIColorFromRGB(0x6EA7FF);
        _bottomLoneNormalColor = UIColorFromRGB(0xcccccc);
        _placeHoldColor = UIColorFromRGB(0xcccccc);
        self.textColor = UIColorFromRGB(0x333333);
        _countLbl.textColor = UIColorFromRGB(0x333333);
        eyeCloseStringInBase64 = @"iVBORw0KGgoAAAANSUhEUgAAADIAAAAeCAYAAABuUU38AAAAAXNSR0IArs4c6QAABDRJREFUWAntVl1oXEUUPjP3bnb7k2BtU61asNDQpkk2pia5m71VqWKLFO2T2gd9EZ+0oCgUSl8sSJUiaEHBJ9EHrSiIoPgTomDdu3t3TYW7SUraVRtMaYxt0yj52XT3zvSbDZde9s82pOrDnYedmTNnzpnvOz97iYIRMBAwEDAQMPB/YyCZGYqnMkNP/NfvsmznDcf5Y1W9d+j1DoUrLHVuZRzT7O18oZ7uzThLjI42sssLv0pJzbPzF07Bx3u1/PBaBwl7eCfOXHUuXdpvpZxDtXRvhlxKydn0wueSqFnZF0K+Y2WGe2r5qgrEsrN7mRQDxBjjjB3EZQ6DryZSzmO1DC2nHCC0lD38IyJhMqJLnPNHGaewFG7StoceruarAkg6PboJhsCEdHF5ZzwWfV3j7KXFy+wTKz3yYDVDyyXL5XJhK53tFyTiRCy3ft3KO+NGx5eg9BHkBitK0T84eGpDub8KIJoWmuLEZ8DCk2Zv9IS60GdE30RojsIQWCl+l8xkDwMsyFreAbajk1PzZ0hSiSym8WdaWloWlJe40f4t52y3Wrsuu6Jm/6j6mMHB0+u6u7dc9BRT6aFDrhCvQDmHFGtlxPJYO1LXnzV7tg17ekudR0ZGVk/9XXieM/4aCEJG08cgfx+IK5Aeutfvw3J+WW92bv6z3FdVIH6lRDK7n2t0DMU2wZv0qDbDEd7ih1KK3QBUlFx8EaLIy4ax9az/3vWsbTvXVBSzLxLjB/DoVSjJCWLaU6bR9r2qU9j4DIBmNSZ2xWKddj2bdYGoeimIhd+Qq+MUbojt2L71vGcsmXEeEi4NeHvo/C5JHA8x/iljoTHDaL107Wxxlc1m18zNaRuKQuCR4nFi1AX2BYKgUnzMjEU3A0ypU6obJyxnH+d0HCDf5netPRDfuHF+0VLlb10gSh15e1ss1jFZftWyh56Gg3eRBx+gMdwOQ3uloAJkYTwGGYIaYjSLfI9gX8A+At0iSamjExbw+hBsDjDO30J034fy2pXhxlu7ujZN+30l0s59qNWEsumXl6//EUj5BW+Pf9uzYPLuSCh0R3f3tonk+PgKef7yPSRYDyJzrKTH2Gk8fAsndhKvmAHgB+CwyHTdbL6lwfEKGbaeQ0SPAODRPqPjiOfjRuYlAUE0doH5r+H8IzPWgchcG6pR5Av5C4jGVztinXu8E9VWJy/O5dH9fjKNaK8nV3OJhHNT0wDbsKZJD7e1tVV0Jb9+tXVF+62mVC7jUj+DVOGskVd8thQKV9qR93OIzEn/vRL7jE9AFvXL1VrlvitdkEP5v4hWl59fz77ut1YtA319rWMAovsL09OVXLajVsKaziraMiP5sxRyT7W6uz++/QfYWOHZudF5SRFRTqqBUHKNQv3I1xkmIt+ovX8wnQ4iWueIIjW7j18/WAcMBAwEDAQMBAz8WwxcBUUPnmoOOC/hAAAAAElFTkSuQmCC";
        eyeOpenStringInBase64 = @"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";
    } else if ([_theme isEqualToString:@"drlender"]) {
        self.bottomLine.hidden = true;
        CGRect frame = self.frame;
        frame.size.width = 15;
        UIView *leftview = [[UIView alloc] initWithFrame:frame];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = leftview;
        [self setFloatingLabelText:@""];
        _floatingLabel.hidden = true;
        self.keepBaseline = false;
        self.alwaysShowFloatingLabel = true;
        self.layer.borderColor = UIColorFromStr(self.json[@"color"]).CGColor;
        if (SCALE >2 ) {
            self.layer.borderWidth = 0.33f;
        }else{
            self.layer.borderWidth = 0.5f;
        }
    } else {
        _floatingLabelTextColor = UIColorFromRGB(0x999999);
        _floatingLabelActiveTextColor = UIColorFromRGB(0x999999);
        _bottomLineHightColor = UIColorFromRGB(0x00bc8d);
        _bottomLoneNormalColor = UIColorFromRGB(0xcccccc);
        _placeHoldColor = UIColorFromRGB(0xcccccc);
        self.textColor = UIColorFromRGB(0x333333);
        _countLbl.textColor = UIColorFromRGB(0x333333);
    }
    
    _floatingLabel.font = _floatingLabelFont;
    _floatingLabel.textColor = _floatingLabelTextColor;
    _bottomLine.backgroundColor = _bottomLoneNormalColor;
}

- (void)commonInit {
    _floatingLabel = [UILabel new];
    _floatingLabel.height = 11; // hack
    _floatingLabel.alpha = 0.0f;
    [self addSubview:_floatingLabel];
    
    // UX setting
    _floatingLabelFont = [UIFont systemFontOfSize:11];
    _floatingLabelYPadding = 4;
    
    self.font = [UIFont systemFontOfSize:16];
    _keepBaseline = YES;
    
    _placeholderYPadding = 5;
    
    _floatingLabelTextColor = UIColorFromRGB(0x999999);
    _floatingLabelActiveTextColor = UIColorFromRGB(0x999999);
    _bottomLineHightColor = UIColorFromRGB(0x00bc8d);
    _bottomLoneNormalColor = UIColorFromRGB(0xcccccc);
    _placeHoldColor = UIColorFromRGB(0xcccccc);
    
    _floatingLabel.font = _floatingLabelFont;
    _floatingLabel.textColor = _floatingLabelTextColor;
    _animateEvenIfNotFirstResponder = NO;
    _floatingLabelShowAnimationDuration = kFloatingLabelShowAnimationDuration;
    _floatingLabelHideAnimationDuration = kFloatingLabelHideAnimationDuration;
    [self setFloatingLabelText:self.placeholder];
    _adjustsClearButtonRect = YES;
    _isFloatingLabelFontDefault = YES;
    
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - .5, self.width, .5)];
    _bottomLine.backgroundColor = _bottomLoneNormalColor;
    _bottomLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:_bottomLine];
    
    _bottomTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height, self.width, 1)];
    _bottomTextLabel.backgroundColor = UIColorFromStr(@"fff8ec");
    _bottomTextLabel.shadowColor = UIColorFromStr(@"e4e4e4");
    _bottomTextLabel.shadowOffset = CGSizeMake(1, -1);
    _bottomTextLabel.textColor = UIColorFromStr(@"ff5500");
    _bottomTextLabel.font = [UIFont systemFontOfSize:11];
    _bottomTextLabel.alpha = 0.0f;
    [self addSubview:_bottomTextLabel];
    
    [self addTarget:self action:@selector(onTextDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(onTextDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
}

- (void)onTextDidBegin:(UITextField *)textField {
    
    _bottomLine.backgroundColor = _bottomLineHightColor;
    if (self.json[@"infoText"]) {
        self.bottomTextLabel.alpha = 0.0f;
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomTextLabel.alpha = 1.0f;
        }];
    }
    if (self.json[@"theme"]) {
        NSString *theme = self.json[@"theme"];
        if ([@"drlender" isEqualToString:theme]) {
            self.layer.borderColor = UIColorFromStr(self.json[@"tintColor"]).CGColor;
            if (self.layer.borderWidth == 0) {
                if (SCALE >2 ) {
                    self.layer.borderWidth = 0.33f;
                }else{
                    self.layer.borderWidth = 0.5f;
                }
            }
        }
    }
}

- (void)onTextDidEnd:(UITextField *)textField {
    _bottomLine.backgroundColor = _bottomLoneNormalColor;
    if (self.json[@"infoText"]) {
        self.bottomTextLabel.alpha = 1.0f;
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomTextLabel.alpha = 0.0f;
        }];
    }
    if (self.json[@"theme"]) {
        NSString *theme = self.json[@"theme"];
        if ([@"drlender" isEqualToString:theme]) {
            self.layer.borderColor = UIColorFromStr(self.json[@"color"]).CGColor;
            if (self.layer.borderWidth == 0) {
                if (SCALE >2 ) {
                    self.layer.borderWidth = 0.33f;
                }else{
                    self.layer.borderWidth = 0.5f;
                }
            }
        }
    }
}

- (UIColor *)labelActiveColor {
    if (_floatingLabelActiveTextColor) {
        return _floatingLabelActiveTextColor;
    }
    else if ([self respondsToSelector:@selector(tintColor)]) {
        return [self performSelector:@selector(tintColor)];
    }
    return [UIColor blueColor];
}

- (void)setFloatingLabelFont:(UIFont *)floatingLabelFont {
    if (floatingLabelFont != nil) {
        _floatingLabelFont = floatingLabelFont;
    }
    _floatingLabel.font = _floatingLabelFont;
    _isFloatingLabelFontDefault = floatingLabelFont == nil;
    [self setFloatingLabelText:self.placeholder];
    [self invalidateIntrinsicContentSize];
}

- (void)showFloatingLabel:(BOOL)animated {
    void (^showBlock)() = ^{
        _floatingLabel.alpha = 1.0f;
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          _floatingLabelYPadding,
                                          _floatingLabel.frame.size.width,
                                          _floatingLabel.frame.size.height);
    };
    
    if (animated || 0 != _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:_floatingLabelShowAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut
                         animations:showBlock
                         completion:nil];
    }
    else {
        showBlock();
    }
}

- (void)hideFloatingLabel:(BOOL)animated {
    void (^hideBlock)() = ^{
        _floatingLabel.alpha = 0.0f;
        _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                          _floatingLabel.font.lineHeight + _placeholderYPadding,
                                          _floatingLabel.frame.size.width,
                                          _floatingLabel.frame.size.height);
        
    };
    
    if (animated || 0 != _animateEvenIfNotFirstResponder) {
        [UIView animateWithDuration:_floatingLabelHideAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn
                         animations:hideBlock
                         completion:nil];
    }
    else {
        hideBlock();
    }
}

- (void)setFloatingLabelText:(NSString *)text {
    _floatingLabel.text = text;
    [self setNeedsLayout];
}

#pragma mark - UITextField

- (CGSize)intrinsicContentSize {
    CGSize textFieldIntrinsicContentSize = [super intrinsicContentSize];
    [_floatingLabel sizeToFit];
    return CGSizeMake(textFieldIntrinsicContentSize.width,
                      textFieldIntrinsicContentSize.height + _floatingLabelYPadding + _floatingLabel.bounds.size.height);
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    [self setFloatingLabelText:placeholder];
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
    [super setAttributedPlaceholder:attributedPlaceholder];
    [self setFloatingLabelText:attributedPlaceholder.string];
}

- (void)setPlaceholder:(NSString *)placeholder floatingTitle:(NSString *)floatingTitle {
    [super setPlaceholder:placeholder];
    [self setFloatingLabelText:floatingTitle];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    if ([self.text length] || self.keepBaseline) {
        rect = [self insetRectForBounds:rect];
    }
    return CGRectIntegral(rect);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super editingRectForBounds:bounds];
    if ([self.text length] || self.keepBaseline) {
        rect = [self insetRectForBounds:rect];
    }
    return CGRectIntegral(rect);
}

- (CGRect)insetRectForBounds:(CGRect)rect {
    CGFloat topInset = ceilf(_floatingLabel.bounds.size.height + _placeholderYPadding);
    topInset = MIN(topInset, [self maxTopInset]);
    return CGRectMake(rect.origin.x, rect.origin.y + topInset / 2.0f, rect.size.width, rect.size.height);
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect rect = [super clearButtonRectForBounds:bounds];
    if (0 != self.adjustsClearButtonRect
        && _floatingLabel.text.length // for when there is no floating title label text
        ) {
        if ([self.text length] || self.keepBaseline) {
            CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
            topInset = MIN(topInset, [self maxTopInset]);
            rect = CGRectMake(rect.origin.x, rect.origin.y + topInset / 2.0f, rect.size.width, rect.size.height);
        }
    }
    return CGRectIntegral(rect);
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super leftViewRectForBounds:bounds];
    CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
    topInset = MIN(topInset, [self maxTopInset]);
    rect = CGRectOffset(rect, 0, topInset / 2.0f);
    return rect;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect rect = [super rightViewRectForBounds:bounds];
    CGFloat topInset = ceilf(_floatingLabel.font.lineHeight + _placeholderYPadding);
    topInset = MIN(topInset, [self maxTopInset]);
    rect = CGRectOffset(rect, 0, topInset / 2.0f);
    return rect;
}

- (CGFloat)maxTopInset {
    return MAX(0, floorf(self.bounds.size.height - self.font.lineHeight - 4.0f));
}

- (void)setAlwaysShowFloatingLabel:(BOOL)alwaysShowFloatingLabel {
    _alwaysShowFloatingLabel = alwaysShowFloatingLabel;
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize floatingLabelSize = [_floatingLabel sizeThatFits:_floatingLabel.superview.bounds.size];
    _floatingLabel.frame = CGRectMake(_floatingLabel.frame.origin.x,
                                      _floatingLabel.frame.origin.y,
                                      floatingLabelSize.width,
                                      floatingLabelSize.height);
    BOOL firstResponder = self.isFirstResponder;
    _floatingLabel.textColor = (firstResponder && self.text && self.text.length > 0 ?
                                self.labelActiveColor : self.floatingLabelTextColor);
    if ((!self.text || 0 == [self.text length]) && !self.alwaysShowFloatingLabel) {
        [self hideFloatingLabel:firstResponder];
    }
    else {
        [self showFloatingLabel:firstResponder];
    }
}

- (void)onClicked:(id)sender {
    [self.controller.view endEditing:YES];
    if (_actionObject) {
        [self.controller on:_actionObject];
    }
}

- (void)onImageTapped {
    [self.controller.view endEditing:YES];
    if (_actionObject) {
        [self.controller on:_actionObject];
    }
}

- (void)reverseButton {
    CABasicAnimation *radiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    radiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    radiusAnimation.fromValue = [NSNumber numberWithFloat:14];
    radiusAnimation.toValue = [NSNumber numberWithFloat:2];
    radiusAnimation.duration = .3;
    radiusAnimation.removedOnCompletion= NO;
    radiusAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *frameAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    frameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    frameAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 28, 28)];
    frameAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 80, 28)];
    frameAnimation.duration = 0.3;
    frameAnimation.removedOnCompletion= NO;
    frameAnimation.fillMode=kCAFillModeForwards;
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(40 + 40 - 14, 0 - 5 + 25)];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(40, 0 - 5 + 25)];
    positionAnimation.duration = 0.3;
    positionAnimation.removedOnCompletion= NO;
    positionAnimation.fillMode=kCAFillModeForwards;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[radiusAnimation,frameAnimation,positionAnimation];
    animationGroup.duration = .3;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.delegate = self;
    
    [animationGroup setValue:@"end" forKey:@"buttonState"];
    [_rightButton.layer addAnimation:animationGroup forKey:@"group"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSString *value = [anim valueForKey:@"buttonState"];
    if ([value isEqualToString:@"begin"]) {
        _rightButton.borderColor = UIColorFromRGB(0xff5500);
        _rightButton.frame = CGRectMake(80 - 28, 25 - 5 - 14, 28, 28);
        [_rightBtnContentView addSubview:_countLbl];
        [self maskChart];
    } else if ([value isEqualToString:@"end"]) {
        _rightButton.borderColor = UIColorFromRGB(0x00bc8d);
        _rightButton.frame = CGRectMake(80 - 80, 25 - 5 - 14, 80, 28);
        [_rightButton setTitle:_countDownDic[@"repeatTitle"] forState:UIControlStateNormal];
    }
}

- (void)startCount {
    CABasicAnimation *radiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    radiusAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    radiusAnimation.fromValue = [NSNumber numberWithFloat:2];
    radiusAnimation.toValue = [NSNumber numberWithFloat:14];
    radiusAnimation.duration = .3;
    radiusAnimation.removedOnCompletion= NO;
    radiusAnimation.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *frameAnimation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    frameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    frameAnimation.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 80, 28)];
    frameAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 28, 28)];
    frameAnimation.duration = 0.3;
    frameAnimation.removedOnCompletion= NO;
    frameAnimation.fillMode=kCAFillModeForwards;
    
    CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    positionAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(40, 0 - 5 + 25)];
    positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(40 + 40 - 14, 0 - 5 + 25)];
    positionAnimation.duration = 0.3;
    positionAnimation.removedOnCompletion= NO;
    positionAnimation.fillMode=kCAFillModeForwards;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[radiusAnimation,frameAnimation,positionAnimation];
    animationGroup.duration = .3;
    animationGroup.removedOnCompletion = NO;
    animationGroup.fillMode = kCAFillModeForwards;
    animationGroup.delegate = self;
    
    [animationGroup setValue:@"begin" forKey:@"buttonState"];
    [_rightButton.layer addAnimation:animationGroup forKey:@"group"];
    // 倒计时时间
    _countLbl.text = [NSString stringWithFormat:@"%@",_countDownDic[@"time"]];
    
    [_rightButton setTitle:@"" forState:UIControlStateNormal];
    __block NSInteger timeOut = [_countDownDic[@"time"] integerValue];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_rightButton setTitle:@"" forState:UIControlStateNormal];
                _rightButton.userInteractionEnabled = YES;
                _rightButton.borderColor = UIColorFromRGB(0x00bc8d);
                _rightButton.layer.mask = nil;
                [_countLbl removeFromSuperview];
                [self reverseButton];
            });
        } else {
            NSString * timeStr = [NSString stringWithFormat:@"%0.2d",timeOut];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _countLbl.text = [NSString stringWithFormat:@"%@",timeStr];
                _rightButton.userInteractionEnabled = NO;
            });
            
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

- (CAShapeLayer *)newCircleLayerWithRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth fillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor startPercentage:(CGFloat)startPercentage endPercentage:(CGFloat)endPercentage {
    CAShapeLayer *circle = [CAShapeLayer layer];
    CGPoint center = CGPointMake(14, 14);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 * 3 clockwise: YES];
    path = [path bezierPathByReversingPath];
    circle.fillColor = fillColor.CGColor;
    circle.strokeColor = borderColor.CGColor;
    circle.strokeStart = startPercentage;
    circle.strokeEnd = endPercentage;
    circle.lineWidth = borderWidth;
    circle.path = path.CGPath;
    return circle;
}

- (void)maskChart {
    CAShapeLayer *maskLayer = [self newCircleLayerWithRadius:14 borderWidth:4 fillColor:[UIColor clearColor] borderColor:[UIColor blackColor] startPercentage:0 endPercentage:1];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = [_countDownDic[@"time"] integerValue];
    animation.fromValue = @1;
    animation.toValue = @0;
    animation.delegate = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.removedOnCompletion = YES;
    [maskLayer addAnimation:animation forKey:@"circleAnimation"];
    _rightButton.layer.mask = maskLayer;
}


/*
 *   Removes non-digits from the string, decrementing `cursorPosition` as
 *   appropriate so that, for instance, if we pass in `@"1111 1123 1111"`
 *   and a cursor position of `8`, the cursor position will be changed to
 *   `7` (keeping it between the '2' and the '3' after the spaces are removed).
 */
- (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition = *cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    for (NSUInteger i = 0; i < [string length]; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        if (isdigit(characterToAdd)) {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        } else {
            if (i < originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    return digitsOnlyString;
}

/*
 *   Inserts spaces into the string to format it as a credit card number,
 *   incrementing `cursorPosition` as appropriate so that, for instance, if we
 *   pass in `@"111111231111"` and a cursor position of `7`, the cursor position
 *   will be changed to `8` (keeping it between the '2' and the '3' after the
 *   spaces are added).
 */
- (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    for (NSUInteger i = 0; i < [string length]; i++) {
        if ((i > 0) && ((i % 4) == 0)) {
            [stringWithAddedSpaces appendString:@" "];
            if (i < cursorPositionInSpacelessString) {
                (*cursorPosition)++;
            }
        }
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    return stringWithAddedSpaces;
}

@end

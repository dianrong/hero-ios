//
//  Created by gpliu@icloud.com
//


#import <UIKit/UIKit.h>
#import "UIView+Hero.h"
#import "common.h"
@interface HeroTextField : UITextField

@property (nonatomic) NSString *previousTextFieldContent;
@property (nonatomic) UITextRange *previousSelection;

@end

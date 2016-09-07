//
//  Created by gpliu@icloud.com
//  到底是用继承还是catelog实现新功能，在此工程中规定如果这个类还要被继承使用就使用catelog，否则使用继承。
//

#import <Foundation/Foundation.h>
#import "common.h"
#import "HeroViewController.h"
#import "UIView+Hero.h"
#import "HeroLabel.h"
#import "HeroApp.h"
@protocol HeroProtocol <NSObject>
-(instancetype)initWithJson:(NSDictionary*)json;
-(void)on:(NSDictionary *)json;
@end

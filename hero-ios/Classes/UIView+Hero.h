//
//  Created by gpliu@icloud.com
//

#import <UIKit/UIKit.h>
#import "UIView+Paper.h"
#import "HeroViewController.h"
@interface UIView (Hero)
@property (nonatomic, strong) NSDictionary          *json;
@property (nonatomic, readonly) NSString            *name;
@property (nonatomic, readonly) NSString            *parent;
@property (nonatomic, readonly) NSDictionary        *action;
@property (nonatomic, readonly) NSMutableArray      *layoutListenners;
@property (nonatomic, weak) HeroViewController      *controller;
-(void)on:(NSDictionary *)json;
-(UIView*) findViewByName:(NSString*)name;
-(UIView*) findFocusView;

@end

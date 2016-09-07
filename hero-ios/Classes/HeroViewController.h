//
//  Created by gpliu@icloud.com
//  需要覆盖的方法太多，还是不用catelog的好，尽量不改变任何原有ViewController保证可以被继承
//


#import <UIKit/UIKit.h>
#import "common.h"
#import "HeroWebView.h"

@interface HeroViewController:UIViewController
@property (nonatomic, strong) HeroWebView       *webview;
@property (nonatomic, strong) NSDictionary      *ui;
@property (nonatomic, copy)   NSString          *url;

-(instancetype)initWithUrl:(NSString*) url;
-(instancetype)initWithJson:(NSDictionary*) json;
-(void)on:(NSDictionary *)json;

@end

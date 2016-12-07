//
//  HEROViewController.m
//  hero
//
//  Created by Liu Guoping on 15/8/19.
//  Copyright (c) 2015年 Liu Guoping. All rights reserved.
//

#import "HeroViewController.h"
#import "UIView+Hero.h"
#import "UIColor+Reverse.h"
#import "UIImage+alpha.h"
#import "UIView+Addition.h"
#import "NSString+Additions.h"
#import "HeroTextField.h"
#import "HeroSwitch.h"
#import "HeroBarButtonItem.h"
#import "UIAlertView+blockDelegate.h"
#import "HeroScrollView.h"

static bool customUserAgentHasSet = false;
@interface HeroViewController()<UINavigationBarDelegate>
@end
@implementation HeroViewController
{
    BOOL _useHero;
    BOOL _isTabBarHidden;
    BOOL _isNavBarHidden;
    BOOL _isNavBarTranslucent;
    BOOL _isMagicMove;
    UIColor *_navigationBarColor;
    float _viewOriginYBeforeKeyboard;
    NSMutableDictionary *_actionDatas;
}
+(void)heroUseragent{
    if (customUserAgentHasSet) {
        return;
    }
    customUserAgentHasSet = true;
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectZero];
    NSString *userAgent = [webview stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    userAgent = [NSString stringWithFormat:@"%@%@/%@ (%@; iOS %@; Scale/%0.2f)",userAgent,[[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleExecutableKey] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] ?: [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemVersion], [[UIScreen mainScreen] scale]];
    NSDictionary* dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%@%@",userAgent,@"hero-ios"], @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dict];
}
-(instancetype)initWithUrl:(NSString*)url{
    [[self class] heroUseragent];
    self = [self init];
    if (self) {
        _useHero = YES;
        self.url = url;
    }
    return self;
}
- (void)loadView {
    HeroScrollView *scrollView = [[HeroScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
    [scrollView on:@{@"name":@"contentView", @"class": @"HeroScrollView"}];
    self.view = scrollView;
}
-(instancetype)initWithJson:(NSDictionary*)json{
    self = [super init];
    if (self) {
        _useHero = YES;
        self.ui = json;
    }
    return self;
}
-(void)on:(NSDictionary *)json{
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self on:json];
        });
        return;
    }
    if ([json isKindOfClass:[NSArray class]]) {
        for (NSDictionary *d in json) {
            [self on:d];
        }
        return;
    }
    if (json[@"ui_fragment"]) {
        NSArray *views = json[@"ui_fragment"];
        for (NSDictionary *element in views) {
            if (element[@"class"]) {
                UIView *v = [[NSClassFromString(element[@"class"]) alloc]init];
                if (!v) {
                    v = [[UIView alloc]init];
                    v.backgroundColor = [UIColor redColor];
                }
                v.controller = self;
                UIView *p = [self.view findViewByName:element[@"parent"]];
                [(p?p:self.view) addSubview:v];
                [v on: element];
            }else if (element[@"res"]){
                UIView *v = [[NSBundle mainBundle] loadNibNamed:element[@"res"] owner:self options:NULL][0];
                if (v) {
                    UIView *p = [self.view findViewByName:element[@"parent"]];
                    [(p?p:self.view) addSubview:v];
                    v.controller = self;
                    [v on:element];
                }
            }
        }
    }else if (json[@"ui"]) {
        NSDictionary *ui = json[@"ui"];
        if (([ui[@"version"] floatValue] == [self.ui[@"version"] floatValue]) && ([ui[@"version"] floatValue] != -1)) {
            //todo
        }
        for(UIView *v in self.view.subviews)
        {
            [v removeFromSuperview];
        }
        if (ui[@"nav"]) {
            [self on:@{@"appearance":ui[@"nav"]}];
        }
        ((HeroScrollView*)self.view).contentOffset = CGPointMake(0, -((HeroScrollView*)self.view).contentInset.top);
        self.ui = ui;
        NSArray *views = ui[@"views"];
        for (NSDictionary *element in views) {
            UIView *v = nil;
            if (element[@"class"]) {
                v = [[NSClassFromString(element[@"class"]) alloc]init];
                
            }else if (element[@"res"]){
                v = [[NSBundle mainBundle] loadNibNamed:element[@"res"] owner:self options:NULL][0];
            }
            if (!v) {
                v = [[UIView alloc]init];
                v.backgroundColor = [UIColor redColor];
            }
            UIView *p = [self.view findViewByName:element[@"parent"]];
            [(p?p:self.view) addSubview:v];
            v.controller = self;
            [v on:element];
            if ([v.name hasPrefix:@"scroll_fix"]) {
                [self.view addSubview:v];
            }
            if (_isMagicMove) {
                v.alpha = 0.0f;
            }
            if (v.frame.origin.y + v.frame.size.height > self.view.bounds.size.height-((UIScrollView*)self.view).contentInset.top-((UIScrollView*)self.view).contentInset.bottom) {
                ((UIScrollView*)self.view).scrollEnabled = true;
                ((UIScrollView*)self.view).contentSize = CGSizeMake(((UIScrollView*)self.view).contentSize.width, v.frame.origin.y + v.frame.size.height);
            }
        }
        if (ui[@"backgroundColor"]) {
            self.view.backgroundColor = UIColorFromStr(ui[@"backgroundColor"]);
        }
        if (ui[@"tintColor"]) {
            if (self.navigationController.navigationBar.translucent) {
                UIView *bar = [[UIView alloc]init];
                [bar on: [NSMutableDictionary dictionaryWithDictionary: @{@"class":@"UIView",@"name":@"scroll_fix_header",@"frame":@{@"y":@"-64",@"w":@"1x",@"h":@"64"},@"backgroundColor":ui[@"tintColor"]}]];
                [self.view addSubview:bar];
            }else{
                [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
                [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColorFromStr(ui[@"tintColor"])] forBarMetrics:UIBarMetricsDefault];
            }
        }
    }
    else if (json[@"datas"]) {
        NSArray *datas = json[@"datas"];
        if ([datas isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dic = (NSDictionary*)datas;
            UIView *v = [self.view findViewByName:dic[@"name"]];
            if (!v) {
                v = [KEY_WINDOW findViewByName:dic[@"name"]];
            }
            [v on:dic];
        }else{
            for (NSDictionary *data in datas) {
                UIView *v = [self.view findViewByName:data[@"name"]];
                if (!v) {
                    v = [KEY_WINDOW findViewByName:data[@"name"]];
                }
                [v on:data];
            }
        }
    }
    else if (json[@"appearance"]) {
        NSDictionary *appearance = json[@"appearance"];
        if (appearance[@"title"]) {
            self.title = appearance[@"title"];
            self.tabBarController.title = self.title;
        }
        if (appearance[@"titleView"]) {
            NSDictionary *element = appearance[@"titleView"];
            UIView *v = [[NSClassFromString(element[@"class"]) alloc]init];
            v.controller = self;
            [v on:element];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationItem setTitleView:v];
                if (self.tabBarController) {
                    self.tabBarController.navigationItem.titleView = v;
                }
            });
        }
        if (appearance[@"leftItems"]) {
            NSArray *items = appearance[@"leftItems"];
            NSMutableArray *leftItems = [NSMutableArray array];
            for (NSDictionary *item in items) {
                HeroBarButtonItem *buttonItem = [[HeroBarButtonItem alloc]initWithJson:item];
                buttonItem.controller = self;
                [leftItems addObject:buttonItem];
            }
            self.navigationItem.leftBarButtonItems = leftItems;
            self.tabBarController.navigationItem.leftBarButtonItems = leftItems;
        }
        if (appearance[@"rightItems"]) {
            NSArray *items = appearance[@"rightItems"];
            NSMutableArray *rightItems = [NSMutableArray array];
            for (NSDictionary *item in items) {
                HeroBarButtonItem *buttonItem = [[HeroBarButtonItem alloc]initWithJson:item];
                buttonItem.controller = self;
                [rightItems addObject:buttonItem];
            }
            self.navigationItem.rightBarButtonItems = rightItems;
            self.tabBarController.navigationItem.rightBarButtonItems = rightItems;
        }
        if (appearance[@"navigationBarHidden"]) {
            _isNavBarHidden = [appearance[@"navigationBarHidden"] boolValue];
            if (self.navigationController.navigationBar.translucent) {
                if (_isNavBarHidden) {
                    ((UIScrollView*)self.view).contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
                }else{
                    ((UIScrollView*)self.view).contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
                }
            }
            [self.navigationController setNavigationBarHidden:_isNavBarHidden];
        }
        if (appearance[@"navigationBarTranslucent"]) {
            _isNavBarTranslucent = [appearance[@"navigationBarTranslucent"] boolValue];
            [self.navigationController.navigationBar setTranslucent:_isNavBarTranslucent];
        }
        if (appearance[@"navigationBarColor"]) {
            _navigationBarColor = UIColorFromStr(appearance[@"navigationBarColor"]);
            [self.navigationController.navigationBar setTranslucent:YES];
            [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:_navigationBarColor] forBarMetrics:UIBarMetricsDefault];
        }
    }
    else if (json[@"command"]) {
        NSDictionary *command = json[@"command"];
        if ([command isKindOfClass:[NSString class]]) {
            NSString *command = json[@"command"];
            if ([command hasPrefix:@"refresh"]) {
                [self loadFromUrl:self.url];
            }else if ([command hasPrefix:@"goto:"]){
                NSString *url = [command stringByReplacingOccurrencesOfString:@"goto:" withString:@""];
                NSURL *desUrl = [NSURL URLWithString:url];
                UIViewController *vC;
                if (desUrl && desUrl.scheme) {
                    if ([desUrl.scheme isEqualToString:@"http"] || [desUrl.scheme isEqualToString:@"https"]) {
                        vC = [[[self class] alloc]initWithUrl:url];
                    }else{
                        if ([[desUrl scheme] isEqualToString:@"tel"]) {
                            [UIAlertView showAlertViewWithTitle:@"" message:[url stringByReplacingOccurrencesOfString:@"tel://" withString:@""] cancelButtonTitle:@"取消" otherButtonTitles:@[@"呼叫"] onDismiss:^(NSInteger buttonIndex) {
                                if (buttonIndex == 0) {
                                    [[UIApplication sharedApplication]openURL:desUrl];
                                }
                            } onCancel:^{
                                ;
                            }];
                        }else{
                            [UIAlertView showAlertViewWithTitle:@"外部链接" message:[NSString stringWithFormat:@"%@",desUrl] cancelButtonTitle:@"取消" otherButtonTitles:@[@"跳转"] onDismiss:^(NSInteger buttonIndex) {
                                if (buttonIndex == 0) {
                                    [[UIApplication sharedApplication]openURL:desUrl];
                                }
                            } onCancel:^{
                                ;
                            }];
                        }
                    }
                }
                else{
                    if ([url componentsSeparatedByString:@"?"].count > 1) {
                        NSString *className = [url componentsSeparatedByString:@"?"][0];
                        vC = [[NSClassFromString(className) alloc]init];
                        NSString *parmStr = [url componentsSeparatedByString:@"?"][1];
                        NSArray *parms = [parmStr componentsSeparatedByString:@"&"];
                        NSMutableDictionary *json = [NSMutableDictionary dictionary];
                        for (NSString *str in parms) {
                            [json setValue:[str componentsSeparatedByString:@"="][1] forKey:[str componentsSeparatedByString:@"="][0]];
                        }
                        [vC performSelector:@selector(on:) withObject:json];
                    }else{
                        vC = [[NSClassFromString(url) alloc]init];
                    }
                }
                [self.navigationController pushViewController:vC animated:YES];
            }else if([command hasPrefix:@"magicGoto"]){
                NSString *url = [command stringByReplacingOccurrencesOfString:@"magicGoto:" withString:@""];
                NSURL *desUrl = [NSURL URLWithString:url];
                HeroViewController* vC = [[[self class] alloc]initWithUrl:url];
                [self.navigationController pushViewController:vC animated:NO];
                [vC magicMove:self];
            }else if ([command hasPrefix:@"load:"]){
                NSString *url = [command stringByReplacingOccurrencesOfString:@"load:" withString:@""];
                [self loadFromUrl:url];
            }else if ([command hasPrefix:@"parallel:"]){
                NSString *url = [command stringByReplacingOccurrencesOfString:@"parallel:" withString:@""];
                HeroWebView *webView = [[HeroWebView alloc]initWithFrame:CGRectZero];
                webView.hidden = true;
                webView.controller = self;
                [self.view addSubview:webView];
                [webView on:@{@"url":url}];
            }else if ([command hasPrefix:@"back"]){
                [self.navigationController popViewControllerAnimated:YES];
            }else if ([command hasPrefix:@"rootBack"]){
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else if ([command hasPrefix:@"present:"]){
                NSString *url = [command stringByReplacingOccurrencesOfString:@"present:" withString:@""];
                HeroViewController *vC;
                if ([url hasPrefix:@"http"]) {
                    vC = [[[self class] alloc]initWithUrl:url];
                    [vC on:@{@"appearance":@{@"leftItems":@[@{@"title":LS(@"取消"),@"click":@{@"command":@"dismiss"}}]}}];
                }else{
                    vC = [[NSClassFromString(url) alloc]init];
                }
                UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vC];
                nav.navigationBar.translucent = false;
                [self presentViewController:nav animated:YES completion:nil];
            }else if ([command hasPrefix:@"dismiss"]){
                [self dismissViewControllerAnimated:YES completion:nil];
            }else if ([command hasPrefix:@"showLoading"]){
                NSString *loading = [command stringByReplacingOccurrencesOfString:@"showLoading" withString:@""];
                loading = [loading stringByReplacingOccurrencesOfString:@":" withString:@""];
                [self showLoading:loading]; //拎出去方便重载此方法
            }else if ([command hasPrefix:@"stopLoading"]){
                [self stopLoading]; //拎出去方便重载此方法
            }else if ([command hasPrefix:@"submit"]){
                NSMutableDictionary *submitData = [NSMutableDictionary dictionary];
                for (NSDictionary *viewJson in self.ui[@"views"]) {
                    UIView *v = [self.view findViewByName:viewJson[@"name"]];
                    if (v && [v isKindOfClass:[HeroTextField class]]) {
                        NSString *text = ((HeroTextField*)v).text;
                        if (((HeroTextField*)v).secureTextEntry) {
                            text = [text md5];
                        }
                        [submitData setObject:text forKey:v.name];
                    }else if (v && [v isKindOfClass:[HeroSwitch class]]){
                        [submitData setObject:[NSNumber numberWithBool:((HeroSwitch*)v).on] forKey:v.name];
                    }
                }
                [self on:@{@"her":submitData}];
            } else if ([command hasPrefix:@"uploadFiles"]) {
                NSString *url = json[@"url"];
                NSDictionary *content = json[@"content"];
                NSArray *files = json[@"files"];
                NSDictionary *apiReturn = json[@"apiReturn"];
                
                NSFileManager *fileManager = [NSFileManager defaultManager];
                NSString *findPath = nil;
                NSString *fileKey = nil;
                
                NSDictionary *headers = @{ @"referer": @"https://www.dianrong.com" };

                NSURLSession *session = [NSURLSession sharedSession];
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                request.timeoutInterval = 20.0;
                [request setURL:[NSURL URLWithString:url]];
                [request setAllHTTPHeaderFields:headers];
                if ([[NSUserDefaults standardUserDefaults] valueForKey:@"httpHeader"]) {
                    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"httpHeader"];
                    for (NSString *key in [dic allKeys]) {
                        [request setValue:dic[key] forHTTPHeaderField:key];
                    }
                }
                [request setHTTPMethod:@"POST"];
                NSString *boundary = @"---------------------------14737809831466499882746641449";
                NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
                [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
                
                NSMutableData *body = [NSMutableData data];
                NSUInteger maxLength = [[content allKeys] count];
                NSUInteger i = 0;
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                for (NSString *key in [content allKeys]) {
                    i++;
                    if ([@"files" isEqualToString:content[key]]) {
                        fileKey = key;
                        continue;
                    }
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"%@", content[key]] dataUsingEncoding:NSUTF8StringEncoding]];
                    if (i != maxLength || (files && [files count] > 0)) {
                        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    }
                }
                
                if (files && [files count] > 0) {
                    i = 0;
                    maxLength = [files count];
                    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                    
                    for (NSString *localImage in files) {
                        i++;
                        if ([localImage hasPrefix:@"/"]) {
                            findPath = localImage;
                        } else {
                            NSArray *paths = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
                            NSURL *documentsURL = [paths firstObject];
                            if (documentsURL) {
                                findPath = [documentsURL.path stringByAppendingPathComponent:localImage];
                            }
                        }
                        
                        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", fileKey, localImage] dataUsingEncoding:NSUTF8StringEncoding]];
                        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                        NSData *jpgData = UIImageJPEGRepresentation([UIImage imageWithContentsOfFile:findPath], 0.6);
                        [body appendData:jpgData];
                        if (i != maxLength) {
                            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                        }
                    }
                }
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                
                [request setHTTPBody:body];
                [request addValue:[NSString stringWithFormat:@"%@", [NSNumber numberWithInteger:[body length]]] forHTTPHeaderField:@"Content-Length"];
                
                NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:body completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (error) {
                            DLog(@"error: %@", error);
                            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:apiReturn];
                            [dict setObject:@{@"error": @"failed"} forKey:@"value" ];
                            [self on:dict];
                        } else {
                            if (httpResp) {
                                if (httpResp.statusCode == 200) {
                                    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                    if (result) {
                                        DLog(@"result: %@", result);
                                        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:apiReturn];
                                        [dict setObject:result forKey:@"value" ];
                                        [self on:dict];
                                    } else {
                                        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:apiReturn];
                                        [dict setObject:@{@"error": @"failed"} forKey:@"value" ];
                                        [self on:dict];
                                    }
                                } else {
                                    if (data) {
                                        id result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                        DLog(@"server error: %@", response);
                                        if (result) {
                                            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:apiReturn];
                                            [dict setObject:@{@"error": result} forKey:@"value" ];
                                            [self on:dict];
                                        } else {
                                            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:apiReturn];
                                            [dict setObject:@{@"error": @"failed"} forKey:@"value" ];
                                            [self on:dict];
                                        }
                                    }
                                }
                            }
                        }
                    });
                }];
                [uploadTask resume];
            }
        }
        else if (command[@"show"]){
            NSDictionary *showObj = command[@"show"];
            if (showObj[@"content"]) {
                [UIAlertView showAlertViewWithTitle:showObj[@"title"] message:showObj[@"content"] cancelButtonTitle:showObj[@"cancel"]?showObj[@"cancel"]:@"OK" otherButtonTitles:showObj[@"others"] onDismiss:^(NSInteger buttonIndex) {
                    if (showObj[@"action"]) {
                        [self on:showObj[@"action"]];
                    }
                } onCancel:^{
                    if (showObj[@"cancelAction"]) {
                        [self on:showObj[@"cancelAction"]];
                    }
                }];
            }else if(showObj[@"class"]){
                UIView *v = [[NSClassFromString(showObj[@"class"]) alloc]init];
                v.controller = self;
                [v on :showObj ];
                [UIAlertView showAlertViewWithView:v data:showObj onDismiss:^(NSInteger buttonIndex) {
                    //
                } onCancel:^{
                    if (showObj[@"cancelAction"]) {
                        [self on:showObj[@"cancelAction"]];
                    }
                }];
            }
        }else if (command[@"delay"]){
            NSDictionary *delayObj = command[@"delay"];
            float delayTime = ((NSNumber*)command[@"delayTime"]).floatValue/1000;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self on:delayObj];
            });
        }else if (command[@"viewWillAppear"]){
            if (!_actionDatas) {
                _actionDatas = [NSMutableDictionary dictionary];
            }
            [_actionDatas setObject:command[@"viewWillAppear"] forKey:@"viewWillAppear"];
            [self on:command[@"viewWillAppear"]];
        }else if (command[@"viewWillDisappear"]){
            if (!_actionDatas) {
                _actionDatas = [NSMutableDictionary dictionary];
            }
            [_actionDatas setObject:command[@"viewWillDisappear"] forKey:@"viewWillDisappear"];
        }
    }else if (json[@"globle"]){
        NSDictionary *globle = json[@"globle"];
        NSString *key = globle[@"key"];
        if (key) {
            [[NSNotificationCenter defaultCenter] postNotificationName:key object:globle];
        }
    }else{  //specil logic
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json options:NSJSONWritingPrettyPrinted error:nil];
        NSString *js = [NSString stringWithFormat:@"API.in(%@)",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]];
        [self.webview stringByEvaluatingJavaScriptFromString:js];
    }
}
-(void)loadFromUrl:(NSString*)url{
    if (!url) {
        return;
    }
    self.url = url;
    if (!self.webview) {
        self.webview = [[HeroWebView alloc]init];
        UIScrollView *scrollView = (UIScrollView*)self.view;
        self.webview.frame = CGRectMake(scrollView.contentInset.left, 0, scrollView.bounds.size.width-scrollView.contentInset.left-scrollView.contentInset.right, scrollView.bounds.size.height-scrollView.contentInset.top-scrollView.contentInset.bottom);
        self.webview.autoresizingMask = 0x111111;
        self.webview.controller = self;
        [self.view addSubview:self.webview];
    }
    [self.webview on:@{@"url":url}];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.navigationController setNavigationBarHidden:_isNavBarHidden animated:YES];
    if (_actionDatas[@"viewWillAppear"]) {
        [self on:_actionDatas[@"viewWillAppear"]];
    }
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (_actionDatas[@"viewWillDisappear"]) {
        [self on:_actionDatas[@"viewWillDisappear"]];
    }
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.clipsToBounds = YES;
    if (!self.ui) {
        [self loadFromUrl:self.url];
    }else{
        [self on:self.ui];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_actionDatas[@"viewWillDisappear"]) {
        [self on:_actionDatas[@"viewWillDisappear"]];
    }
}
//子应用可以重载此方法实现一致的品牌loading效果
-(void)showLoading:(NSString*)str{
    UIView *backgroundView = [[UIApplication sharedApplication].keyWindow viewWithTag:187698];
    if (backgroundView) {
        [backgroundView removeFromSuperview];
    }
    backgroundView = [[UIView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0.0f;
    backgroundView.tag = 187698;//随机不可能重复值
    UIActivityIndicatorView *progress = [[UIActivityIndicatorView alloc]init];
    [progress startAnimating];
    progress.center = CGPointMake(backgroundView.bounds.size.width/2, backgroundView.bounds.size.height/2);
    [backgroundView addSubview:progress];
    if (str) {
        UILabel *label = [[UILabel alloc]init];
        label.text = str;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = UIColorFromStr(@"aaaaaa");
        [backgroundView addSubview:label];
        [label sizeToFit];
        label.center = CGPointMake(backgroundView.bounds.size.width/2+10, backgroundView.bounds.size.height/2);
        progress.center = CGPointMake(backgroundView.bounds.size.width/2-label.bounds.size.width/2-10, backgroundView.bounds.size.height/2);
    }
    [[UIApplication sharedApplication].keyWindow addSubview:backgroundView];
    [UIView animateWithDuration:0.2 animations:^{
        backgroundView.alpha = 0.25f;
    }];
}
-(void)stopLoading{
    UIView *background = [[UIApplication sharedApplication].keyWindow viewWithTag:187698];
    [UIView animateWithDuration:0.2 animations:^{
        background.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [background removeFromSuperview];
    }];
}
#pragma mark magic move
-(NSMutableArray *)findAllMagicElementsWithRootView:(UIView*)rootView{
    NSMutableArray *arr = [NSMutableArray array];
    for (UIView * view in rootView.subviews) {
        if (!view.hidden) {
            if ([view.name hasPrefix:@"magic"]) {
                [arr addObject:view];
            }
            [arr addObjectsFromArray:[self findAllMagicElementsWithRootView:view]];
        }
    }
    return arr;
}
-(NSMutableDictionary *)calcMagicRect{
    NSMutableArray * elements = [self findAllMagicElementsWithRootView:self.view];
    NSMutableDictionary * dicts = [NSMutableDictionary dictionary];
    for (UIView *view in elements) {
        CGRect rect = [view convertRect:view.bounds toView:self.view];
        [dicts setObject:[NSValue valueWithCGRect:rect] forKey:view.name];
    }
    return dicts;
}
-(void)magicMove:(HeroViewController*) vc{
    _isMagicMove = true;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableDictionary *dicts = [vc calcMagicRect];
        NSMutableArray *elements = [self findAllMagicElementsWithRootView:self.view];
        for (UIView *element in elements) {
            CGRect frame = element.frame;
            UIView *superView = element.superview;
            CGRect animationEndRect = [element convertRect:element.bounds toView:self.view];
            if (dicts[element.name]) {
                CGRect animationStartRect = [dicts[element.name] CGRectValue];
                [self.view addSubview:element];
                element.frame = animationStartRect;
                [UIView animateWithDuration:1 animations:^{
                    element.frame = animationEndRect;
                } completion:^(BOOL finished) {
                    element.frame = frame;
                    [superView addSubview:element];
                }];
            }
        }
        if (_isMagicMove) {
            [UIView animateWithDuration:1 animations:^{
                for (UIView *view in self.view.subviews) {
                    view.alpha = 1.0f;
                }
            }];
        }
        _isMagicMove = false;
    });
}

- (void)keyboardWillShow:(NSNotification*)notification {
    UIView *view = [self.view findFocusView];
    if (view) {
        if (!([NSStringFromClass([view class]) componentsSeparatedByString:@"Web"].count > 1)) {
            NSDictionary *info = [notification userInfo];
            NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
            NSNumber *animationTime = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
            CGRect begainValue = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
            CGRect keyboardSize = [value CGRectValue];
            CGRect rect = [view convertRect:view.bounds toView:KEY_WINDOW];
            float distance = self.view.bounds.size.height - rect.origin.y - rect.size.height - keyboardSize.size.height;
            float h = 0;
            UIScrollView *s = (UIScrollView*)self.view;
            if (begainValue.origin.y+begainValue.size.height/2  >= SCREEN_H && _viewOriginYBeforeKeyboard == 0) { //==0是修复第三方输入法未设置startsize的bug
                _viewOriginYBeforeKeyboard = ((UIScrollView*)self.view).contentOffset.y;
                h =   ( distance > 0 ? 0:(-distance) ) + _viewOriginYBeforeKeyboard + 5;
            }else{
                h =   ( distance > 0 ? 0:(-distance) ) + s.contentOffset.y;
            }
            [UIView animateWithDuration:[animationTime floatValue] animations:^{
                [s setContentOffset:CGPointMake(0, h)];
            }];
        }
    }
}

- (void)keyboardWillHide:(NSNotification*)notification {
    UIView *view = [self.view findFocusView];
    if (view) {
        if (!([NSStringFromClass([view class]) componentsSeparatedByString:@"Web"].count > 1)) {
            UIScrollView *s = (UIScrollView*)self.view;
            NSDictionary *info = [notification userInfo];
            NSNumber *animationTime = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
            [UIView animateWithDuration:[animationTime floatValue] animations:^{
                [s setContentOffset:CGPointMake(0, _viewOriginYBeforeKeyboard)];
            }completion:^(BOOL finished) {
                _viewOriginYBeforeKeyboard = 0;
            }];
        }
    }
}

//dealloc
-(void)dealloc{
    DLog(@"viewcontroller dealloc ");
}
@end

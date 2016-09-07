//
//  MEWebView.m
//  on2me
//
//  Created by atman on 15/1/7.
//  Copyright (c) 2015年 GPLIU. All rights reserved.
//

#import "HeroWebView.h"
#import "UIView+Hero.h"
#import <JavaScriptCore/JSContext.h>

@interface HeroWebView()<UIWebViewDelegate>

@end
@implementation HeroWebView
{
    UILabel *_ownnerLabel;
    NSString *_urlStr;
}
-(void)on:(NSDictionary *)json
{
    [super on:json];
    self.backgroundColor = UIColorFromRGB(0xf6f6f6);
    self.delegate = self;
    if (json[@"url"]) {
        _urlStr = json[@"url"];
#ifdef DEBUG
        if ([_urlStr componentsSeparatedByString:@"?"].count > 1) {
            _urlStr = [NSString stringWithFormat:@"%@%@",_urlStr,@"&test=true" ];
        }else{
            _urlStr = [NSString stringWithFormat:@"%@%@",_urlStr,@"?test=true" ];
        }
#endif
        NSURL *url = [NSURL URLWithString:_urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self loadRequest:request];
        if ([request.URL.absoluteString componentsSeparatedByString:kBaseurl].count<2) {
            if (!_ownnerLabel) {
                _ownnerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 48)];
                _ownnerLabel.textAlignment = NSTextAlignmentCenter;
                _ownnerLabel.font = [UIFont systemFontOfSize:12];
                _ownnerLabel.textColor = UIColorFromRGB(0xaaaaaa);
            }
            _ownnerLabel.text = [NSString stringWithFormat:@"本页面由 %@ 提供",request.URL.host];
            [self addSubview:_ownnerLabel];
            [self sendSubviewToBack:_ownnerLabel];
        }
    }
    if (json[@"innerHtml"]) {
        [self loadHTMLString:json[@"innerHtml"] baseURL:NULL];
    }
    if (json[@"contentSize"]) {
        NSString *x = json[@"contentSize"][@"x"];
        NSString *y = json[@"contentSize"][@"y"];
        CGSize size = CGSizeMake(x.floatValue, y.floatValue);
        if ([x hasSuffix:@"x"]) {
            size.width = SCREEN_W*x.floatValue;
        }
        if ([y hasSuffix:@"x"]) {
            size.width = SCREEN_H*x.floatValue;
        }
        self.scrollView.contentSize = size;
    }
    if (json[@"contentOffset"]) {
        NSString *x = json[@"contentOffset"][@"x"];
        NSString *y = json[@"contentOffset"][@"y"];
        CGPoint point = CGPointMake(x.floatValue, y.floatValue);
        if ([x hasSuffix:@"x"]) {
            point.x = SCREEN_W*x.floatValue;
        }
        if ([y hasSuffix:@"x"]) {
            point.y = SCREEN_H*x.floatValue;
        }
        self.scrollView.contentOffset = CGPointMake(x.floatValue, y.floatValue);
    }
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (title && title.length > 0) {
        self.controller.title = title;
    }
    if (self.json[@"webViewDidFinishLoad"]) {
        [self.controller on:self.json[@"webViewDidFinishLoad"]];
    }
    if (self.controller.webview.superview) { //普通web页面
        [self.controller on:@{@"common":@{@"event":@"finish"}}];
    }
}


-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    if (self.json[@"didFailLoadWithError"]) {
        [self.controller on:self.json[@"didFailLoadWithError"]];
    }
    [self loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"404" ofType:@"html"]]]];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString hasPrefix:@"http"] || [request.URL.absoluteString hasPrefix:@"file"]) {
        return YES;
    }else{
        if ([request.URL.absoluteString hasPrefix:@"hero://"]) {
#ifdef DEBUG
#else
            if (![_urlStr hasPrefix:kBaseurl] && kBaseurlOnly) {
                return false;
            }
#endif
            NSString *str = [request.URL.absoluteString stringByReplacingOccurrencesOfString:@"hero://" withString:@""];
//            str = [str decodeFromPercentEscapeString];
//            NSDictionary *dic = [str JSONValue];
//            [self.controller on:dic];
        }else{
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSString *query = [[request URL] query];
            NSArray *components = [query componentsSeparatedByString:@"&"];
            for (NSString *component in components) {
                NSArray *pair = [component componentsSeparatedByString:@"="];
                if (pair.count == 2) {
                    [params setObject:[[pair objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSMacOSRomanStringEncoding] forKey:[pair objectAtIndex:0]];
                }
            }
            [self.controller on:@{@"common":params}];
        }
        return false;
    }
}


-(void)dealloc
{
    DLog(@"webview dealloced");
}

@end

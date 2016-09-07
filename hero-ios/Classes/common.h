//
//  Created by gpliu@icloud.com
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define kBaseurl                @"https://borrower.dianrong.com"
#define kBaseurlOnly            false

#define SCREEN_W                ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_H                ([[UIScreen mainScreen] bounds].size.height)
#define CONTROLLER_W            (self.controller.view.bounds.size.width?(self.controller.view.bounds.size.width-((UIScrollView*)self.controller.view).contentInset.left-((UIScrollView*)self.controller.view).contentInset.right):SCREEN_W)
#define CONTROLLER_H            (self.controller.view.bounds.size.height?(self.controller.view.bounds.size.height-((UIScrollView*)self.controller.view).contentInset.top - ((UIScrollView*)self.controller.view).contentInset.bottom):SCREEN_H)
#define KEY_WINDOW              [[UIApplication sharedApplication]keyWindow]
#define ROOT_VIEW               ([[UIApplication sharedApplication]keyWindow].rootViewController.view)
#define ROOT_VIEWCONTROLLER     ([[UIApplication sharedApplication]keyWindow].rootViewController)
#define APP                     [UIApplication sharedApplication]
#define SCALE                   [[UIScreen mainScreen]scale]
#define PARENT_W                (self.superview.bounds.size.width?(self.superview.bounds.size.width-([self.superview isKindOfClass:[UIScrollView class]]?(((UIScrollView*)self.superview).contentInset.left + ((UIScrollView*)self.superview).contentInset.right):0)):CONTROLLER_W)
#define PARENT_H                (self.superview.bounds.size.height?(self.superview.bounds.size.height-([self.superview isKindOfClass:[UIScrollView class]]?(((UIScrollView*)self.superview).contentInset.top + ((UIScrollView*)self.superview).contentInset.bottom):0)):CONTROLLER_H)
#define NOT_NULL(s)             (s?s:@"")
#define LS(str)                 NSLocalizedString(str, nil)
#define SUBFIX(str)             ([NSString stringWithFormat:@"%@%@",[self class],str])
#define SUBFIXCAST(str)         ([NSString stringWithFormat:@"CAST%@",str])
#define SUBFIX2(str,i)          ([NSString stringWithFormat:@"%@%@%d",[self class],str,i])
#define SUBFIX3(str,s)          ([NSString stringWithFormat:@"%@%@%@",[self class],str,s])
#define isBackGround            (([UIApplication sharedApplication].applicationState == UIApplicationStateBackground)||([UIApplication sharedApplication].applicationState == UIApplicationStateInactive))
#define UIColorFromRGBA(rgbValue,alphaValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue])
#define UIColorFromRGB(rgbValue) ([UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(1-((float)((rgbValue & 0xFF000000) >> 24))/255.0)])

#define AppVersion() [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define IOS7_OR_LATER           ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS8_OR_LATER           ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IS_IPAD                 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#ifdef DEBUG
#define DLog(fmt,...) NSLog((@"%@ [line %u]: " fmt), NSStringFromClass(self.class), __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

static inline UIColor* UIColorFromStr(NSString *str){
    if (!str) {
        return [UIColor whiteColor];
    }
    if (str.length == 8) {
        NSString *alphaStr = [str substringFromIndex:6];
        NSScanner* scanner = [NSScanner scannerWithString: alphaStr];
        unsigned long long alphaValue;
        [scanner scanHexLongLong: &alphaValue];
        
        NSString *colorStr = [str substringToIndex:6];
        scanner = [NSScanner scannerWithString: colorStr];
        unsigned long long colorValue;
        [scanner scanHexLongLong: &colorValue];
        return UIColorFromRGBA(colorValue,alphaValue/255.0);
    }
    NSScanner* scanner = [NSScanner scannerWithString: str];
    unsigned long long longValue;
    [scanner scanHexLongLong: &longValue];
    return UIColorFromRGB(longValue);
}




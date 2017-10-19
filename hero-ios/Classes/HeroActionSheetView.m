//
//  HeroActionSheetView
//  Pods
//
//  Created by zhuyechao on 03/05/2017.
//
//

#import "HeroActionSheetView.h"

@interface HeroActionSheetView () <UIActionSheetDelegate>

@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) UIAlertController *alertContrller;
@property (strong, nonatomic) id data;
@property (strong, nonatomic) NSMutableDictionary *actionData;

@end

@implementation HeroActionSheetView {
    NSString *cancelTitle;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        cancelTitle = @"取消";
    }
    return self;
}

- (void)on:(NSDictionary *)json {
    [super on:json];
    if (json[@"cancelTitle"]) {
        cancelTitle = json[@"cancelTitle"];
    }
    if (json[@"data"]) {
        if ([json[@"data"] isKindOfClass:[NSArray class]]) {
            self.data = json[@"data"];
            if (IOS8_OR_LATER) {
                self.alertContrller = [UIAlertController alertControllerWithTitle:json[@"title"] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:json[@"cancelTitle"] ?: cancelTitle style:UIAlertActionStyleCancel handler:nil];
                [_alertContrller addAction:cancelAction];
                UIAlertAction *itemAction;
                self.actionData = [NSMutableDictionary dictionary];
                for (id item in _data) {
                    [_actionData addEntriesFromDictionary:@{item[@"title"]:item[@"action"]}];
                    itemAction = [UIAlertAction actionWithTitle:item[@"title"] ?: @"" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        if (_actionData[action.title]) {
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self.controller on:_actionData[action.title]];
                            });
                        }else{
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                [self.controller on:_actionData[action.title]];
                            });
                        }
                    }];
                    [_alertContrller addAction:itemAction];
                }
            } else {
                self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:json[@"cancelTitle"] ?: cancelTitle destructiveButtonTitle:nil otherButtonTitles: nil];
                _actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
                self.actionData = [NSMutableDictionary dictionary];
                for (id item in _data) {
                    [_actionData addEntriesFromDictionary:@{item[@"title"]:item[@"action"]}];
                    [_actionSheet addButtonWithTitle:item[@"title"]];
                }
            }
        }
    }
    if (json[@"show"]) {
        if ([json[@"show"] boolValue]) {
            if (IOS8_OR_LATER) {
                [self.controller presentViewController:_alertContrller animated:YES completion:nil];
            } else {
                [_actionSheet showInView:ROOT_VIEW];
            }
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *actionTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([actionTitle isEqualToString:cancelTitle]) {
    } else {
        if (_actionData[actionTitle]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.controller on:_actionData[actionTitle]];
            });
        }else{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.controller on:_actionData[actionTitle]];
            });
        }
    }
}

@end

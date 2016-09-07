//
//  HeroContactView.m
//  hero
//
//  Created by zhuyechao on 2/14/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import "HeroContactView.h"
@import AddressBook;

@implementation HeroContactView {
    NSMutableString *data;
    ABAuthorizationStatus status;
    id getContactObject;
    id getRecentObject;

}

-(void)on:(NSDictionary *)json{
    [super on:json];
    if (json[@"getContact"]) {
        getContactObject = json[@"getContact"];
        [self askPermission];
        data = [NSMutableString string];
        if (kABAuthorizationStatusNotDetermined == status) {
            ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
                if (granted){
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self getContacts];
                    });
                } else {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self notPermitted];
                    });
                }
            });
        } else if (kABAuthorizationStatusAuthorized == status) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self getContacts];
            });
        } else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self notPermitted];
            });
        }
    }
    if (json[@"getRecent"]) {
        // iOS为空
//        getRecentObject = json[@"getRecent"];
//        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:getRecentObject];
//        [dict setObject:@{@"callHistories":@[]} forKey:@"value"];
//        [self.controller on:dict];
    }
}

-(void)askPermission {
    status = ABAddressBookGetAuthorizationStatus();
    if (status == kABAuthorizationStatusDenied ||
        status == kABAuthorizationStatusRestricted){
        //1
        NSLog(@"Denied");
    } else if (status == kABAuthorizationStatusAuthorized){
        //2
        NSLog(@"Authorized");
    } else if (status == kABAuthorizationStatusNotDetermined) {
        //3
        NSLog(@"Not determined");
    }
}

-(void)notPermitted {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:getContactObject];
    [dict setObject:@{@"error":@"no permitted"} forKey:@"value"];
    [self.controller on:dict];

}

-(void)getContacts {
    NSMutableArray *contacts = [NSMutableArray array];
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    for (id record in allContacts){
        ABRecordRef thisContact = (__bridge ABRecordRef)record;

        NSString *compositeName = (__bridge NSString *)ABRecordCopyCompositeName(thisContact);

        if (!compositeName) {
            continue;
        }

        ABMultiValueRef phoneRecord = ABRecordCopyValue(thisContact, kABPersonPhoneProperty);
        int counts = (int)ABMultiValueGetCount(phoneRecord);
        for (int k = 0; k < counts; k++)
        {
            //获取电话Label
            NSString * phoneLabel = (__bridge NSString*)ABAddressBookCopyLocalizedLabel(ABMultiValueCopyLabelAtIndex(phoneRecord, k));
            //获取該Label下的电话值
            NSString * phoneNumber = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneRecord, k);
            if (!phoneLabel || !phoneNumber) {
                continue;
            }
//            phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
//            phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
//            phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
            [contacts addObject:@{@"name": compositeName, @"phone": phoneNumber}];
        }
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:getContactObject];
    [dict setObject:@{@"contacts":contacts} forKey:@"value"];
    [self.controller on:dict];
    DLog(@"getContacts");
}

@end

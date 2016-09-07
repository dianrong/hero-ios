//
//  HeroUploadItem.h
//  hero
//
//  Created by 朱成尧 on 5/5/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeroImageUploader.h"
@class HeroImageUploader;
@class HeroUploadItem;
@protocol HeroUploadItemDelegate <NSObject>
@optional

- (void)didUpdateItemUploadItem:(HeroUploadItem *)uploadItem;
- (void)didUploadItem:(HeroUploadItem *)uploadItem error:(NSError *)error;

@end

@interface HeroUploadItem : NSObject

@property (nonatomic) HeroImageUploader *uploader;
@property (nonatomic) NSURL *localImgURL;
@property (nonatomic) NSString *imgUrl;
@property (nonatomic) NSString *thumbImgUrl;
@property (nonatomic) NSString *docId;
@property (nonatomic) NSString *fileId;
@property (nonatomic) NSString *filename;
@property (nonatomic) NSString *createdDate;

@property (nonatomic, weak) id<HeroImageUploaderDelegate> delegate;
@property (nonatomic, weak) id<HeroUploadItemDelegate> itemDelegate;

@end

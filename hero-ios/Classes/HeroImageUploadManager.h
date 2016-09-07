//
//  HeroImageUploadManager.h
//  hero
//
//  Created by 朱成尧 on 5/5/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HeroImageUploader;
@protocol HeroImageUploaderDelegate;

@interface HeroImageUploadManager : NSObject

@property (nonatomic) NSUInteger uploadCount; // 队列中有的
@property (nonatomic) NSUInteger currentUploadCount; // 队列中真正上传中的

+ (instancetype)sharedInstance;

- (void)startUpload:(HeroImageUploader *)uploader;
- (void)setMaxConcurrentUploads:(NSInteger)max;
- (void)cancelAllUploads;
- (void)setOperationQueueName:(NSString *)name;

@end

//
//  HeroImageUploadManager.m
//  hero
//
//  Created by 朱成尧 on 5/5/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import "HeroImageUploadManager.h"
#import "HeroImageUploader.h"

@interface HeroImageUploadManager ()

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation HeroImageUploadManager

- (instancetype)init {
    if (self = [super init]) {
        self.operationQueue = [[NSOperationQueue alloc] init];
    }
    return self;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static id sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
        [sharedManager setOperationQueueName:@"HeroUploadManager_SharedInstance_Queue"];
    });
    return sharedManager;
}

- (void)setOperationQueueName:(NSString *)name {
    [self.operationQueue setName:name];
}

- (void)startUpload:(HeroImageUploader *)upload {
    [self.operationQueue addOperation:upload];
}

- (void)cancelAllUploads {
    for (HeroImageUploader *item in [self.operationQueue operations]) {
        [item cancel];
    }
}

- (void)setMaxConcurrentUploads:(NSInteger)max {
    [self.operationQueue setMaxConcurrentOperationCount:max];
}

- (NSUInteger)uploadCount {
    return [self.operationQueue operationCount];
}

- (NSUInteger)currentUploadCount {
    NSUInteger count = 0;
    for (HeroImageUploader *item in [self.operationQueue operations]) {
        if (item.state == HeroUploadStateUploading) {
            count++;
        }
    }
    return count;
}

@end

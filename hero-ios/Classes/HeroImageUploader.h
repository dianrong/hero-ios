//
//  HeroImageUploader.h
//  hero
//
//  Created by 朱成尧 on 5/5/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HeroUploadState){
    HeroUploadStateReady = 0,
    HeroUploadStateUploading = 1,
    HeroUploadStateUploaded = 2,
    HeroUploadStateCanceled = 3,
    HeroUploadStateFailed = 4,
};

@class HeroImageUploader;
@protocol HeroImageUploaderDelegate <NSObject>
@optional
- (void)upload:(HeroImageUploader *)uploader didSendFirstRespone:(NSURLResponse *)response;
- (void)upload:(HeroImageUploader *)uploader didSendData:(uint64_t)sendLength onTotal:(uint64_t)totalLength progress:(float)progress;
- (void)upload:(HeroImageUploader *)uploader didStopWithError:(NSError *)error;
- (void)upload:(HeroImageUploader *)uploader didFinishWithSuccessData:(id)data;


@end

@interface HeroImageUploader : NSOperation <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, weak) id<HeroImageUploaderDelegate> delegate;
@property (nonatomic) HeroUploadState state;
@property (nonatomic) float percentage;

- (instancetype)initWithURL:(NSURL *)URL data:(NSData *)data fileName:(NSString *)fileName delegate:(id)delegate;
- (void)cancel;

@end

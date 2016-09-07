//
//  HeroUploadItem.m
//  hero
//
//  Created by 朱成尧 on 5/5/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import "HeroUploadItem.h"

@implementation HeroUploadItem


- (void)upload:(HeroImageUploader *)uploader didSendFirstRespone:(NSURLResponse *)response {
    if ([self.delegate respondsToSelector:@selector(upload:didSendFirstRespone:)]) {
        [self.delegate upload:self didSendFirstRespone:response];
    }
}

- (void)upload:(HeroImageUploader *)uploader didSendData:(uint64_t)sendLength onTotal:(uint64_t)totalLength progress:(float)progress {
    if ([self.delegate respondsToSelector:@selector(upload:didSendData:onTotal:progress:)]) {
        [self.delegate upload:self didSendData:sendLength onTotal:totalLength progress:progress];
    }
}

- (void)upload:(HeroImageUploader *)uploader didStopWithError:(NSError *)error {
    if ([self.delegate respondsToSelector:@selector(upload:didStopWithError:)]) {
        [self.delegate upload:self didStopWithError:error];
    }
    if ([self.itemDelegate respondsToSelector:@selector(didUploadItem:error:)]) {
        [self.itemDelegate didUploadItem:self error:error];
    }
}

- (void)upload:(HeroImageUploader *)uploader didFinishWithSuccessData:(id)data {
    self.imgUrl = data[@"imageUrl"]?:@"";
    self.thumbImgUrl = data[@"thumbImgUrl"]?:@"";
    self.createdDate = data[@"createdDate"]?:@"";
    self.docId = data[@"docId"]?:@"";
    self.fileId = data[@"fileId"]?:@"";
    self.filename = data[@"filename"]?:@"";
    if ([self.itemDelegate respondsToSelector:@selector(didUpdateItemUploadItem:)]) {
        [self.itemDelegate didUpdateItemUploadItem:self];
    }
    if ([self.delegate respondsToSelector:@selector(upload:didFinishWithSuccessData:)]) {
        [self.delegate upload:self didFinishWithSuccessData:data];
    }
}

@end

//
//  HeroPhotoBrowerViewController.h
//  hero
//
//  Created by 朱成尧 on 5/5/16.
//  Copyright © 2016 Liu Guoping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeroPhotoBrowerViewController;
@protocol HeroPhotoBrowerDelegate <NSObject>
@required

- (BOOL)photoBrowser:(HeroPhotoBrowerViewController *)photoBrowser currentPhotoAssetURLIsSeleted:(NSURL *)assetURL;
- (void)photoBrowser:(HeroPhotoBrowerViewController *)photoBrowser seletedAssetURL:(NSURL *)assetURL;
- (void)photoBrowser:(HeroPhotoBrowerViewController *)photoBrowser deseletedAssetURL:(NSURL *)assetURL;

@end

@interface HeroPhotoBrowerViewController : UIViewController

@property (nonatomic, weak) id<HeroPhotoBrowerDelegate> delegate;

- (instancetype)initWithPhotos:(NSArray *)photoArray currentIndex:(NSInteger)index;

@end
